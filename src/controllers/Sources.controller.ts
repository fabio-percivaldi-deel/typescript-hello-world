import { Service } from 'typedi';

import { SourcesService } from '../services/Sources.service';
import { Get, JsonController, QueryParams } from 'routing-controllers';
import { AllSourcesDto, sourceDTO } from '../controllers/dtos/Sources.dto';

@JsonController('/sources')
@Service()
export default class SourcesController {
  constructor(private sourcesService: SourcesService) {}

  @Get('/')
  async getAll(): Promise<AllSourcesDto[]> {
    const allSources = await this.sourcesService.getSources();

    const sources = allSources.map(sourceDTO);

    return sources;
  }
}
