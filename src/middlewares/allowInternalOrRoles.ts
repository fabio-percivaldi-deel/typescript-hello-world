import { AllowRole, Role } from '@letsdeel/employee-tribe-common';
import { NextFunction, Request, Response } from 'express';

export function AllowInternalOrRoles(roles: Role[]) {
  return function (request: Request, response: Response, next: NextFunction) {
    const isInternal = request.headers['x-internal-token'] === process.env.INTERNAL_SECRET;
    if (isInternal) {
      return next();
    }

    return AllowRole(roles)(request, response, next);
  };
}
