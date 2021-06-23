import 'package:thenafter_dart/src/controllers/generators/abstract_generator.dart';
import 'package:thenafter_dart/src/models/code_generator_interface.dart';
import 'package:thenafter_dart/src/models/value/first_follow_result.dart';
import 'package:thenafter_dart/src/models/value/grammar_information.dart';
import 'package:thenafter_dart/src/util/helpers/string_constants.dart';
import 'package:thenafter_dart/src/util/types_util.dart';

class LuaGenerator extends AbstractCodeGenerator
    implements CodeGeneratorInterface {
  String buildImports() {
    return '';
  }

  String buildClassDeclaration() {
    return 'return {';
  }

  String buildClassEnd() {
    return '}';
  }

  void _buildMapSet(
    final String setName,
    final StringBuffer buffer,
    ProductionTerminals productionSet,
  ) {
    var index = 0;
    buffer.write('$setName = {');
    for (final entry in productionSet.entries) {
      if (index > 0) {
        buffer.write(', ');
      }
      buffer.write('["${entry.key}"] = {');
      // Sub-productions foreach
      var subIndex = 0;
      for (final subProductions in entry.value) {
        if (subIndex > 0) {
          buffer.write(', ');
        }
        buffer.write('${replaceQuote(
          sanitizeTerminal(subProductions),
          CHAR_QUOTES,
        )}');
        subIndex += 1;
      }
      buffer.write('}');
      index += 1;
    }
    buffer.write('}');
  }

  void _buildMapProductions(
    final StringBuffer buffer,
    ProductionsMap productionSet,
  ) {
    var index = 0;
    buffer.write('productions = {');

    for (final entry in productionSet.entries) {
      if (index > 0) {
        buffer.write(', ');
      }
      buffer.write('["${entry.key}"] = {');
      // Sub-productions foreach
      var subIndex = 0;
      for (final subProductions in entry.value) {
        if (subIndex > 0) {
          buffer.write(', ');
        }
        buffer.write('{');
        var counter = 0;
        for (final singleProduction in subProductions) {
          if (counter > 0) {
            buffer.write(', ');
          }
          buffer.write('"${singleProduction.lexeme}"');
          counter += 1;
        }
        buffer.write('}');
        subIndex += 1;
      }
      buffer.write('}');
      index += 1;
    }
    buffer.write('}');
  }

  @override
  void generate(
    StringBuffer buffer,
    GrammarInformation grammarData,
    FirstFollowResult firstFollow, [
    bool generateProductions = false,
  ]) {
    buffer.write(buildImports());
    buffer.write(buildClassDeclaration());

    for (final entry in grammarData.extraDefinitions.entries) {
      buffer.write(
        '${sanitizeName(entry.key)} = ${stringifyTerminal(entry.value, CHAR_QUOTES)},',
      );
    }

    _buildMapSet('firstSet', buffer, firstFollow.firstList);
    buffer.write(', ');
    _buildMapSet('followSet', buffer, firstFollow.followList);
    if (generateProductions) {
      buffer.write(', ');
      _buildMapProductions(buffer, grammarData.productions);
    }

    buffer.write(buildClassEnd());
  }
}
