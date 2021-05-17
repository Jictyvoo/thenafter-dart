abstract class SynthaticCodeGenerator {
  bool _isLower(int charCode) {
    return charCode >= 97 && charCode <= 122;
  }

  bool isProduction(String toTest) {
    return toTest.startsWith('<') && toTest.endsWith('>');
  }

  bool valueIsEmpty(String toTest) {
    return toTest == "''" || toTest.isEmpty;
  }

  /// Must return a string with single quote
  String sanitizeTerminals(String original) {
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
      if (character == 32) {
        buffer.write('_');
      } else if (character != 60 && character != 62) {
        if (_isLower(lastCharacter) && !_isLower(character)) {
          buffer.write('_');
        }
        if (allLower && !_isLower(character)) {
          final temp = StringBuffer()..writeCharCode(character);
          character = temp.toString().toLowerCase().codeUnitAt(0);
        }
        buffer.writeCharCode(character);
      }
      lastCharacter = character;
    }
    return buffer.toString();
  }
}
