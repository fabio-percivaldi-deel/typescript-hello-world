module.exports = {
  transform: {
    '^.+\\.(t|j)sx?$': '@swc/jest'
  },
  testEnvironment: 'node',
  roots: ['src'],
  moduleNameMapper: {
    '^@controllers/(.*)$': '<rootDir>/src/$1',
    '^@models/(.*)$': '<rootDir>/src/$1',
    '^@repositories/(.*)$': '<rootDir>/src/$1',
    '^@decorators/(.*)$': '<rootDir>/src/decorators/$1',
    '^@middlewares/(.*)$': '<rootDir>/src/$1',
    '^@services/(.*)$': '<rootDir>/src/$1',
    '^@utils/(.*)$': '<rootDir>/src/$1',
    '^@constants/(.*)$': '<rootDir>/src/$1',
    '^@tests/(.*)$': '<rootDir>/src/$1',
    '^@tasks/(.*)$': '<rootDir>/src/$1',
    '^@serializers/(.*)$': '<rootDir>/src/$1'
  },
  setupFiles: ['./.jest/setEnvVars.js', './node_modules/@letsdeel/init/index.js', 'reflect-metadata', 'dotenv-expand/config'],
  setupFilesAfterEnv: ['./.jest/setup.ts'],
  testTimeout: 15000,
  reporters: [
    'default',
    [
      'jest-html-reporters',
      {
        publicPath: './results/html-reports',
        filename: 'index.html',
        openReport: false
      }
    ]
  ]
};
