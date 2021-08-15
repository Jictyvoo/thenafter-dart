library synthatic_productions_code_gen;

import 'package:thenafter_dart/src/controllers/generators/abstract_generator.dart';
import 'package:thenafter_dart/src/models/code_generator_interface.dart';
import 'package:thenafter_dart/src/models/value/token.dart';
import 'package:thenafter_dart/src/util/helpers/string_helper.dart';
import 'package:thenafter_dart/src/util/types_util.dart';

/// A PythonCodeGenerator.
class PythonGenerator extends AbstractCodeGenerator
    implements SyntacticGeneratorInterface {
  @override
  void buildNeededImports(StringBuffer buffer) {
    buffer.writeln('from collections import Callable\n');
    buffer.writeln('from models.business.sythatic_node import SynthaticNode');
    buffer.writeln(
      'from models.errors.synthatic_errors import SynthaticParseErrors',
    );
    buffer.writeln('from util.data_structure.queue import Queue');
    buffer.writeln('from util.productions import EProduction');
    buffer.writeln('from util.token_types import TokenTypes\n');
  }

  void buildTypeDeclarations(StringBuffer buffer) {
    buffer.writeln(
      'productions_functions: dict[EProduction, '
      'Callable[[Queue, list[SynthaticParseErrors]], SynthaticNode]]',
    );
  }

  @override
  String genFunctionName(String productionName) {
    return 'sp_' + sanitizeName(productionName);
  }

  @override
  String genFunctionDoc(String name, SubProductionsList productions) {
    final buffer = StringBuffer('\t"""\n');
    buffer.writeln('\tThis function parse tokens for production $name\\n');
    buffer.writeln('\tAccepted productions below\\n');
    for (final production in productions) {
      buffer.writeln('\t${production.toString()}\\n');
    }
    // closing buffer
    buffer.writeln('\t"""');
    return buffer.toString();
  }

  String buildVerifyTokenTypes(
    Set<String> listTerminals,
    final GivenInformation givenInformation, [
    final bool varDeclaration = true,
  ]) {
    final buffer = StringBuffer(varDeclaration ? 'token_verification = ' : '');
    final replacements = givenInformation;
    var counter = 0;
    for (final terminal in listTerminals) {
      if (replacements.containsKey(terminal)) {
        if (counter > 0) {
          buffer.write(' or ');
        }
        buffer.write('temp_token_type == ${replacements[terminal]}');
        counter++;
      }
    }
    if (counter == 0) {
      return '';
    }
    return buffer.toString();
  }

  String _buildVerifications(
    final String firstProduction,
    final List<Token> productionsList,
    final GivenInformation givenInformation,
    final Map<String, Set<String>> firsts,
    final int amountTabs,
  ) {
    final excludedTerminals = givenInformation.keys.toSet();
    final buffer = StringBuffer();
    for (var index = 1; index < productionsList.length; index++) {
      final production = productionsList[index];
      final subIsProduction = production.tokenType == TokenType.production;
      final firstSet = firsts[production] ?? <String>{};
      final tabsPlus = <String>[
        StringHelper.multiplyString('\t', amountTabs),
        StringHelper.multiplyString('\t', amountTabs + 1),
        StringHelper.multiplyString('\t', amountTabs + 2),
      ];
      const localFirstSetName = 'local_first_set';
      if (subIsProduction) {
        buffer.writeln('${tabsPlus[0]}# Predicting for production $production');
        buffer.writeln(
          '${tabsPlus[0]}$localFirstSetName = ${listTerminalToString(
            firstSet,
            excluded: excludedTerminals,
          )}',
        );
        final tokenTypesVerification = buildVerifyTokenTypes(
          firstSet,
          givenInformation,
        );
        final tokenTypesCondition =
            tokenTypesVerification.isNotEmpty ? ' or token_verification' : '';
        if (tokenTypesVerification.isNotEmpty) {
          buffer.writeln(
            '${tabsPlus[0]}temp_token_type = token_queue.peek() and token_queue.peek().get_token_type()',
          );
          buffer.writeln(
            '${tabsPlus[0]}$tokenTypesVerification',
          );
        }
        buffer.writeln(
          '${tabsPlus[0]}if token_queue.peek() and token_queue.peek().get_lexeme() in $localFirstSetName$tokenTypesCondition:',
        );
        buffer.writeln(
          '${tabsPlus[1]}temp = ${genFunctionName(production.lexeme)}(token_queue, error_list)',
        );
        buffer.writeln('${tabsPlus[1]}if temp and temp.is_not_empty():');
        buffer.writeln('${tabsPlus[2]}node.add(temp)');
      } else {
        buffer.write(
            '${tabsPlus[0]}if token_queue.peek() and token_queue.peek()');
        if (givenInformation.containsKey(production)) {
          buffer.writeln(
            '.get_token_type() == ${givenInformation[production]}:',
          );
        } else {
          buffer.writeln(
            '.get_lexeme() == ${sanitizeTerminal(production.lexeme)}:',
          );
        }
        buffer.writeln('${tabsPlus[1]}node.add(token_queue.remove())');
      }

      // In case failed the predict, add error to list
      if (!firstSet.contains('')) {
        var expectedTokens = '[${sanitizeTerminal(production.lexeme)}]';
        if (subIsProduction) {
          expectedTokens = localFirstSetName;
        }
        buffer.writeln(
          '\t\telse:\n\t\t\terror_list.append('
          'SynthaticParseErrors'
          "('$firstProduction', $expectedTokens, token_queue.peek())"
          ')',
        );
      }
    }
    return buffer.toString();
  }

  StringBuffer _writeFunctionBegin(
    final String name,
    final SubProductionsList productions,
  ) {
    const generalSignature = 'token_queue: Queue, '
        'error_list: list[SynthaticParseErrors]';
    final signature =
        'def ${genFunctionName(name)}($generalSignature) -> SynthaticNode:\n';
    final buffer = StringBuffer(signature);
    buffer.writeln(genFunctionDoc(name, productions));

    buffer.writeln("\tnode = SynthaticNode(production='$name')");
    buffer.writeln('\tif not token_queue.peek():\n\t\treturn node');
    return buffer;
  }

  String buildFunction(
    final String name,
    final SubProductionsList productions,
    final Map<String, Set<String>> firsts,
    final GivenInformation givenInformation,
  ) {
    // Signature and general function declarations
    final excludedTerminals = givenInformation.keys.toSet();
    final buffer = _writeFunctionBegin(name, productions);
    buffer.writeln(
      '\ttemp_token_type = token_queue.peek().get_token_type()',
    );
    // Start of analysing
    for (var index = 0; index < productions.length; index++) {
      final production = productions[index];
      final firstProduction = production[0];
      buffer.writeln('\t# Predicting for production ${production.toString()}');
      final firstSet = firsts[firstProduction] ?? <String>{};
      final tokenTypesVerification = buildVerifyTokenTypes(
        firstSet,
        givenInformation,
        false,
      );
      final tokenTypesCondition = tokenTypesVerification.isNotEmpty
          ? ' or $tokenTypesVerification'
          : '';

      buffer.write('\t');
      if (index > 0) {
        buffer.write('el');
      }
      if (firstProduction.tokenType == TokenType.production) {
        buffer.writeln(
          'if token_queue.peek() and token_queue.peek().get_lexeme() in ${listTerminalToString(
            firstSet,
            excluded: excludedTerminals,
          )}$tokenTypesCondition:',
        );
        buffer.writeln(
          '\t\ttemp = ${genFunctionName(firstProduction.lexeme)}(token_queue, error_list)',
        );
        buffer.writeln('\t\tif temp and temp.is_not_empty():');
        buffer.writeln('\t\t\tnode.add(temp)');
      } else if (firstProduction.lexeme.isNotEmpty) {
        buffer.write('if token_queue.peek() and token_queue.peek()');
        if (givenInformation.containsKey(firstProduction)) {
          buffer.writeln(
            '.get_token_type() == ${givenInformation[firstProduction]}:',
          );
        } else {
          buffer.writeln(
            '.get_lexeme() == ${sanitizeTerminal(firstProduction.lexeme)}:',
          );
        }
        buffer.writeln('\t\tnode.add(token_queue.remove())');
      } else {
        buffer.writeln('se:\n\t\treturn node');
      }
      // Sub productions foreach
      final tabAmount = firstSet.contains('') ? 1 : 2;
      buffer.writeln(
        _buildVerifications(
          name,
          production,
          givenInformation,
          firsts,
          tabAmount,
        ),
      );
    }

    buffer.writeln('\treturn node');
    return buffer.toString();
  }
}
