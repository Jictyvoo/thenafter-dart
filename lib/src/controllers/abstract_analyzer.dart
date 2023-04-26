import 'package:thenafter_dart/src/util/helpers/string_constants.dart';
import 'package:thenafter_dart/src/util/helpers/string_helper.dart';

/// Abstract class that provides default methods to help dealing with
/// the BNF grammar analysis
abstract class AbstractAnalyzer {
  /// Check whether a string represents a production `<PRODUCTION>` or not
  bool isProduction(String toTest) {
    return toTest.startsWith('<') && toTest.endsWith('>');
  }

  /// Checks if the character has an empty value.
  ///
  /// Commonly used to check terminals
  bool valueIsEmpty(String toTest) {
    return toTest.isEmpty || toTest == "''" || toTest == '""';
  }

  /// Takes two Set objects and return the concatenation of both,
  /// disregarding the empty values using the
  /// method [AbstractAnalyzer.valueIsEmpty]
  Set<String> joinSets(
    Set<String> main,
    Set<String> secondary,
  ) {
    main.addAll(secondary.where((element) => !valueIsEmpty(element)));
    return main;
  }

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
