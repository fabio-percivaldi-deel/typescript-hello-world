import { MigrationService } from './migration.service';

// eslint-disable-next-line @typescript-eslint/no-non-null-assertion
const migrationService = new MigrationService(process.env.DATABASE_URL!);
migrationService.rollback({ count: 1 }).then(() => process.exit(0));
