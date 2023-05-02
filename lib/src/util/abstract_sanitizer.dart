import 'helpers/string_constants.dart';
import 'helpers/string_helper.dart';

/// Defines the different formats that an identifier can be normalized into
enum IdentifierFormat {
  /// Represents identifiers that are written in lowerCamelCase style,
  /// where the first word is in lowercase and subsequent
  /// words start with a capital letter
  camelCase,

  /// Represents identifiers that are written in snake_case style, where
  /// words are separated by an underscore and all words are in lowercase
  snakeCase,

  /// Represents identifiers that are written in UpperCamelCase style, where
  /// the first word is in uppercase and subsequent
  /// words start with a capital letter
  pascalCase,
}

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
    final IdentifierFormat format = IdentifierFormat.camelCase,
    final String Function(String)? unknownCharacterFallback,
  }) {
    final buffer = StringBuffer();
    var index = 0;
    var upperCaseAtIndex = format == IdentifierFormat.pascalCase ? 0 : -1;
    var addUnderscore = false;
    for (final character in identifier.codeUnits) {
      if (buffer.isEmpty) {
        if (StringHelper.isAlphabetic(character)) {
          var toAdd = String.fromCharCode(character);
          if (format == IdentifierFormat.camelCase &&
              StringHelper.isUpper(character)) {
            toAdd = toAdd.toLowerCase();
          } else if (format == IdentifierFormat.pascalCase &&
              StringHelper.isLower(character)) {
            toAdd = toAdd.toUpperCase();
          }
          buffer.write(toAdd);
        } else if (StringHelper.isNumber(character)) {
          buffer
            ..write('_')
            ..writeCharCode(character);
        }

        // Skip if buffer was written
        if (buffer.isNotEmpty) {
          index += 1;
          continue;
        }
      }
      if (StringHelper.isWhitespace(character) ||
          StringHelper.isNewline(character) ||
          StringHelper.isHyphen(character) ||
          StringHelper.isUnderline(character)) {
        if (format == IdentifierFormat.pascalCase ||
            format == IdentifierFormat.camelCase) {
          upperCaseAtIndex = index + 1;
        }

        addUnderscore = format == IdentifierFormat.snakeCase;
        index += 1;
        continue;
      }

      // Start to add the characters on buffer
      if (addUnderscore) {
        buffer.write('_');
        addUnderscore = false;
      }

      if (!StringHelper.isAlphanumeric(character) &&
          unknownCharacterFallback != null) {
        buffer.write(
          unknownCharacterFallback(String.fromCharCode(character)),
        );
      } else if (index == upperCaseAtIndex) {
        buffer.write(String.fromCharCode(character).toUpperCase());
      } else {
        buffer.writeCharCode(character);
      }

      index += 1;
    }

    return format == IdentifierFormat.snakeCase
        ? buffer.toString().toLowerCase()
        : buffer.toString();
  }
}
