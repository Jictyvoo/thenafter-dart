import 'string_constants.dart';

abstract class StringHelper {
  static String multiplyString(String target, int quantity) {
    return target * quantity;
  }

  static bool isWhitespace(int rune) {
    return rune == CHAR_SPACE ||
        rune == CHAR_TAB ||
        rune == CHAR_VERTICAL_TAB ||
        rune == CHAR_FORM_FEED ||
        UNKNOWN_WHITESPACE.contains(rune);
  }

  static bool isLower(int rune) {
    return rune >= CHAR_LOWER_A && rune <= CHAR_LOWER_Z;
  }

  static bool isUpper(int rune) {
    return rune >= CHAR_UPPER_A && rune <= CHAR_UPPER_Z;
  }

  static bool isNumber(int rune) {
    return rune >= CHAR_0 && rune <= CHAR_9;
  }

  static bool isAlphabetic(int rune) {
    return isLower(rune) || isUpper(rune);
  }

  static bool isUnderline(int rune) {
    return String.fromCharCode(rune) == '_';
  }

  static bool isNewline(int rune) {
    return String.fromCharCode(rune) == '\n' ||
        rune == CHAR_CARRIAGE_RETURN ||
        rune == CHAR_LINE_FEED;
  }

  static bool isCRLF(int first, int second) {
    return String.fromCharCodes([first, second]) == '\r\n';
  }
}
