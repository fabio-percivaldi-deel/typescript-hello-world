import { Op, Order } from 'sequelize';

type OrderType = 'DESC' | 'ASC';

/**
 * @description Returns where clause for sequelize query to get data with pagination cursor. We sort by createdAt DESC, and if there are multiple records with the same createdAt, we select the one with the "smallest" id (lexicographically). Adding a limit to the query will result in the last record being the "smallest" one.
 * @param lastId
 * @param lastCreatedAt
 * @param order
 */
export const getPaginationWhereClause = (lastId?: string, lastCreatedAt?: Date, order: OrderType = 'DESC') => {
  const whereConditions: Array<Record<string, unknown>> = [];

  if (!lastId && !lastCreatedAt) {
    return {};
  }

  if (lastCreatedAt) {
    const operator = order === 'DESC' ? Op.lt : Op.gt;

    whereConditions.push({
      createdAt: { [operator]: lastCreatedAt }
    });
  }

  if (lastId) {
    const operator = order === 'DESC' ? Op.lt : Op.gt;

    whereConditions.push({
      createdAt: lastCreatedAt,
      id:        { [operator]: lastId }
    });
  }

  return {
    [Op.or]: whereConditions
  };
};

/**
 * @description Returns order clause for sequelize query to get data with pagination cursor. We sort by createdAt DESC, and if there are multiple records with the same createdAt, we select the one with the "smallest" id (lexicographically). Adding a limit to the query will result in the last record being the "smallest" one.
 * @param order
 */
export const getPaginationOrderClause = (order: OrderType = 'DESC'): Order => {
  return [
    ['createdAt', order],
    ['id', order]
  ];
};

/**
 * @description Returns limit clause for sequelize query to get data with pagination cursor. We sort by createdAt DESC, and if there are multiple records with the same createdAt, we select the one with the "smallest" id (lexicographically). Adding a limit to the query will result in the last record being the "smallest" one.
 * @param limit
 */
export const getPaginationLimitClause = (limit?: number): number => {
  return limit || 100;
};
