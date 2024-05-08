export type MigrationFunc = (params: {
  queryInterface: import('sequelize').QueryInterface;
  sequelize: import('sequelize').Sequelize;
  Sequelize: typeof import('sequelize');
  schema: string;
}) => Promise<void>;

function dropQuotes(name: string) {
  return name.startsWith('"') && name.endsWith('"') ? name.slice(1, -1) : name;
}

function getName(name?: string) {
  if (name?.includes('.')) name = name.split('.').pop() as string;
  if (!name) throw new Error('Invalid name');
  return dropQuotes(name);
}

function getSchema(name?: string) {
  if (name?.includes('.')) name = name.split('.').shift() as string;
  if (!name) throw new Error('Invalid name');
  return dropQuotes(name);
}

function __getFullName({ schema, name }: { schema: string; name: string }) {
  const cleanSchema = getSchema(schema);
  const cleanName = getName(name);
  return { schema: cleanSchema, name: cleanName };
}

export function getFullName(schema: string, name: string): string {
  const { schema: cleanSchema, name: cleanName } = __getFullName({ schema, name });
  return `"${cleanSchema}"."${cleanName}"`;
}

function resolveLiteralValue(value: any): string {
  if (value === null) return 'NULL';
  switch (typeof value) {
    case 'number':
    case 'bigint':
      return value.toString(10);
    case 'boolean':
      return value ? 'TRUE' : 'FALSE';
    case 'string':
      return `'${value}'`;
    default:
      return String(value);
  }
}

export async function checkIfEnumAlreadyExists(
  sequelize: import('sequelize').Sequelize,
  params: { name: string; schema: string },
  options?: { transaction?: import('sequelize').Transaction }
): Promise<boolean> {
  const { name, schema } = __getFullName(params);

  const result: Awaited<any> = await sequelize.query(
    `
              SELECT
                  TRUE "ok"
              FROM
                  pg_type t
                  INNER JOIN pg_namespace n ON n.oid = t.typnamespace
              WHERE
                  t.typname = :name
                  AND n.nspname = :schema
          `,
    { ...options, replacements: { name, schema }, type: 'SELECT' }
  );
  return Boolean(result[0]?.ok);
}

export async function createEnum<T extends object>(
  sequelize: import('sequelize').Sequelize,
  params: { values: T; name: string; schema: string; ifNotExists?: boolean },
  options?: { transaction?: import('sequelize').Transaction }
): Promise<string> {
  const { values, name, schema, ifNotExists } = params;
  const enumName = getFullName(schema, name);

  if (ifNotExists) {
    const alreadyExists = await checkIfEnumAlreadyExists(sequelize, { schema, name }, options);
    if (alreadyExists) return enumName;
  }

  await sequelize.query(
    `
              CREATE TYPE ${enumName} AS ENUM(
                  ${Object.values(values)
                    .map((s) => `'${s}'`)
                    .join('\n,')}
              )
          `,
    options
  );
  return enumName;
}

export async function destroyEnum(
  sequelize: import('sequelize').Sequelize,
  params: { schema: string; name: string; ifExists?: boolean },
  options?: { transaction?: import('sequelize').Transaction }
): Promise<void> {
  const enumName = getFullName(params.schema, params.name);
  await sequelize.query(`DROP TYPE ${params.ifExists ? 'IF EXISTS' : ''} ${enumName}`, options);
}

export async function findEnumName(
  sequelize: import('sequelize').Sequelize,
  params: { schema: string; tableName: string; columnName: string },
  options?: { transaction?: import('sequelize').Transaction }
): Promise<string> {
  const { schema, tableName, columnName } = params;
  const result = await sequelize.query(
    `
          SELECT
              c.udt_name "enumName"
          FROM
              information_schema.columns c
          WHERE
              c.table_schema = :schema
              AND c."table_name" = :tableName
              AND c."column_name" = :columnName
              AND c.data_type = 'USER-DEFINED'
              AND c.udt_name IS NOT NULL
          `,
    { ...options, replacements: { schema, tableName, columnName }, type: 'SELECT' }
  );
  const enumName = (result[0] as any)?.enumName as string | undefined;
  if (!enumName) throw new Error(`Column "${columnName}" from relation "${schema}"."${tableName}" is not an enum`);
  return getFullName(schema, enumName);
}

export async function renameEnum(
  sequelize: import('sequelize').Sequelize,
  params: { oldName: string; newName: string; schema: string },
  options?: { transaction?: import('sequelize').Transaction }
): Promise<string> {
  const enumName = getFullName(params.schema, params.oldName);
  await sequelize.query(`ALTER TYPE ${enumName} RENAME TO "${params.newName}"`, options);
  return getFullName(params.schema, params.newName);
}

export async function alterColumnToEnumType(
  sequelize: import('sequelize').Sequelize,
  params: { schema: string; tableName: string; columnName: string; enumName: string; usingClause?: string },
  options?: { transaction?: import('sequelize').Transaction }
) {
  const tableName = getFullName(params.schema, params.tableName);
  const enumName = getFullName(params.schema, params.enumName);
  const { columnName } = params;
  const defaultUsingClause = `("${columnName}"::text::${enumName})`;
  const usingClause = params.usingClause ? params.usingClause.replace(/\$default/g, defaultUsingClause) : defaultUsingClause;

  return await sequelize.query(`ALTER TABLE ${tableName} ALTER COLUMN "${columnName}" SET DATA TYPE ${enumName} USING ${usingClause}`, options);
}

export async function commentOnTable(
  sequelize: import('sequelize').Sequelize,
  params: { schema: string; tableName: string; comment: string },
  options?: { transaction?: import('sequelize').Transaction }
) {
  const tableName = getFullName(params.schema, params.tableName);
  return await sequelize.query(
    `
          COMMENT ON TABLE
              ${tableName}
          IS
              :comment
          `,
    {
      ...(options || {}),
      replacements: { comment: params.comment }
    }
  );
}

export async function commentOnColumn(
  sequelize: import('sequelize').Sequelize,
  params: { schema: string; tableName: string; columnName: string; comment: string },
  options?: { transaction?: import('sequelize').Transaction }
) {
  const tableName = getFullName(params.schema, params.tableName);
  return await sequelize.query(
    `
          COMMENT ON COLUMN
              ${tableName}."${params.columnName}"
          IS
              :comment
          `,
    {
      ...(options || {}),
      replacements: { comment: params.comment }
    }
  );
}

export async function dropIndex(
  sequelize: import('sequelize').Sequelize,
  params: { schema: string; indexName: string },
  options?: { transaction?: import('sequelize').Transaction }
) {
  const indexName = getFullName(params.schema, params.indexName);
  return await sequelize.query(`DROP INDEX IF EXISTS ${indexName}`, options);
}

export async function alterColumnToUnique(
  sequelize: import('sequelize').Sequelize,
  params: { schema: string; tableName: string; columnName: string },
  options?: { transaction?: import('sequelize').Transaction }
) {
  const tableName = getFullName(params.schema, params.tableName);
  return await sequelize.query(`ALTER TABLE ${tableName} ADD UNIQUE ("${params.columnName}")`, options);
}

export async function alterTableDropConstraint(
  sequelize: import('sequelize').Sequelize,
  params: { schema: string; tableName: string; constraintName: string },
  options?: { transaction?: import('sequelize').Transaction }
) {
  const tableName = getFullName(params.schema, params.tableName);
  return await sequelize.query(`ALTER TABLE ${tableName} DROP CONSTRAINT IF EXISTS "${params.constraintName}")`, options);
}

export async function alterColumnChangeNullable(
  sequelize: import('sequelize').Sequelize,
  params: { schema: string; tableName: string; columnName: string; allowNull: boolean },
  options?: { transaction?: import('sequelize').Transaction }
) {
  const tableName = getFullName(params.schema, params.tableName);
  return await sequelize.query(`ALTER TABLE ${tableName} ALTER COLUMN "${params.columnName}" ${params.allowNull ? 'DROP' : 'SET'} NOT NULL`, options);
}

export async function alterColumnDefaultValue(
  sequelize: import('sequelize').Sequelize,
  params: { schema: string; tableName: string; columnName: string; defaultValue?: any },
  options?: { transaction?: import('sequelize').Transaction }
) {
  const tableName = getFullName(params.schema, params.tableName);
  const setDefaultValue = params.defaultValue === undefined ? 'DROP DEFAULT' : `SET DEFAULT ${resolveLiteralValue(params.defaultValue)}`;
  return await sequelize.query(`ALTER TABLE ${tableName} ALTER COLUMN "${params.columnName}" ${setDefaultValue}`, options);
}

export async function alterColumnToType(
  sequelize: import('sequelize').Sequelize,
  params: { schema: string; tableName: string; columnName: string; columnType: string },
  options?: { transaction?: import('sequelize').Transaction }
) {
  const tableName = getFullName(params.schema, params.tableName);
  return await sequelize.query(`ALTER TABLE ${tableName} ALTER COLUMN "${params.columnName}" TYPE "${params.columnType}"`, options);
}

export async function recreateForeignKeyConstraint(
  sequelize: import('sequelize').Sequelize,
  params: {
    schema: string;
    tableName: string;
    constraintName: string;
    fields: string[];
    references: {
      table: import('sequelize').TableName;
      field: string;
    };
    onDelete?: 'CASCADE' | 'SET NULL' | 'SET DEFAULT' | 'RESTRICT';
    onUpdate?: 'CASCADE' | 'SET NULL' | 'SET DEFAULT' | 'NO ACTION' | 'RESTRICT';
  },
  options?: { transaction?: import('sequelize').Transaction }
) {
  const { schema, tableName, constraintName, fields, references, onDelete = 'SET NULL', onUpdate = 'NO ACTION' } = params;
  const queryInterface = sequelize.getQueryInterface();
  await queryInterface.removeConstraint({ schema, tableName }, constraintName, options);
  await queryInterface.addConstraint(
    { schema, tableName },
    {
      type: 'foreign key',
      name: constraintName,
      references,
      fields,
      onDelete,
      onUpdate,
      transaction: options?.transaction
    }
  );
}

export default function () {
  return;
}
