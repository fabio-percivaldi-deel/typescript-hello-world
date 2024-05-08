/* eslint-disable no-console */

import fs from 'fs';
import path from 'path';
import Sequelize from 'sequelize';
import { pathToFileURL } from 'url';

import { MigrationFunc } from './migrations/index.js';

type SequelizeMetaModel = Sequelize.Model<{ name: string }>;
type SequelizeMetaModelStatic = Sequelize.ModelStatic<SequelizeMetaModel>;

const isMainModule = pathToFileURL(__filename).toString().startsWith('file:') && process.argv[1] === __filename;

try {
  Object.assign(process.env, Object.assign(JSON.parse(fs.readFileSync('/var/secrets/secrets.json', 'utf8')), process.env));
} catch (err: any) {
  if (err.code != 'ENOENT') throw err;
}

const codeFilesPattern = new RegExp(/\.(js|ts|cjs|mjs)$/i);
const ignoredFilesPattern = new RegExp(/\.(test|spec|d)\./i);
const isValidCodeFile = (filename: string) => codeFilesPattern.test(filename) && !ignoredFilesPattern.test(filename);

const migrate = async (fullUrl?: string) => {
  fullUrl ||= process.env.DATABASE_URL;
  if (!fullUrl) throw new Error('Please set env var DATABASE_URL before running this script');
  const [url, schema = 'swagger'] = fullUrl.split('?schema=');

  const sequelize = new Sequelize.Sequelize(url, {
    schema,
    define: { timestamps: false },
    pool: { max: 1, acquire: 20000 },
    logging: (sql) => console.info(sql)
  });

  await sequelize.query(`CREATE SCHEMA IF NOT EXISTS ${schema}`);

  const SequelizeMeta: SequelizeMetaModelStatic = sequelize.define('SequelizeMeta', { name: { type: Sequelize.STRING, primaryKey: true } }, { schema });
  await SequelizeMeta.sync();

  const migrationsDir = path.resolve(path.dirname(__filename), './migrations');
  const files = new Set(fs.readdirSync(migrationsDir, 'utf8').filter((filename) => isValidCodeFile(filename)));
  const meta = new Set<string>(
    await (async () => {
      const entries: Array<{ name: string }> = (await SequelizeMeta.findAll({
        logging: false,
        attributes: ['name'],
        raw: true,
        order: [['name', 'ASC']]
      })) as any;
      return entries.map((m) => m.name);
    })()
  );

  try {
    for (const name of Array.from(files).filter((name) => !meta.has(name))) {
      console.log(name);
      const resolvedFileName = path.resolve(migrationsDir, name);
      console.info('Running migration for', resolvedFileName);
      const module = await import(resolvedFileName);
      const migration: MigrationFunc = module.default;
      if (migration) {
        await migration({ queryInterface: sequelize.getQueryInterface(), Sequelize, sequelize, schema });
      }
      await SequelizeMeta.create({ name });
    }

    const unusedMigrations = [...meta].filter((name) => !files.has(name));
    if (unusedMigrations.length) {
      await SequelizeMeta.destroy({ where: { name: unusedMigrations } });
    }
  } finally {
    await sequelize.close();
  }
};

export default async (url?: string) => await migrate(url);

if (isMainModule) {
  migrate(process.env.DATABASE_URL)
    .then(() => {
      console.info('Migrations completed');
    })
    .catch((err) => {
      console.error(err);
    });
}
