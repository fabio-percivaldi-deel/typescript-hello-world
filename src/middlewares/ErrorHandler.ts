import * as Sentry from '@sentry/node';
import { NextFunction, Request, Response } from 'express';
import { ExpressErrorMiddlewareInterface, HttpError, Middleware } from 'routing-controllers';
import { Service } from 'typedi';

@Middleware({ type: 'after' })
@Service()
export class ErrorHandler implements ExpressErrorMiddlewareInterface {
  error(err: Error, req: Request, res: Response, _next: NextFunction) {
    Sentry.Handlers.errorHandler({
      shouldHandleError(error) {
        //known errors raised by our developers with http errors should not be logged unless they represent a server crash
        if (error instanceof HttpError) {
          return error.httpCode >= 500;
        }

        //known expected errors should not be logged, everything else should
        if (
          (error.status && typeof error.status === 'number' && error.status < 500) ||
          (error.statusCode && typeof error.statusCode === 'number' && error.statusCode < 500) ||
          (error.status_code && typeof error.status_code === 'number' && error.status_code < 500)
        ) {
          return false;
        }

        return true;
      }
    });

    if (!(err instanceof HttpError) || err.httpCode >= 500) {
      log.error(
        {
          url: req.url,
          method: req.method,
          body: req.body,
          user: req.user,
          requestId: req.headers['x-request-id'],
          err
        },
        `${req.url} error`
      );
    }
    if (err instanceof HttpError && err.httpCode === 403) {
      log.warn(
        {
          url: req.url,
          method: req.method,
          body: req.body,
          user: req.user,
          requestId: req.headers['x-request-id'],
          err
        },
        `${req.url} error`
      );
    }
    if (err instanceof HttpError) {
      return res.status(err.httpCode).json({ error: err.message });
    } else {
      return res.status(500).json({ error: 'Internal server error.' });
    }
  }
}
