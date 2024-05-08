import SequelizeService, { initSequelizeService } from '@services/sequelize/Sequelize.service';
import { getDBConfig } from '@services/sequelize/utils';
import { S3ServiceMock } from '@tests/mocks/S3Service.mock';
import { execSync } from 'child_process';
import dayjs from 'dayjs';
import fs from 'fs';
import path from 'path';
import { performance } from 'perf_hooks';
import request from 'supertest';

import App from '../app';

export default class E2ETester {
  private readonly DB_URL: string;
  public readonly schema: string;
  public sequelizeService!: SequelizeService;
  public service!: App;
  public app!: request.Agent;
  testOverrides: Record<string, any> = {};

  constructor(testOverrides?: Record<string, any>) {
    this.schema = `test_${dayjs().format('YYYY_MM_DD_hh_mm_ss')}`;

    if (testOverrides) {
      this.testOverrides = testOverrides;
    }

    if (process.env.TEST_DATABASE_URL) {
      this.DB_URL = process.env.TEST_DATABASE_URL;
    } else {
      throw new Error('Missing TEST_DATABASE_URL env variable');
    }
  }

  async beforeAll() {
    const start = performance.now();

    const sequelizeServiceForSetup = new SequelizeService(getDBConfig());

    const urlWithSchema = new URL(this.DB_URL);
    urlWithSchema.searchParams.set('schema', this.schema);

    try {
      //Init DB
      const schemasFolder = path.resolve(__dirname, 'schemas');
      for (const schemaFile of fs.readdirSync(schemasFolder)) {
        const sqls = fs
          .readFileSync(path.resolve(schemasFolder, schemaFile), 'utf8')
          .split('\n')
          .filter((line) => line.indexOf('--') !== 0)
          .join('\n')
          .replace(/(\r\n|\n|\r)/gm, ' ') // remove newlines
          .replace(/\s+/g, ' ') // excess white space
          .split(';');

        for (const sql of sqls) {
          await sequelizeServiceForSetup.query(sql);
        }
      }

      const res = await sequelizeServiceForSetup.createSchema(this.schema, {});
      log.info(res);
      await sequelizeServiceForSetup.close();

      execSync(`DATABASE_URL="${urlWithSchema.toString()}" npm run migrations`, {
        stdio: undefined /* change it to 'inherit' if you want to debug migrations */
      });
      const durationMs = performance.now() - start;
      log.info(`ran migrations on schema ${this.schema} for ${Math.floor(durationMs)} ms, ${urlWithSchema} - ${process.env.TEST_DATABASE_URL}}`);

      const sequelizeService = initSequelizeService(getDBConfig(this.schema));
      this.sequelizeService = sequelizeService;

      //Init service
      this.service = new App();
      await this.service.init({
        schemaName: this.schema,
        sequelizeService: this.sequelizeService,
        s3Service: S3ServiceMock
      });
      this.app = request(this.service.getServer());
    } catch (err) {
      log.error(`Can not initialize sequelize: ${err}`);
      throw new Error('Can not initialize sequelize', { cause: err });
    }
  }

  async afterAll() {
    const sequelizeServiceForCleanup = new SequelizeService(getDBConfig());

    try {
      //Close DB
      await sequelizeServiceForCleanup.query(`DROP SCHEMA ${this.schema} CASCADE;`);
      await sequelizeServiceForCleanup.close();
      log.info(`dropped schema ${this.schema}`);
      await this.sequelizeService.close();

      //Close service
      this.service.close();
    } catch (err) {
      log.error('Can not close sequelize connection', err);
    }
  }
}
