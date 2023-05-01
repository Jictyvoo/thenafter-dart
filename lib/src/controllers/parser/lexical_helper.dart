import 'package:thenafter_dart/src/models/value/token.dart';

export 'package:thenafter_dart/src/util/helpers/string_constants.dart'
    show
        CHAR_EXCLAMATION,
        CHAR_COLON,
        CHAR_EQUAL,
        CHAR_LESS_THAN,
        CHAR_GREATER_THAN,
        CHAR_BACK_SLASH,
        CHAR_VERTICAL_SLASH,
        CHAR_OPEN_BRACKETS,
        CHAR_CLOSE_BRACKETS;

/// All states for lexical parser
enum LexicalStates {
  /// Null state, default
  nil,

  /// String state, a string has been opened and
  /// is under construction in the parser
  string,

  /// A production has been opened and gonna be constructed
  production,

  /// A bigger then 1 length operator has been detected
  operator,

  /// Noticed a identifier, parsing it until reach a delimiter
  identifier,

  /// Detected a comment, parsing it until it ends
  comment,

  /// A attribution has been detected, parsing it until the end
  attribution,

  /// A character set has been detected, parsing it until the end
  characterSet
}

/// Stores all information needed about lexeme construction and Lexical state
class LexicalInformation {
  final StringBuffer _lexemeBuilder;

  /// Current state of the parser
  LexicalStates state;

  /// Current line number that was read in the parser
  int lineNumber;

  /// Current column read in the parser
  int column;

  /// Default constructor of the lexical parser, that starts with all
  /// needed values for it work
  LexicalInformation()
      : _lexemeBuilder = StringBuffer(),
        state = LexicalStates.nil,
        lineNumber = 1,
        column = 1;

  /// Informs if have a token that was not finished yet
  bool get isBuildingToken => _lexemeBuilder.isNotEmpty;

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
        ? (fromCharacter == 0
            ? Token.empty.lexeme
            : String.fromCharCode(fromCharacter))
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
