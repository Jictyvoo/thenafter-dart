import 'package:thenafter_dart/src/models/value/token.dart';

enum LexicalStates {
  nil,
  string,
  production,
  operator,
  identifier,
  comment,
  attribution,
  characterSet
}

/// ASCII code for character `!`
const CHAR_EXCLAMATION = 33;

/// ASCII code for character `:`
const CHAR_COLON = 58;

/// ASCII code for character `=`
const CHAR_EQUAL = 61;

/// ASCII code for character `<`
const CHAR_LESS_THAN = 60;

/// ASCII code for character `>`
const CHAR_GREATER_THAN = 62;

/// ASCII code for character `\`
const CHAR_BACK_SLASH = 92;

/// ASCII code for character `|`
const CHAR_VERTICAL_SLASH = 124;

/// ASCII code for character `{`
const CHAR_OPEN_BRACKETS = 123;

/// ASCII code for character `}`
const CHAR_CLOSE_BRACKETS = 125;

/// Stores all information needed about lexeme construction and Lexical state
class LexicalInformation {
  final StringBuffer _lexemeBuilder;
  LexicalStates state;
  int lineNumber;
  int column;

  LexicalInformation()
      : _lexemeBuilder = StringBuffer(),
        state = LexicalStates.nil,
        lineNumber = 1,
        column = 1;

  /// Clear all information stored
  void clear() {
    column = 1;
    lineNumber = 1;
    _lexemeBuilder.clear();
    state = LexicalStates.nil;
  }

  /// Add a new character to lexemeBuilder
  void addCharacter(int firstCharacter, [int secondCharacter = 0]) {
    _lexemeBuilder.writeCharCode(firstCharacter);
    if (secondCharacter != 0) {
      _lexemeBuilder.writeCharCode(secondCharacter);
    }
  }

  /// Generate a new [Token], returns it,
  /// clear lexemeBuilder and set state to nil
  Token generateToken(TokenType tokenType, [int? fromCharacter]) {
    final finalLexeme = fromCharacter != null
        ? String.fromCharCode(fromCharacter)
        : _lexemeBuilder.toString().trim();
    final newToken = Token(
      finalLexeme,
      lineNumber,
      column,
      tokenType,
    );
    _lexemeBuilder.clear();
    state = LexicalStates.nil;
    return newToken;
  }

  /// Current length for new lexeme in lexemeBuilder
  int get lexemeLength => _lexemeBuilder.length;

  /// String version for current lexeme
  String get lexeme => _lexemeBuilder.toString();

  /// ASCII code of first character in lexemeBuilder
  int get firstCharacter {
    if (_lexemeBuilder.length > 0) {
      return _lexemeBuilder.toString().codeUnitAt(0);
    }
    return 0;
  }
}
