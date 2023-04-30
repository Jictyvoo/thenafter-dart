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

  /// Takes a string identifier and normalizes it to a specified case format.
  /// The options for case formats are [camelCase], [snakeCase], and [pascalCase].
  /// Only one of these options can be set to true at a time,
  /// otherwise an assertion error will be thrown.
  String normalizeIdentifier(
    final String identifier, {
    final bool camelCase = false,
    final bool snakeCase = false,
    final bool pascalCase = false,
  }) {
    assert(
      !(camelCase && snakeCase && pascalCase),
      'only one parameter should be set to true',
    );

    final buffer = StringBuffer();
    var index = 0;
    var upperCaseAtIndex = pascalCase ? 0 : -1;
    for (final character in identifier.codeUnits) {
      if (index == 0 && camelCase) {
        buffer.write(String.fromCharCode(character).toLowerCase());
        index += 1;
        continue;
      }
      if (StringHelper.isWhitespace(character) || StringHelper.isHyphen(character)) {
        if (pascalCase || camelCase) {
          upperCaseAtIndex = index + 1;
        } else if (snakeCase) {
          buffer.write('_');
        }
        index += 1;
        continue;
      }

      if (index == upperCaseAtIndex) {
        buffer.write(String.fromCharCode(character).toUpperCase());
      } else {
        buffer.writeCharCode(character);
      }
      index += 1;
    }

    return snakeCase ? buffer.toString().toLowerCase() : buffer.toString();
  }
}