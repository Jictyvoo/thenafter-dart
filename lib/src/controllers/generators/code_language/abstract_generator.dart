import 'package:thenafter_dart/src/controllers/abstract_analyzer.dart';
import 'package:thenafter_dart/src/util/helpers/string_constants.dart';
import 'package:thenafter_dart/src/util/helpers/string_helper.dart';

/// A interface that has a set of methods that
/// helps dealing with code generation
abstract class AbstractCodeGenerator extends AbstractAnalyzer {
  /// Stringfy a list of terminals, and put it in a array form
  String listTerminalToString(
    Set<String> terminals, {
    String delimiter = ',',
    Set<String> excluded = const <String>{},
  }) {
    final buffer = StringBuffer();
    var count = 0;
    for (final word in terminals) {
      if (word.isNotEmpty && !excluded.contains(word)) {
        if (count > 0) {
          buffer.write(delimiter);
        }
        buffer.write(sanitizeTerminal(word));
        count++;
      }
    }
    return '[${buffer.toString()}]';
  }

  /// Sanitize a name to be in correct way to be used as an identifier
  String sanitizeName(String productionName, [bool allLower = true]) {
    final buffer = StringBuffer();
    var lastCharacter = 0;
    var index = 0;
    for (var character in productionName.runes) {
      if (StringHelper.isWhitespace(character) ||
          StringHelper.isNewline(character)) {
        buffer.write('_');
      } else if (StringHelper.isAlphabetic(character) ||
          StringHelper.isUnderline(character) ||
          (StringHelper.isNumber(character) && index > 0)) {
        if (StringHelper.isLower(lastCharacter) &&
            !StringHelper.isLower(character)) {
          buffer.write('_');
        }
        if (allLower && !StringHelper.isLower(character)) {
          final temp = String.fromCharCode(character);
          character = temp.toLowerCase().codeUnitAt(0);
        }
        buffer.writeCharCode(character);
      }
      lastCharacter = character;
      index += 1;
    }
    return buffer.toString();
  }

  /// Converts a terminal into a string, making possible to convert
  /// escape characters and quotes, so it will generate a valid string
  String stringify(
    String original, [
    int quoteType = CHAR_SINGLE_QUOTE,
  ]) {
    final buffer = StringBuffer()..writeCharCode(quoteType);
    var previousCharacter = 0;
    for (final character in original.runes) {
      if (String.fromCharCode(previousCharacter) != '\\' &&
          StringHelper.isQuotes(character) &&
          character == quoteType) {
        buffer.write('\\');
      } else if (String.fromCharCode(previousCharacter) != '\\' &&
          String.fromCharCode(character) == '\\') {
        buffer.write('\\');
      }
      buffer.writeCharCode(character);
      previousCharacter = character;
    }
    buffer.writeCharCode(quoteType);
    return buffer.toString();
  }
}
