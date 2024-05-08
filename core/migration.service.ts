/* eslint-disable @typescript-eslint/no-var-requires */
import fs from 'fs';
import path from 'path';
import { DataTypes, ModelStatic, Sequelize } from 'sequelize';

export class MigrationService {
  private sequelize: Sequelize;

  private SequelizeMeta: ModelStatic<any>;

  private runningOnTypescript = fs.existsSync(path.resolve(__dirname, '../node_modules/typescript'));

  private fileExtension = this.runningOnTypescript ? '.ts' : '.js';

  constructor(url: string, private schema: string = 'benefits', private migrationPath: string = '../migrations') {
    this.sequelize = new Sequelize(url, {
      schema,
      dialect:        'postgres',
      define:  { timestamps: false },
      pool:    { max: 1, acquire: 20000 },
      logging: (sql) => console.info(sql)
    });
    this.SequelizeMeta = this.sequelize.define('sequelize_meta', { name: { type: DataTypes.STRING, primaryKey: true } }, {});
  }

  private getMigrationFiles(): string[] {
    return fs.readdirSync(path.resolve(__dirname, this.migrationPath), 'utf8')
      .filter((filename) => filename.endsWith(this.fileExtension))
      .map((filename) => filename.replace(this.fileExtension, ''));
  }

  async migrate() {
    try {
      await this.sequelize.authenticate({ logging: false });
      await this.sequelize.createSchema(this.schema, { logging: false });
      await this.sequelize.sync({ logging: false });

      const files = this.getMigrationFiles();

      await this.runMigrations(files);
    } catch (err) {
      console.error(err);
    } finally {
      await this.sequelize.close();
    }
  }

  async rollback({ count = 1, fileName }: { count?: number, fileName?: string } = {}) {
    try {
      await this.sequelize.authenticate({ logging: false });
      await this.sequelize.createSchema(this.schema, { logging: false });
      await this.sequelize.sync({ logging: false });

      const lastMigrations = await this.SequelizeMeta.findAll({
        where:      fileName ? { name: fileName } : {},
        order:      [['name', 'DESC']],
        limit:      count,
        attributes: ['name'],
        useMaster:  false,
        logging:    false,
        raw:        true
      });
      const fileNames = lastMigrations.map(({ name }: any) => name.replace(this.fileExtension, ''));

      await this.undoMigration(fileNames);
    } catch (err) {
      console.error(err);
    } finally {
      await this.sequelize.close();
    }
  }

  private async runMigrations(names: string[]) {
    const migratedFiles = await this.SequelizeMeta.findAll({
      attributes: ['name'],
      useMaster:  false,
      logging:    false
    });
    const migratedFileNames = new Set<string>(migratedFiles.map(({ name }: any) => name));

    const migrationsToRun = names.filter((fileName) => !migratedFileNames.has(fileName)).sort();
    if (!migrationsToRun.length) {
      console.info('Everything is up to date.');
      return;
    }

    for (const fileName of migrationsToRun) {
      const resolved = require.resolve(`${this.migrationPath}/${fileName}${this.fileExtension}`);

      console.info('running migration for', fileName);

      await require(resolved).up(this.sequelize.getQueryInterface());

      await this.SequelizeMeta.create({ name: fileName }, { logging: false });
      delete require.cache[resolved];
    }

    const fileNames = new Set<string>(names);
    const namesToRemove = Array.from(migratedFileNames).filter((name) => !fileNames.has(name));
    if (namesToRemove.length) {
      await this.SequelizeMeta.destroy({ where: { name: namesToRemove }, logging: false });
    }
  }

  private async undoMigration(fileNames: string[]) {
    for (const fileName of fileNames) {
      const resolved = require.resolve(`${this.migrationPath}/${fileName}${this.fileExtension}`);
      console.info('running rollback migration for', fileName);

      await require(resolved).down(this.sequelize.getQueryInterface());

      await this.SequelizeMeta.destroy({ where: { name: fileName }, logging: false });
      delete require.cache[resolved];
    }
  }

}
