export const ToISO8859_1 = (s: string) => s.replace(/[^\x20-\x7E]+/g, '');