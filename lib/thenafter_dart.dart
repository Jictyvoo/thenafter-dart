library thenafter_dart;

import 'package:thenafter_dart/src/models/value/token.dart';

export 'src/controllers/bnf_parser.dart';
export 'src/controllers/first_follow.dart';
export 'src/controllers/generators/lua_generator.dart' show LuaGenerator;
export 'src/controllers/generators/syntactic/python_syntactic_generator.dart';
export 'src/models/value/first_follow_result.dart';
export 'src/models/value/grammar_information.dart';
export 'src/models/value/token.dart' show TokenType;
export 'src/util/types_util.dart';

Token createToken(String lexeme, TokenType tokenType) {
  return Token(lexeme, 0, 0, tokenType);
}
