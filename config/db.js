require('dotenv/config');

const options = {
  url:                         process.env.DATABASE_URL,
  dialect:                     'postgres',
  migrationStorageTableSchema: 'benefits',
  searchPath:                  'benefits',
  dialectOptions:              {
    prependSearchPath: true
  }
};

module.exports = {
  development: options,
  production:  options
};
