import {
  ContractAuthorization as CommonContractAuthorization,
  DeelUser as CommonDeelUser,
  GpClientAuthorization as CommonGPClientAuthorization,
  Internal as CommonInternal
} from '@letsdeel/employee-tribe-common';
import { Middleware } from 'routing-controllers';
import { Service } from 'typedi';

@Middleware({ type: 'before' })
@Service()
export class DeelUser extends CommonDeelUser {}

@Service()
export class Internal extends CommonInternal {}

@Service()
export class ContractAuthorization extends CommonContractAuthorization {}

@Service()
export class GpClientAuthorization extends CommonGPClientAuthorization {}
