import 'package:thenafter_dart/thenafter_dart.dart';

// Define the BNF grammar as a map of productions
const allProductions = {
  '<expr>': [
    [Token.simple('<term>', TokenType.production)],
    [Token.simple("<expr'>", TokenType.production)],
  ],
  "<expr'>": [
    [
      Token.simple('+', TokenType.terminal),
      Token.simple('<term>', TokenType.production)
    ],
    [
      Token.simple('-', TokenType.terminal),
      Token.simple('<term>', TokenType.production)
    ],
    [Token.simple('', TokenType.terminal)],
  ],
  '<term>': [
    [Token.simple('<factor>', TokenType.production)],
    [Token.simple("<term'>", TokenType.production)],
  ],
  "<term'>": [
    [
      Token.simple('*', TokenType.terminal),
      Token.simple('<factor>', TokenType.production)
    ],
    [
      Token.simple('/', TokenType.terminal),
      Token.simple('<factor>', TokenType.production)
    ],
    [Token.simple('', TokenType.terminal)],
  ],
  '<factor>': [
    [
      Token.simple('(', TokenType.terminal),
      Token.simple('<expr>', TokenType.production),
      Token.simple(')', TokenType.terminal)
    ],
    [Token.simple('<number>', TokenType.production)],
  ],
  '<number>': [
    [
      Token.simple('<digit>', TokenType.production),
      Token.simple("<number'>", TokenType.production)
    ],
  ],
  "<number'>": [
    [
      Token.simple('<digit>', TokenType.production),
      Token.simple("<number'>", TokenType.production)
    ],
    [Token.simple('', TokenType.terminal)],
  ],
  '<digit>': [
    [Token.simple('0', TokenType.terminal)],
    [Token.simple('1', TokenType.terminal)],
    [Token.simple('2', TokenType.terminal)],
    [Token.simple('3', TokenType.terminal)],
    [Token.simple('4', TokenType.terminal)],
    [Token.simple('5', TokenType.terminal)],
    [Token.simple('6', TokenType.terminal)],
    [Token.simple('7', TokenType.terminal)],
    [Token.simple('8', TokenType.terminal)],
    [Token.simple('9', TokenType.terminal)],
  ],
};
