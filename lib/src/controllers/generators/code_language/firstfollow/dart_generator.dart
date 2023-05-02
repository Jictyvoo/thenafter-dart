import 'package:thenafter_dart/src/controllers/generators/code_language/abstract_generator.dart';
import 'package:thenafter_dart/src/models/code_generator_interface.dart';
import 'package:thenafter_dart/src/models/value/first_follow_result.dart';
import 'package:thenafter_dart/src/models/value/grammar_information.dart';
import 'package:thenafter_dart/src/util/abstract_sanitizer.dart';
import 'package:thenafter_dart/src/util/helpers/string_constants.dart';
import 'package:thenafter_dart/src/util/types_util.dart';

/// The code generator that outputs a code using dart constraints
class DartGenerator extends AbstractCodeGenerator
    implements CodeGeneratorInterface {
  /// Sanitize a name to be in correct way to be used as an identifier
  String sanitizeName(String productionName) {
    return normalizeIdentifier(
      productionName,
      format: IdentifierFormat.camelCase,
    );
  }

  String _buildClassDeclaration() {
    return 'abstract class GrammarDefinition {\n';
  }

  String _buildClassEnd() {
    return '\n}\n';
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
      buffer.write("\t\t'${entry.key}': {\n");
      // Sub-productions foreach
      var subIndex = 0;
      for (final subProductions in entry.value) {
        if (subIndex > 0) {
          buffer.write(',\n');
        }
        final sanitized = sanitizeTerminal(subProductions, true);
        buffer.write('\t\t\t${replaceQuote(
          sanitized == "'\$'" ? "'\\\$'" : sanitized,
          CHAR_SINGLE_QUOTE,
        )}');
        subIndex += 1;
      }
      buffer.write('\n\t\t}');
      index += 1;
    }
    buffer.write('\n\t}');
  }

  void _buildMapProductions(
    final StringBuffer buffer,
    ProductionsMap productionSet,
  ) {
    var index = 0;
    buffer.write('\tstatic const productions = {\n');

    for (final entry in productionSet.entries) {
      if (index > 0) {
        buffer.write(',\n');
      }
      buffer.write("\t\t'${entry.key}' : [\n");
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
        '\tstatic const ${sanitizeName(entry.key)} = ${stringify(entry.value, CHAR_SINGLE_QUOTE)};\n',
      );
    }

    _buildMapSet('\tstatic const firstSet', buffer, firstFollow.firstList);
    buffer.write(';\n');
    _buildMapSet('\tstatic const followSet', buffer, firstFollow.followList);
    if (!generateProductions) {
      buffer.write(';\n');
      _buildMapProductions(buffer, grammarData.productions);
    }
    buffer.write(';');

    buffer.write(_buildClassEnd());
  }
}
