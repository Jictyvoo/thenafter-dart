import 'string_constants.dart';

abstract class StringHelper {
  static String multiplyString(String target, int quantity) {
    return target * quantity;
  }

  static String removeQuotes(String target) {
    final lastCharacter = target.codeUnitAt(target.length - 1);
    final firstCharacter = target.codeUnitAt(0);
    if (lastCharacter != firstCharacter ||
        !isQuotes(firstCharacter) ||
        !isQuotes(lastCharacter)) {
      return target;
    }
    // Start fixing string
    final buffer = StringBuffer();
    var openedString = 0;
    var timesClosed = 0;
    for (final character in target.runes) {
      if (openedString == 0 && isQuotes(character)) {
        openedString = character;
      } else if (character == openedString) {
        timesClosed += 1;
        openedString = 0;
      } else {
        buffer.writeCharCode(character);
      }
    }
    return timesClosed == 1 ? buffer.toString() : target;
  }

  static bool isWhitespace(int rune) {
    return rune == CHAR_SPACE ||
        rune == CHAR_TAB ||
        rune == CHAR_VERTICAL_TAB ||
        rune == CHAR_FORM_FEED ||
        UNKNOWN_WHITESPACE.contains(rune);
  }

  static bool isQuotes(int rune) {
    return rune == CHAR_SINGLE_QUOTE || rune == CHAR_QUOTES;
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
