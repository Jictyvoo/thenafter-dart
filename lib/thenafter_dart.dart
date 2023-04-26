library thenafter_dart;

import 'package:thenafter_dart/src/models/value/token.dart';

export 'src/controllers/bnf_parser.dart';
export 'src/controllers/first_follow.dart';
export 'src/models/value/first_follow_result.dart';
export 'src/models/value/grammar_information.dart';
export 'src/models/value/token.dart' show TokenType, Token;
export 'src/util/types_util.dart';

/// Make possible to create a [Token] with a given [lexeme] and [TokenType]
Token createToken(String lexeme, TokenType tokenType) {
  return Token(lexeme, 0, 0, tokenType);
}
