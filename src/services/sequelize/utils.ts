import Config from '@services/config';
import * as glob from 'glob';
import * as path from 'path';
import { Sequelize } from 'sequelize-typescript';
import { SequelizeOptions } from 'sequelize-typescript';

const defaultApplicationName = process.argv[1].includes('server') ? 'swagger' : `swagger::${process.argv[2]}`;

const buildDBUrl = (dbUrl: string, poolSize = 15, poolTimeOut = 10, applicationName = defaultApplicationName) => {
  const url = new URL(dbUrl);

  // for the transition period while we change all secrets it should fall back to the hardcoded schema
  if (!url.searchParams.has('schema')) {
    log.warn({ url: dbUrl }, `Schema is missing in DB url.`);
    url.searchParams.set('schema', 'swagger');
  }

  url.searchParams.set('connection_limit', poolSize.toString());
  url.searchParams.set('pool_timeout', poolTimeOut.toString());
  url.searchParams.set('application_name', applicationName);

  return url.toString();
};

const getDBConfig = (schema?: string): SequelizeOptions => {
  const dbUrl = process.env.TEST && process.env.TEST_DATABASE_URL ? process.env.TEST_DATABASE_URL : Config.DATABASE_URL;
  const url = new URL(buildDBUrl(dbUrl, Config.DATABASE_POOL_SIZE, Config.DATABASE_POOL_TIMEOUT));

  const dbSchema = schema || url.searchParams.get('schema');
  if (!dbSchema) {
    throw new Error('DB schema not found');
  }
  const replicationParams = url.searchParams.get('replication');
  const replication = replicationParams
    ? {
        read: replicationParams.split(',').map((host) => ({ host })),
        write: {}
      }
    : undefined;

  const connectionLimit = url.searchParams.get('connection_limit');
  return {
    host: url.hostname,
    database: url.pathname.replace(/^\//, ''),
    dialect: url.protocol.replace(/:$/, '') as 'postgres',
    schema: dbSchema,
    username: url.username,
    password: url.password,
    logging: false,
    pool: {
      max: connectionLimit ? Number(connectionLimit) : 5,
      acquire: 20000,
      idle: 60000
    },
    ...(replication && { replication })
  };
};

const loadModels = (sequelize: Sequelize) => {
  const models = [];
  const modelFiles = glob.globSync(path.join(__dirname, '../../models/**/*.{ts,js}'));
  for (const file of modelFiles) {
    const modelFile = require(file);
    for (const key in modelFile) {
      //Filter out any exported enums
      if (typeof modelFile[key] === 'function') {
        models.push(modelFile[key]);
      }
    }
  }
  try {
    sequelize.addModels(models);
  } catch (error) {
    console.log(error);
  }
};

export { buildDBUrl, getDBConfig, loadModels };
