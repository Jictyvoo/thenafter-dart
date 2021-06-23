import 'package:thenafter_dart/src/util/helpers/string_constants.dart';
import 'package:thenafter_dart/src/util/helpers/string_helper.dart';

abstract class AbstractAnalyzer {
  bool isProduction(String toTest) {
    return toTest.startsWith('<') && toTest.endsWith('>');
  }

  bool valueIsEmpty(String toTest) {
    return toTest.isEmpty || toTest == "''" || toTest == '""';
  }

  Set<String> joinSets(
    Set<String> main,
    Set<String> secondary,
  ) {
    for (final index in secondary) {
      if (!valueIsEmpty(index)) {
        main.add(index);
      }
    }
    return main;
  }

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
        buffer.writeCharCode(character);
      }
      index += 1;
    }
    return buffer.toString();
  }

  /// Must return a string with single quote
  String sanitizeTerminal(String original) {
    if (original.isEmpty || original == '"') {
      return "'$original'";
    } else if (original == "'") {
      return '"\'"';
    }
    if (!StringHelper.isQuotes(original.codeUnitAt(0))) {
      return original;
    }
    return replaceQuote(original);
  }
}
