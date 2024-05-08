import { MigrationFunc } from './index.js';

/**
 * Please follow best practices https://wiki.deel.network/en/deel-workspace/engineering/teams/database/postgres/DB-Best-Practices
 */

const migration: MigrationFunc = async ({ queryInterface, sequelize, Sequelize, schema }) => {
  await sequelize.transaction(async (transaction) => {
    const { DataTypes } = Sequelize;

    await queryInterface.createTable(
      { schema, tableName: 'sources' },
      {
        id: {
          type: DataTypes.INTEGER,
          primaryKey: true,
          autoIncrement: true,
          comment: 'Sequential primary key for the table.'
        },
        public_id: {
          type: DataTypes.UUID,
          unique: true,
          defaultValue: Sequelize.literal('gen_random_uuid()'),
          comment: 'Unique public uuid identifier.'
        },
        name: {
          type: DataTypes.STRING,
          allowNull: false
        },
        created_at: {
          type: DataTypes.DATE,
          allowNull: false,
          defaultValue: Sequelize.fn('NOW'),
          comment: 'Timestamp of when the record was created.'
        },
        updated_at: {
          type: DataTypes.DATE,
          allowNull: false,
          defaultValue: Sequelize.fn('NOW'),
          comment: 'Timestamp of when the record was last updated.'
        }
      },
      { transaction }
    );
  });
};

export default migration;
