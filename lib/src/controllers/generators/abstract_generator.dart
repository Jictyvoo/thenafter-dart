import 'package:thenafter_dart/src/controllers/abstract_analyzer.dart';
import 'package:thenafter_dart/src/util/helpers/string_helper.dart';

abstract class AbstractCodeGenerator extends AbstractAnalyzer {
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
        buffer.write('${sanitizeTerminal(word)}');
        count++;
      }
    }
    return '[${buffer.toString()}]';
  }

  String sanitizeName(String productionName, [bool allLower = true]) {
    final buffer = StringBuffer();
    var lastCharacter = 0;
    for (var character in productionName.runes) {
      if (StringHelper.isWhitespace(character) ||
          StringHelper.isNewline(character)) {
        buffer.write('_');
      } else if (character != 60 && character != 62) {
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
    }
    return buffer.toString();
  }
}
