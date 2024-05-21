import 'reflect-metadata';

import * as Sentry from '@sentry/node';
import Config from '@services/config';
import SequelizeService, { initSequelizeService } from '@services/sequelize/Sequelize.service';
import { getDBConfig } from '@services/sequelize/utils';
import bodyParser from 'body-parser';
import express from 'express';
import { Server } from 'http';
import path from 'path';
import { useContainer, useExpressServer } from 'routing-controllers';
import { Container, Service } from 'typedi';
import { ErrorHandler } from '@middlewares/ErrorHandler';

@Service()
class App {
  public app!: express.Application;
  public port!: string | number;
  public env!: string;
  public container: any;
  private testOverrides!: Record<string, any>;
  private server!: Server;

  public async init(testOverrides: Record<string, any> = {}) {
    (BigInt.prototype as any).toJSON = function () {
      return this.toString();
    };
    this.testOverrides = testOverrides;
    this.container = this.testOverrides.schemaName ? Container.of(this.testOverrides.schemaName) : Container;
    if (this.testOverrides) {
      this.container.set('testOverrides', testOverrides);
      for (const [key, val] of Object.entries(testOverrides)) {
        this.container.set(key, val);
      }
    }
    await this.initializeSequelize();
    this.app = express();
    this.app.use(bodyParser.json({ limit: '10mb' }));
    this.app.set('trust proxy', true);
    this.app.get('/ping', (req, res) => res.send('pong'));
    this.app.get('/health', async (_req, res) => {
      try {
        const sequelize = Container.get(SequelizeService);

        await sequelize.query(`SELECT 1`);

        return res.send('ok');
      } catch (error) {
        log.debug(error);

        return res.status(500).send('ko');
      }
    });

    useContainer(this.container);
    useExpressServer(this.app, {
      controllers: [path.join(__dirname + '/controllers/**/*.controller.{j,t}s')],
      middlewares: [ErrorHandler],
      classTransformer: false,
      validation: false,
      defaultErrorHandler: false
    });
    this.port = process.env.PORT || 3000;
    this.env = process.env.NODE_ENV || 'development';
    this.initializeSentry();

    const gracefulShutdown = async () => {
      //Close any open connections here

      process.exit(0);
    };

    process.on('SIGTERM', gracefulShutdown);
    process.on('SIGINT', gracefulShutdown);
  }

  public listen() {
    this.server = this.app.listen(this.port, () => {
      log.info(`=================================`);
      log.info(`======= ENV: ${this.env} =======`);
      log.info(`🚀 App listening on the port ${this.port}`);
      log.info(`=================================`);
    });
  }

  public close() {
    this.server?.close();
  }

  public getServer() {
    return this.app;
  }

  private initializeSentry() {
    Sentry.init({
      tracesSampleRate: Number(Config.SENTRY_SAMPLING) || 0
    });
  }

  private async initializeSequelize() {
    try {
      const injectedSequelizeService: SequelizeService | undefined = this.container.get('testOverrides')?.sequelizeService;
      if (injectedSequelizeService) {
        await injectedSequelizeService.authenticate();
        this.container.set(SequelizeService, injectedSequelizeService);
        return;
      }
      const dbConfig = getDBConfig();
      const sequelizeService = injectedSequelizeService || initSequelizeService(dbConfig);
      await sequelizeService.authenticate();
      this.container.set(SequelizeService, sequelizeService);
    } catch (error) {
      log.error({
        message: 'Unable to connect to the database',
        error
      });
    }
  }
}

export default App;
