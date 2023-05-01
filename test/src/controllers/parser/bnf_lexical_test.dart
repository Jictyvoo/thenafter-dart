import 'dart:io';

import 'package:test/test.dart';
import 'package:thenafter_dart/src/controllers/parser/bnf_lexical.dart';
import 'package:thenafter_dart/thenafter_dart.dart';

void main() {
  test('complete big expression file', testParseExpressionGrammar);
  test('basic production', testBasicProduction);
  test('parse comment', testParseComment);
}

void testBasicProduction() {
  const input = "<MultiA> ::= 'a'<MultiA>'a' | <>";
  final lexer = BNFLexical();
  final tokens = lexer.start(input.codeUnits);
  expect(tokens.isEmpty, false);

  const expectedTokens = [
    Token('<MultiA>', 1, 9, TokenType.production),
    Token('::=', 1, 13, TokenType.operator),
    Token("'a'", 1, 17, TokenType.terminal),
    Token('<MultiA>', 1, 25, TokenType.production),
    Token("'a'", 1, 28, TokenType.terminal),
    Token('|', 1, 30, TokenType.operator),
    Token('', 1, 33, TokenType.terminal)
  ];
  expect(tokens, equals(expectedTokens));
}

void testParseComment() {
  const input = "<Logic Operator> ::= '&&' | '||' ! Start of the comment here";
  final lexer = BNFLexical();
  final tokens = lexer.start(input.codeUnits);
  expect(tokens.isEmpty, false);

  const expectedTokens = [
    Token('<Logic Operator>', 1, 17, TokenType.production),
    Token('::=', 1, 21, TokenType.operator),
    Token("'&&'", 1, 26, TokenType.terminal),
    Token('|', 1, 28, TokenType.operator),
    Token("'||'", 1, 33, TokenType.terminal),
    Token('! Start of the comment here', 1, 61, TokenType.comment),
  ];
  expect(tokens, equals(expectedTokens));
}

void testParseExpressionGrammar() {
  final lexer = BNFLexical();
  final inputFile = File('test/resources/expression_grammar.grm');
  final tokens = lexer.start(inputFile.readAsStringSync().codeUnits);
  expect(tokens.isEmpty, false);

  const expectedTokens = [
    Token('"Name"', 1, 7, TokenType.string),
    Token('=', 1, 9, TokenType.operator),
    Token("'Thenafter: Loaded.grm'", 1, 34, TokenType.attributionValue),
    Token('"Author"', 2, 8, TokenType.string),
    Token('=', 2, 10, TokenType.operator),
    Token("'Thenafter'", 2, 23, TokenType.attributionValue),
    Token('"Version"', 3, 9, TokenType.string),
    Token('=', 3, 11, TokenType.operator),
    Token("'v0.0.1'", 3, 21, TokenType.attributionValue),
    Token('"About"', 4, 7, TokenType.string),
    Token('=', 4, 9, TokenType.operator),
    Token(
      "'Generated with the help of Thenafter'",
      4,
      49,
      TokenType.attributionValue,
    ),
    Token('"Case Sensitive"', 5, 16, TokenType.string),
    Token('=', 5, 18, TokenType.operator),
    Token("'true'", 5, 26, TokenType.attributionValue),
    Token('"Start Symbol"', 6, 14, TokenType.string),
    Token('=', 6, 16, TokenType.operator),
    Token('<start>', 6, 25, TokenType.attributionValue),
    Token('<start>', 8, 7, TokenType.production),
    Token('::=', 8, 11, TokenType.operator),
    Token('<expr>', 8, 18, TokenType.production),
    Token('<expr>', 10, 6, TokenType.production),
    Token('::=', 10, 10, TokenType.operator),
    Token('<term>', 10, 17, TokenType.production),
    Token('|', 10, 19, TokenType.operator),
    Token('<expr\'>', 10, 27, TokenType.production),
    Token('<expr\'>', 11, 7, TokenType.production),
    Token('::=', 11, 11, TokenType.operator),
    Token("'+'", 11, 15, TokenType.terminal),
    Token('<term>', 11, 22, TokenType.production),
    Token('|', 11, 24, TokenType.operator),
    Token("'-'", 11, 28, TokenType.terminal),
    Token('<term>', 11, 35, TokenType.production),
    Token('|', 11, 37, TokenType.operator),
    Token('<term>', 13, 6, TokenType.production),
    Token('::=', 13, 10, TokenType.operator),
    Token('<factor>', 13, 19, TokenType.production),
    Token('|', 13, 21, TokenType.operator),
    Token('<term\'>', 13, 29, TokenType.production),
    Token('<term\'>', 14, 7, TokenType.production),
    Token('::=', 14, 11, TokenType.operator),
    Token("'*'", 14, 15, TokenType.terminal),
    Token('<factor>', 14, 24, TokenType.production),
    Token('|', 14, 26, TokenType.operator),
    Token("'/'", 14, 30, TokenType.terminal),
    Token('<factor>', 14, 39, TokenType.production),
    Token('|', 14, 41, TokenType.operator),
    Token('<factor>', 16, 8, TokenType.production),
    Token('::=', 16, 12, TokenType.operator),
    Token("'('", 16, 16, TokenType.terminal),
    Token('<expr>', 16, 23, TokenType.production),
    Token("')'", 16, 27, TokenType.terminal),
    Token('|', 16, 29, TokenType.operator),
    Token('<number>', 16, 38, TokenType.production),
    Token('<number>', 18, 8, TokenType.production),
    Token('::=', 18, 12, TokenType.operator),
    Token('<digit>', 18, 20, TokenType.production),
    Token('<number\'>', 18, 30, TokenType.production),
    Token('<number\'>', 19, 9, TokenType.production),
    Token('::=', 19, 13, TokenType.operator),
    Token('<digit>', 19, 21, TokenType.production),
    Token('<number\'>', 19, 31, TokenType.production),
    Token('|', 19, 33, TokenType.operator),
    Token('<digit>', 21, 7, TokenType.production),
    Token('::=', 21, 11, TokenType.operator),
    Token("'0'", 21, 15, TokenType.terminal),
    Token('|', 21, 17, TokenType.operator),
    Token("'1'", 21, 21, TokenType.terminal),
    Token('|', 21, 23, TokenType.operator),
    Token("'2'", 21, 27, TokenType.terminal),
    Token('|', 21, 29, TokenType.operator),
    Token("'3'", 21, 33, TokenType.terminal),
    Token('|', 21, 35, TokenType.operator),
    Token("'4'", 21, 39, TokenType.terminal),
    Token('|', 21, 41, TokenType.operator),
    Token("'5'", 21, 45, TokenType.terminal),
    Token('|', 21, 47, TokenType.operator),
    Token("'6'", 21, 51, TokenType.terminal),
    Token('|', 21, 53, TokenType.operator),
    Token("'7'", 21, 57, TokenType.terminal),
    Token('|', 21, 59, TokenType.operator),
    Token("'8'", 21, 63, TokenType.terminal),
    Token('|', 21, 65, TokenType.operator),
    Token("'9'", 21, 69, TokenType.terminal)
  ];

  expect(tokens, equals(expectedTokens));
}
