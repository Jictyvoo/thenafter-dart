import 'helpers/string_constants.dart';
import 'helpers/string_helper.dart';

/// A mixin that contains most methods used to sanitize string values
mixin AbstractSanitizer {
  /// Takes a quoted or unquoted string and replaces the quotes with the given
  /// desired rune.
  ///
  /// Only replaces quotes in the first and last positions of the string
  String replaceQuote(
    String original, [
    int desiredCharacter = CHAR_SINGLE_QUOTE,
  ]) {
    var firstCharacter = 0;
    var index = 0;
    final buffer = StringBuffer();
    for (final character in original.runes) {
      if (index == 0) {
        buffer.writeCharCode(desiredCharacter);
        if (StringHelper.isQuotes(character)) {
          firstCharacter = character;
        } else {
          buffer.writeCharCode(character);
        }
      } else if (index == original.length - 1) {
        if (character != firstCharacter) {
          buffer.writeCharCode(character);
        }
        buffer.writeCharCode(desiredCharacter);
      } else {
        if (character == desiredCharacter) {
          buffer.write('\\');
        }
        buffer.writeCharCode(character);
      }
      index += 1;
    }
    return buffer.toString();
  }

  /// Must return a string with single quote
  String sanitizeTerminal(String original, [final bool wrapInQuote = false]) {
    if (original == '"') {
      return "'\"'";
    } else if (original == "'") {
      return '"\'"';
    }

    var result = original;
    if (original.isNotEmpty && StringHelper.isQuotes(original.codeUnitAt(0))) {
      result = replaceQuote(original);
    } else if (wrapInQuote) {
      result = "'$original'";
    }

    return result;
  }
}
