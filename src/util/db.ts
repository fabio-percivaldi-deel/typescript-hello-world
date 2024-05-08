import path from 'path';
import { Sequelize } from 'sequelize-typescript';
import { name as pkgName } from '../../package.json';

// this is an internal dependency of sequelize, we need it to patch "acquire" logic
const SequelizePool = require('sequelize-pool'); // eslint-disable-line @typescript-eslint/no-var-requires

const schema = 'public';

// Audit and connection pool setup
  (({ Pool }) => {
    const { acquire } = Pool.prototype;
    Pool.prototype.acquire = async function () {
      const client = await acquire.call(this);
      const { auditURL, auditUserData, ip } = asyncContext;
      // This is needed for audit purpose and is relevant for write queries only
      // Relies on how Sequelize configures pool with replication: https://github.com/sequelize/sequelize/blob/fd4afa6a89c111c6d6d0c94f0b98bf421b5357b6/src/dialects/abstract/connection-manager.js#L216
      // Without replication there will be single pool and queryType will always be undefined

      if (client.queryType === undefined || client.queryType === 'write') {
        await client.query(
          "SELECT set_config('SESSION.url',$1,FALSE), set_config('SESSION.username',$2,FALSE), set_config('SESSION.ip',$3,FALSE)",
          [auditURL, [auditUserData?.email, auditUserData?.admin].filter(Boolean).join(' by '), ip].map((s) => s || null)
        );
      }
      if (process.env.SKIP_AUDIT) {
        await client.query("SELECT set_config('SESSION.skip_audit','true',FALSE)");
      }
      return client;
    };
  })(SequelizePool);

const sequelize: Sequelize = new Sequelize(`${process.env.DATABASE_URL}`, {
  schema,
  logging: (sql, elapsed) => {
    if (elapsed != undefined && elapsed > 3000) {
      log.warn({ msg: `SLOW QUERY (${elapsed}ms), (${asyncContext.url || asyncContext.sqs || asyncContext.cronTask}) - ${sql}` });
    }

    if (process.env.SEQUELIZE_LOG_QUERIES === 'true') {
      log.info({ msg: `(${asyncContext.url || asyncContext.sqs || asyncContext.cronTask}) - ${sql}` });
    }
  },
  benchmark: !__DEV__,
  define:    { charset: 'utf8', underscored: true },
  pool:      {
    max:     5,
    acquire: 30000,
    idle:    60000
  },
  hooks: {
    afterConnect: async (connection) => {
      const { _HANDLER: context } = process.env;
      if (!context || !connection) return;
      await (connection as Sequelize).query(`SET session.context TO '${context}'`);
    }
  },
  dialect:        'postgres',
  dialectOptions: {
    application_name: process.argv[1].match(/server\.[jt]s/) ? pkgName : `${pkgName}::${process.argv[2]}`
  },
  models: [path.resolve(__dirname, '../models'), path.resolve(__dirname, '../modules/sftp/models')]
});

export { sequelize, Sequelize };
