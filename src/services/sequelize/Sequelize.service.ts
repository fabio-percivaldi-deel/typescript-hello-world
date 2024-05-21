// this is an internal dependency of sequelize, we need it to patch "acquire" logic
import * as SequelizePool from 'sequelize-pool';
import { Sequelize, SequelizeOptions } from 'sequelize-typescript';
const pkgName = 'swagger';
import { ConnectionAcquireTimeoutError } from 'sequelize';
import { Connection, GetConnectionOptions } from 'sequelize/types/dialects/abstract/connection-manager';
import { Service } from 'typedi';

import { loadModels } from './utils';

export const initSequelizeService = (options: SequelizeOptions) => {
  ((p) => {
    const { acquire } = p.prototype;
    p.prototype.acquire = async function () {
      const client = await acquire.call(this);
      const { ip, auditURL, user } = asyncContext;
      // this is needed for audit purpose and is relevant for write queries only
      // relies on how Sequelize configures pool with replication: https://github.com/sequelize/sequelize/blob/fd4afa6a89c111c6d6d0c94f0b98bf421b5357b6/src/dialects/abstract/connection-manager.js#L216
      // without replication there will be single pool and queryType will always be undefined
      if (client.queryType === undefined || client.queryType === 'write') {
        await client.query(
          "SELECT set_config('SESSION.url',$1,FALSE), set_config('SESSION.username',$2,FALSE), set_config('SESSION.ip',$3,FALSE)",
          [auditURL, [user?.email, user?.isAdmin ? user?.email : null].filter(Boolean).join(' by '), ip].map((s) => s || null)
        );
      }
      return client;
    };
  })(SequelizePool.Pool);

  const sequelizeService = new SequelizeService({
    ...options,
    dialectOptions: {
      // when entry file is server application name in the connection is backend, otherwise it gets the argv[2] which will be a task name - backend::syncThings
      // cron name is passed here https://github.com/letsdeel/backend/blob/0de3c5d2a52dc289704c7e95bbe006ef26801788/.helm/templates/cronjob.yaml#L42
      application_name: process.argv[1].includes('server.js') ? pkgName : `${pkgName}::${process.argv[2]}`
    },
    hooks: {
      afterConnect: async (connection: any) => {
        const { _HANDLER: context } = process.env;
        if (!context) return;
        await connection.query(`SET session.context TO '${context}'`);
      }
    },
    minifyAliases: true
  });

  type DeelConnectionItem = Connection & {
    __deel?: {
      context: any;
      timestamp: any;
      stack: any;
    };
  };

  ((connectionManager) => {
    const connections = new Set();
    const readOnlyConnections = new Set();
    const { getConnection, releaseConnection } = connectionManager;
    Object.assign(connectionManager, {
      async getConnection(queryOptions: GetConnectionOptions) {
        try {
          queryOptions = { useMaster: true, ...queryOptions };

          const connection = (await getConnection.apply(this, [queryOptions])) as DeelConnectionItem;
          connection.__deel = {
            context: asyncContext,
            timestamp: Date.now(),
            stack: new Error().stack
          };
          if (queryOptions.useMaster) {
            connections.add(connection);
            if (connections.size > (sequelizeService?.config?.pool?.max ?? 100)) {
              log.error(`too many connections current size: ${connections.size}, max: ${sequelizeService?.config?.pool?.max} to MASTER.`);
            }
          } else {
            readOnlyConnections.add(connection);
            if (readOnlyConnections.size > (sequelizeService?.config?.pool?.max ?? 100)) {
              log.error(`too many connections current size: ${readOnlyConnections.size}, max: ${sequelizeService?.config?.pool?.max} to REPLICA.`);
            }
          }
          return connection;
        } catch (err) {
          if (err instanceof ConnectionAcquireTimeoutError) {
            log.warn({
              msg: 'ConnectionAcquireTimeoutError',
              connections
            });
          }
          throw err;
        }
      },
      async releaseConnection(connection: DeelConnectionItem) {
        delete connection.__deel;
        connections.delete(connection);
        readOnlyConnections.delete(connection);
        // eslint-disable-next-line prefer-rest-params
        return await releaseConnection.apply(this, arguments as any);
      }
    });
  })(sequelizeService.connectionManager);

  loadModels(sequelizeService);
  return sequelizeService;
};

@Service()
class SequelizeService extends Sequelize {}

export default SequelizeService;
