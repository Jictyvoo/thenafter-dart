import 'package:thenafter_dart/src/util/helpers/string_helper.dart';

abstract class AbstractAnalyzer {
  bool isProduction(String toTest) {
    return toTest.startsWith('<') && toTest.endsWith('>');
  }

  bool valueIsEmpty(String toTest) {
    return toTest == "''" || toTest.isEmpty;
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
        buffer.write("'$word'");
        count++;
      }
    }
    return '[${buffer.toString()}]';
  }

  /// Must return a string with single quote
  String sanitizeTerminals(String original) {
    if (original == "'" || original.isEmpty) {
      return "'$original'";
    }
    if (!original.startsWith("'")) {
      original = "'" + original;
    }
    if (!original.endsWith("'")) {
      original = original + "'";
    }
    return original;
  }

  String sanitizeName(String productionName, [bool allLower = true]) {
    final buffer = StringBuffer();
    var lastCharacter = 0;
    for (var character in productionName.runes) {
      if (StringHelper.isWhitespace(character)) {
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
