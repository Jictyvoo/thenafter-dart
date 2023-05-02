import 'package:thenafter_dart/src/controllers/abstract_analyzer.dart';
import 'package:thenafter_dart/src/util/abstract_sanitizer.dart';
import 'package:thenafter_dart/src/util/helpers/string_constants.dart';
import 'package:thenafter_dart/src/util/helpers/string_helper.dart';

/// A interface that has a set of methods that
/// helps dealing with code generation
abstract class AbstractCodeGenerator extends AbstractAnalyzer
    with AbstractSanitizer {
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
