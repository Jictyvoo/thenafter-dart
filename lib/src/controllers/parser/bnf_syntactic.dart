import 'package:thenafter_dart/src/models/value/token.dart';
import 'package:thenafter_dart/src/util/helpers/string_helper.dart';
import 'package:thenafter_dart/src/util/types_util.dart';

enum SyntacticState { nil, openedProduction, openedAttribution }

class BNFSyntactic {
  final ProductionsMap productions;
  final Map<String, String> extraDefinitions;
  SyntacticState _state;
  Token _leftSideToken;

  BNFSyntactic()
      : _state = SyntacticState.nil,
        _leftSideToken = Token.empty,
        extraDefinitions = <String, String>{},
        productions = <String, List<List<String>>>{};

  void _attributionState(Token token) {
    final key = StringHelper.removeQuotes(_leftSideToken.lexeme);
    final value = StringHelper.removeQuotes(token.lexeme);
    extraDefinitions[key] = value;
    _state = SyntacticState.nil;
  }

  void _productionState(Token previousToken, Token token) {
    final productionList =
        productions[_leftSideToken.lexeme] ?? <List<String>>[];
    if (!productions.containsKey(_leftSideToken.lexeme)) {
      productions[_leftSideToken.lexeme] = productionList;
    }
    if (productionList.isEmpty) {
      productionList.add(<String>[]);
    }
    final subProductions = productionList.last;
    if (token.tokenType == TokenType.operator && token.lexeme == '|') {
      productionList.add(<String>[]);
      if (subProductions.isEmpty) {
        // add empty production in case production is already empty
        subProductions.add('');
      }
    } else if (previousToken.tokenType == TokenType.production &&
        token.tokenType == TokenType.operator &&
        token.lexeme == '::=') {
      if (subProductions.isNotEmpty) {
        subProductions.removeLast();
      }
      if (subProductions.isEmpty) {
        // in case last production is empty, add a empty string
        subProductions.add(Token.empty.lexeme);
      }
      _leftSideToken = previousToken;
    } else {
      subProductions.add(token.lexeme);
    }
  }

  void _delegateState(Token previousToken, Token token) {
    switch (_state) {
      case SyntacticState.openedProduction:
        return _productionState(previousToken, token);
      case SyntacticState.openedAttribution:
        return _attributionState(token);
      case SyntacticState.nil:
        break;
    }
  }

  void start(List<Token> tokenList) {
    var previousToken = Token.empty;
    iterateTokens:
    for (final token in tokenList) {
      if (token.tokenType == TokenType.comment) {
        // Skip COMMENT to not mess with syntactic analysis
        continue iterateTokens;
      }
      if (_state == SyntacticState.nil) {
        if (token.tokenType == TokenType.operator) {
          _leftSideToken = previousToken;
          if (token.lexeme == '=') {
            _state = SyntacticState.openedAttribution;
          } else if (token.lexeme == '::=') {
            if (previousToken.tokenType != TokenType.production) {
              throw ('$previousToken is not a production, please fix your grammar');
            }
            _state = SyntacticState.openedProduction;
          }
        }
      } else {
        _delegateState(previousToken, token);
      }
      previousToken = token;
    }
  }
}
