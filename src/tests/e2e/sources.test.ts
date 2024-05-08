import E2ETester from '@tests/E2ETester';

describe('Sources E2E', () => {
  const e2e = new E2ETester();
  beforeAll(async () => {
    await e2e.beforeAll();
  });

  afterAll(async () => {
    await e2e.afterAll();
  });

  const sampleData = {
    firstName: 'Test',
    lastName: 'Testerson',
    middleName: 'Testing',
    preferredName: 'Tester',
    birthDate: '1990-01-01',
    nationality: 'US',
    addressId: 0,
    maritalStatus: 'Single',
    mobilePhone: '123456789',
    homePhone: null
  };

  describe('Create or update based on ID', () => {
    it(`Should return list of sources`, async () => {
      const response = await e2e.app.get('/sources');
      expect(response.statusCode).toBe(200);
      expect(response.body).toMatchObject([]);
    });
  });
});
