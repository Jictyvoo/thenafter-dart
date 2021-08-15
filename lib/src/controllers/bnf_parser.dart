import 'package:thenafter_dart/src/controllers/parser/bnf_syntactic.dart';
import 'package:thenafter_dart/src/models/value/grammar_information.dart';
import 'package:thenafter_dart/src/models/value/token.dart';
import 'package:thenafter_dart/src/util/types_util.dart';

import 'parser/bnf_lexical.dart';

GrammarInformation _getElements(
  ProductionsMap productionMap,
  Map<String, String> extraDefinitions,
) {
  final startSymbol = extraDefinitions['Start Symbol'] ?? '<Program>';
  final caseSensitive = extraDefinitions['Case Sensitive'] ?? 'True';
  return GrammarInformation(
    name: extraDefinitions['Name'],
    author: extraDefinitions['Author'],
    about: extraDefinitions['About'],
    version: extraDefinitions['Version'],
    extraDefinitions: extraDefinitions,
    productions: productionMap,
    caseSensitive: caseSensitive.toLowerCase() == 'true',
    startSymbol: Token(startSymbol, 0, 0, TokenType.production),
  );
}

/// The default BNF Parser for a grammar
class BNFParser {
  /// Takes a source input of [rune] or [codeUnit]
  /// and the parsed result in a [GrammarInformation] object
  GrammarInformation call(InputIterator source) {
    final lexicalAnalyzer = BNFLexical();
    final tokens = lexicalAnalyzer.start(source);
    final syntacticAnalyzer = BNFSyntactic();
    syntacticAnalyzer.start(tokens);
    return _getElements(
      syntacticAnalyzer.productions,
      syntacticAnalyzer.extraDefinitions,
    );
  }
}
