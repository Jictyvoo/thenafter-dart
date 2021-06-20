enum TokenType { terminal, production, identifier, operator, string, sets }

class Token {
  final String lexeme;
  final int lineNumber;
  final int columnNumber;
  final TokenType tokenType;

  static const empty = Token('', 0, 0, TokenType.terminal);

  const Token(this.lexeme, this.lineNumber, this.columnNumber, this.tokenType);

  @override
  String toString() {
    return '$lineNumber:$columnNumber - $lexeme<$tokenType>';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Token && lexeme == other.lexeme && tokenType == other.tokenType;

  @override
  int get hashCode => lexeme.hashCode ^ tokenType.hashCode;
}
