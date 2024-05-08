import { Service } from 'typedi';
import Config from './config/Config.service';
import SourcesRepository from '@repositories/Sources.repository';
@Service()
export class SourcesService {
  constructor(
    protected configService: Config,
    private sourcesRepository: SourcesRepository
  ) {}

  async getSources() {
    return await this.sourcesRepository.getAllSources();
  }
}
