import { Validate } from '@letsdeel/employee-tribe-common';
import { z } from 'zod';
import { ZodTypeAny } from 'zod/lib/types';
import { Model } from 'sequelize-typescript';

export type IdType = 'number' | 'string' | 'uuid';
const typeSchemaMap: Map<IdType, ZodTypeAny> = new Map<IdType, ZodTypeAny>([
  ['number', z.coerce.number()],
  ['string', z.string()],
  ['uuid', z.string().uuid()]
]);

// eslint-disable-next-line @typescript-eslint/no-non-null-assertion
export const ValidateId = (idType: IdType) => Validate(z.object({ id: typeSchemaMap.get(idType)! }), 'params');
