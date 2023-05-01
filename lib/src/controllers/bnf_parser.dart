import 'package:thenafter_dart/src/controllers/parser/bnf_syntactic.dart';
import 'package:thenafter_dart/src/models/value/grammar_information.dart';
import 'package:thenafter_dart/src/models/value/token.dart';
import 'package:thenafter_dart/src/util/types_util.dart';

import 'parser/bnf_lexical.dart';

const _keyStartSymbol = 'Start Symbol';
const _keyCaseSensitive = 'Case Sensitive';
const _keyName = 'Name';
const _keyAuthor = 'Author';
const _keyAbout = 'About';
const _keyVersion = 'Version';

void _cleanupDefinitions(Map<String, String> extraDefinitions) {
  for (final key in const [
    _keyStartSymbol,
    _keyCaseSensitive,
    _keyName,
    _keyAuthor,
    _keyAbout,
    _keyVersion
  ]) {
    extraDefinitions.remove(key);
  }
}

GrammarInformation _getElements(
  ProductionsMap productionMap,
  Map<String, String> extraDefinitions,
) {
  final startSymbol = extraDefinitions[_keyStartSymbol] ?? '<Program>';
  final caseSensitive = extraDefinitions[_keyCaseSensitive] ?? 'True';
  final grammar = GrammarInformation(
    name: extraDefinitions[_keyName],
    author: extraDefinitions[_keyAuthor],
    about: extraDefinitions[_keyAbout],
    version: extraDefinitions[_keyVersion],
    extraDefinitions: extraDefinitions,
    productions: productionMap,
    caseSensitive: caseSensitive.toLowerCase() == 'true',
    startSymbol: Token(startSymbol, 0, 0, TokenType.production),
  );

  // Remove obtained definitions
  _cleanupDefinitions(extraDefinitions);

  return grammar;
}

/// The default BNF Parser for a grammar
class BNFParser {
  final _lexicalAnalyzer = BNFLexical();
  final _syntacticAnalyzer = BNFSyntactic();

  /// Takes a source input of [rune] or [codeUnit]
  /// and the parsed result in a [GrammarInformation] object
  GrammarInformation call(InputIterator source) {
    final tokens = _lexicalAnalyzer.start(source);
    _syntacticAnalyzer.start(tokens);

    final grammarInfo = _getElements(
      _syntacticAnalyzer.productions,
      _syntacticAnalyzer.extraDefinitions,
    );

    // Clear analyzers after finished
    _lexicalAnalyzer.clear();
    _syntacticAnalyzer.clear();
    return grammarInfo;
  }
}
