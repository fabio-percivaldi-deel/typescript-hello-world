import E2ETester from '@tests/E2ETester';
import { Sources } from '@models/Sources.model';

describe('Sources E2E', () => {
  const e2e = new E2ETester();
  beforeAll(async () => {
    await e2e.beforeAll();
  });

  afterAll(async () => {
    await e2e.afterAll();
  });

  beforeEach(async () => {
    await Sources.destroy({ where: {} });
  });

  describe('Listing all sources', () => {
    it(`Should return list of sources`, async () => {
      Sources.bulkCreate(['source1', 'source2', 'source3'].map((name) => ({ name })));

      const response = await e2e.app.get('/sources');

      expect(response.statusCode).toBe(200);
      expect(response.body).toMatchObject([
        {
          id: expect.any(String),
          sourceName: 'source1'
        },
        {
          id: expect.any(String),
          sourceName: 'source2'
        },
        {
          id: expect.any(String),
          sourceName: 'source3'
        }
      ]);
    });

    it(`Should return empty list if there are no sources in db`, async () => {
      const response = await e2e.app.get('/sources');

      expect(response.statusCode).toBe(200);
      expect(response.body).toMatchObject([]);
    });
  });
});
