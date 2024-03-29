import 'package:thenafter_dart/src/controllers/generators/code_language/abstract_generator.dart';
import 'package:thenafter_dart/src/models/code_generator_interface.dart';
import 'package:thenafter_dart/src/models/value/first_follow_result.dart';
import 'package:thenafter_dart/src/models/value/grammar_information.dart';
import 'package:thenafter_dart/src/util/abstract_sanitizer.dart';
import 'package:thenafter_dart/src/util/helpers/string_constants.dart';
import 'package:thenafter_dart/src/util/types_util.dart';

/// The code generator that outputs a code using lua constraints
class PythonGenerator extends AbstractCodeGenerator
    implements CodeGeneratorInterface {
  /// Sanitize a name to be in correct way to be used as an identifier
  String sanitizeName(String productionName) {
    return normalizeIdentifier(
      productionName,
      format: IdentifierFormat.snakeCase,
    );
  }

  String _buildClassDeclaration() {
    return 'class GrammarDefinition:\n'
        '\tdef __init__(self):\n';
  }

  String _buildClassEnd() {
    return '';
  }

  void _buildMapSet(
    final String setName,
    final StringBuffer buffer,
    ProductionTerminals productionSet,
  ) {
    var index = 0;
    buffer.write('$setName = {\n');
    for (final entry in productionSet.entries) {
      if (index > 0) {
        buffer.write(',\n');
      }
      buffer.write('\t\t\t"${entry.key}": {\n');
      // Sub-productions foreach
      var subIndex = 0;
      for (final subProductions in entry.value) {
        if (subIndex > 0) {
          buffer.write(',\n');
        }
        buffer.write('\t\t\t\t${replaceQuote(
          sanitizeTerminal(subProductions, true),
          CHAR_QUOTES,
        )}');
        subIndex += 1;
      }
      buffer.write('\n\t\t\t}');
      index += 1;
    }
    buffer.write('\n\t\t}');
  }

  void _buildMapProductions(
    final StringBuffer buffer,
    ProductionsMap productionSet,
  ) {
    var index = 0;
    buffer.write('{\n');

    for (final entry in productionSet.entries) {
      if (index > 0) {
        buffer.write(',\n');
      }
      buffer.write('\t\t"${entry.key}": [\n');
      // Sub-productions foreach
      var subIndex = 0;
      for (final subProductions in entry.value) {
        if (subIndex > 0) {
          buffer.write(',\n');
        }
        buffer.write('\t\t\t[');
        var counter = 0;
        for (final singleProduction in subProductions) {
          if (counter > 0) {
            buffer.write(', ');
          }
          buffer.write(sanitizeTerminal(singleProduction.lexeme, true));
          counter += 1;
        }
        buffer.write(']');
        subIndex += 1;
      }
      buffer.write('\n\t\t]');
      index += 1;
    }
    buffer.write('\n\t}');
  }

  void _buildGetters(String funcName, String varName, StringBuffer buffer) {
    buffer.writeln(
      '\n\n'
      '\tdef $funcName(self, production_name: str) -> set[str]:'
      '\n\t\tresult = self.$varName[production_name]'
      '\n\t\tif result is None:'
      '\n\t\t\tresult = {}'
      '\n\t\treturn result',
    );
  }

  @override
  void generate(
    StringBuffer buffer,
    GrammarInformation grammarData,
    FirstFollowResult firstFollow, [
    bool generateProductions = false,
  ]) {
    buffer.write(_buildClassDeclaration());

    for (final entry in grammarData.extraDefinitions.entries) {
      buffer.write(
        '\t\tself.${sanitizeName(entry.key)} = ${stringify(entry.value, CHAR_QUOTES)}\n',
      );
    }

    _buildMapSet('\t\tself._first_set', buffer, firstFollow.firstList);
    buffer.write('\n');
    _buildMapSet('\t\tself._follow_set', buffer, firstFollow.followList);
    if (!generateProductions) {
      buffer.write('\n\t\tself.productions = ');
      _buildMapProductions(buffer, grammarData.productions);
    }

    _buildGetters('first', '_first_set', buffer);
    _buildGetters('follow', '_follow_set', buffer);

    buffer.write(_buildClassEnd());
  }
}
