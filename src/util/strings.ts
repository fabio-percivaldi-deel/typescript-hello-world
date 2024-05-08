import { ToISO8859_1 } from './ToISO8859_1';

export const isUUID = (id: string) => /^[a-f\d]{8}(-[a-f\d]{4}){4}[a-f\d]{8}$/i.test(id);

/**
 * Safe URI component decoding.
 * This prevents URIError when decoding non encoded string that includes '%'.
 * It also converts the string to ISO-8859-1.
 * @param componentString
 * @private
 */
export function safeDecodeUriComponent(componentString: string): string {
  let decodedString;
  try {
    decodedString = decodeURIComponent(componentString);
  } catch (e) {
    // Ignore URIError, thrown if encodedURI contains a % not followed by two hexadecimal digits,
    // or if the escape sequence does not encode a valid UTF-8 character.
    //
    // Then we just return the original string.
    decodedString = componentString;
  }

  return ToISO8859_1(decodedString);
}
