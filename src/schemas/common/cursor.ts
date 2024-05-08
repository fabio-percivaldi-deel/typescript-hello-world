import { createZodDto } from '@abitia/zod-dto';
import { z } from 'zod';

export const PaginatedListSchema = z.object({
  limit:         z.preprocess(Number, z.number().int().positive().min(1).max(100)).optional(),
  offset:        z.preprocess(Number, z.number().int().min(0)).optional(),
  lastId:        z.string().uuid().optional(),
  lastCreatedAt: z.coerce.date().optional()
});

export class PaginatedListSchemaDto extends createZodDto(PaginatedListSchema) {}
