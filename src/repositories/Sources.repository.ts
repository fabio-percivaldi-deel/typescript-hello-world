import { Service } from 'typedi';
import { Sources } from '@models/Sources.model';

@Service()
export default class SourcesRepository {
  async getAllSources() {
    return await Sources.findAll();
  }
}
