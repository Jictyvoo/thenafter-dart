library synthatic_productions_code_gen;

import 'controllers/abstract_generator.dart';

/// A PythonCodeGenerator.
class PythonGenerator extends SynthaticCodeGenerator {
  void buildNeededImports(StringBuffer buffer) {
    buffer.writeln('from collections import Callable\n');
    buffer.writeln('from models.business.sythatic_node import SynthaticNode');
    buffer.writeln(
      'from models.errors.synthatic_errors import SynthaticParseErrors',
    );
    buffer.writeln('from util.data_structure.queue import Queue');
    buffer.writeln('from util.productions import EProduction\n');
  }

  void buildTypeDeclarations(StringBuffer buffer) {
    buffer.writeln(
      'productions_functions: dict[EProduction, '
      'Callable[[Queue, list[SynthaticParseErrors]], SynthaticNode]]',
    );
  }

  String genFunctionName(String productionName) {
    return 'sp_' + sanitizeName(productionName);
  }

  String genFunctionDoc(String name, List<List<String>> productions) {
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

  String buildFunction(String name, List<List<String>> productions) {
    final generalSignature = 'token_queue: Queue, '
        'error_list: list[SynthaticParseErrors]';
    final signature =
        'def ${genFunctionName(name)}($generalSignature) -> SynthaticNode:\n';
    final buffer = StringBuffer(signature);
    buffer.writeln(genFunctionDoc(name, productions));

    buffer.writeln('\tnode = SynthaticNode()');
    for (var index = 0; index < productions.length; index++) {
      final production = productions[index];
      final firstProduction = production[0];
      buffer.writeln('\t# Predicting for production ${production.toString()}');
      buffer.write('\t');
      if (index > 0) {
        buffer.write('el');
      }
      if (isProduction(firstProduction)) {
        buffer.writeln("if predict(token_queue.peek(), '$firstProduction'):");
        buffer.writeln(
          '\t\ttemp = ${genFunctionName(firstProduction)}(token_queue, error_list)',
        );
        buffer.writeln('\t\tif temp and temp.is_not_empty():');
        buffer.writeln('\t\t\tnode.add(temp)');
      } else if (firstProduction.isNotEmpty) {
        buffer.writeln("if token_queue.peek() == ${sanitizeTerminals(firstProduction)}:");
        buffer.writeln('\t\tnode.add(token_queue.remove())');
      } else {
        buffer.writeln('se:\n\t\treturn node');
      }
      // Sub productions foreach
      for (var subIndex = 1; subIndex < production.length; subIndex++) {
        final subProduction = production[subIndex];
        final subIsProduction = isProduction(subProduction);
        if (subIsProduction) {
          buffer.writeln(
            "\t\tif predict(token_queue.peek(), '$subProduction'):",
          );
          buffer.writeln(
            '\t\t\ttemp = ${genFunctionName(subProduction)}(token_queue, error_list)',
          );
          buffer.writeln('\t\t\tif temp and temp.is_not_empty():');
          buffer.writeln('\t\t\t\tnode.add(temp)');
        } else {
          buffer.writeln("\t\tif token_queue.peek() == ${sanitizeTerminals(subProduction)}:");
          buffer.writeln('\t\t\tnode.add(token_queue.remove())');
        }

        // In case failed the predict, add error to list
        var expectedTokens = '[${sanitizeTerminals(subProduction)}]';
        if (subIsProduction) {
          // TODO get all firsts for this production
          expectedTokens = "['get all firsts for $subProduction "
              "and put here later']";
        }
        buffer.writeln(
          "\t\telse:\n\t\t\terror_list.append("
          "SynthaticParseErrors"
          "($expectedTokens, token_queue.peek())"
          ")",
        );
      }
    }

    buffer.writeln('\treturn node');
    return buffer.toString();
  }
}
