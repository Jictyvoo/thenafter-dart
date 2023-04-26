import 'package:thenafter_dart/thenafter_dart.dart';

// Define the BNF grammar as a map of productions
const expressionProductions = {
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

const basicProductions = {
  '<S>': [
    [
      Token.simple('a', TokenType.terminal),
      Token.simple('<B>', TokenType.production),
      Token.simple('<D>', TokenType.production),
      Token.simple('h', TokenType.terminal)
    ]
  ],
  '<B>': [
    [
      Token.simple('c', TokenType.terminal),
      Token.simple('<C>', TokenType.production)
    ]
  ],
  '<C>': [
    [
      Token.simple('b', TokenType.terminal),
      Token.simple('<C>', TokenType.production)
    ],
    [Token.simple('', TokenType.terminal)]
  ],
  '<D>': [
    [
      Token.simple('<E>', TokenType.production),
      Token.simple('<F>', TokenType.production)
    ]
  ],
  '<E>': [
    [Token.simple('g', TokenType.terminal)],
    [Token.simple('', TokenType.terminal)]
  ],
  '<F>': [
    [Token.simple('f', TokenType.terminal)],
    [Token.simple('', TokenType.terminal)]
  ],
};
