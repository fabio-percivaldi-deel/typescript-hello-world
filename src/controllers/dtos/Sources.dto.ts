import { createZodDto } from '@abitia/zod-dto';
import { z } from 'zod';
import { ZodSchemas } from '@letsdeel/employee-tribe-common';
import { Sources } from '@models/Sources.model';

export const allSourcesSchema = z.object({
  id: z.string().uuid(),
  sourceName: z.string()
});

export class AllSourcesDto extends createZodDto(allSourcesSchema) {}

export const sourceDTO = (source: Sources): AllSourcesDto => {
  return {
    id: source.publicId,
    sourceName: source.name
  };
};
