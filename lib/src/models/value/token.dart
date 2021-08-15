/// All possible types identified during a Lexical analysis
enum TokenType {
  /// Represents a terminal symbol
  terminal,

  /// Represents a generic terminal symbol. It is a symbol that can be
  /// replaced with a valid symbol defined in a regex
  genericTerminal,

  /// Currently, regex expressions parsed in input are not validate or
  /// subdivided. So this tokenType informs all
  /// right expression on a attribution
  attributionValue,

  /// A character set that make part of a regex
  characterSet,

  /// Defines a production non-terminal symbol
  production,

  /// Defines a operator that can be used in the grammar
  ///
  /// Such as "|", "=", "::="
  operator,

  /// Defines a string that is between quotes
  string,

  /// Represents a comment in BNF way
  comment
}

/// A data class that holds information about the token
class Token {
  /// The token lexeme that represents the content of the token
  final String lexeme;

  /// The line number which token was generated
  final int lineNumber;

  /// The column number identifying the token location
  final int columnNumber;

  /// The token type
  final TokenType tokenType;

  /// A default empty token that serves as placeholder
  static const empty = Token('', 0, 0, TokenType.terminal);

  /// A default const constructor that enable the possibility to initialize
  /// all required fields
  const Token(this.lexeme, this.lineNumber, this.columnNumber, this.tokenType);

  @override
  String toString() {
    return '$lineNumber:$columnNumber `$lexeme` <$tokenType>';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Token && lexeme == other.lexeme && tokenType == other.tokenType;

  @override
  int get hashCode => lexeme.hashCode ^ tokenType.hashCode;
}
