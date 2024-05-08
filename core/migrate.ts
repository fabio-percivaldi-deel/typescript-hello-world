import { MigrationService } from './migration.service';

function main() {
  if (/\b(all|migration)\b/i.test(String(process.env.MAINTENANCE))) {
    return console.info('maintenance mode');
  }

  // eslint-disable-next-line @typescript-eslint/no-non-null-assertion
  const migrationService = new MigrationService(process.env.DATABASE_URL!);
  return migrationService.migrate().then(() => process.exit(0));
}

main();
