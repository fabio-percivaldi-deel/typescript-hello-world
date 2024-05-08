import { User } from '@letsdeel/employee-tribe-common';
import { Logger } from 'pino';

declare global {
  const log: Logger;
  const asyncContext: any;
  const __DEV__: boolean;
}

export {};

declare global {
  namespace Express {
    interface Request {
      user: User;
    }
  }
}
