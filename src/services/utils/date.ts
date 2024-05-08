import { DateTime } from 'luxon';

export function getAge(dateOfBirth: Date | string, targetDate: Date = new Date()): number {
  const today = DateTime.fromJSDate(targetDate);
  const dt = typeof dateOfBirth === 'string' ? DateTime.fromISO(dateOfBirth) : DateTime.fromJSDate(dateOfBirth);
  const { years } = today.diff(dt, ['years', 'months']);
  return years;
}

export function getLastBirthday(dob?: Date, baseDate?: DateTime) {
  if (!dob) {
    return '';
  }
  const year = (baseDate || DateTime.local()).get('year');
  const lastBirthday = DateTime.local(year, dob.getMonth() + 1, dob.getDate());
  return lastBirthday.toFormat('DD');
}
