import { Service } from 'typedi';

import config from './config.json';

/**
 * If you add smth here, add it to .env.example in the project root
 */
@Service()
class Config {
  static get SENTRY_SAMPLING() {
    return process.env.SENTRY_SAMPLING ? Number(process.env.SENTRY_SAMPLING) : config['SENTRY_SAMPLING'];
  }
  static get DATABASE_URL(): string {
    return process.env.DATABASE_URL as string;
  }
  static get DATABASE_POOL_SIZE(): number {
    return process.env.DATABASE_POOL_SIZE ? Number(process.env.DATABASE_POOL_SIZE) : config['DATABASE_POOL_SIZE'];
  }
  static get DATABASE_POOL_TIMEOUT(): number {
    return process.env.DATABASE_POOL_TIMEOUT ? Number(process.env.DATABASE_POOL_TIMEOUT) : config['DATABASE_POOL_TIMEOUT'];
  }
  static get PORT(): number {
    return (process.env.PORT && Number(process.env.PORT)) || config['PORT'];
  }
  static get STAGE(): 'dev' | 'demo' | 'prod' {
    return (process.env.STAGE as 'dev' | 'demo' | 'prod') || config['STAGE'];
  }
  static get NODE_ENV(): string {
    return process.env.NODE_ENV || config['NODE_ENV'];
  }
  static get INTERNAL_SECRET(): string {
    return process.env.INTERNAL_SECRET || config['INTERNAL_SECRET'];
  }
  static get EMPLOYMENT_URL(): string {
    return process.env.EMPLOYMENT_URL || config['EMPLOYMENT_URL'];
  }
  static get BACKEND_URL(): string {
    // eslint-disable-next-line @typescript-eslint/no-non-null-assertion
    return process.env.BACKEND_URL!;
  }
  static get DEEL_AUTH_URL(): string {
    return `${Config.BACKEND_URL}/internal/employee/auth`;
  }
  static get S3_DIR(): string {
    return `swagger-${Config.STAGE}`;
  }
  static get S3_BUCKET(): string {
    return process.env.BUCKET as string;
  }
  static get RABBITMQ_URL(): string {
    return process.env.RABBITMQ_URL || config['RABBITMQ_URL'];
  }
  static get RABBITMQ_QUEUE(): string {
    return process.env.RABBITMQ_QUEUE || config['RABBITMQ_QUEUE'];
  }
  static get NATS_URL(): string {
    return process.env.NATS_URL as string;
  }
  static get NATS_USER(): string {
    return process.env.NATS_USER as string;
  }
  static get NATS_PASSWORD(): string {
    return process.env.NATS_PASSWORD as string;
  }
  static get UPLOAD_SERVICE_URL(): string {
    return process.env.UPLOAD_SERVICE_URL || config['UPLOAD_SERVICE_URL'];
  }
}

export default Config;
