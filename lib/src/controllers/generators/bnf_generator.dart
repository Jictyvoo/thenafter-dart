import 'dart:math' as math;

import 'package:thenafter_dart/src/controllers/generators/code_language/abstract_generator.dart';
import 'package:thenafter_dart/src/models/value/grammar_information.dart';
import 'package:thenafter_dart/src/util/helpers/string_constants.dart';
import 'package:thenafter_dart/src/util/types_util.dart';

/// The code generator that outputs a code using dart constraints
class BNFGrammarGenerator extends AbstractCodeGenerator {
  void _buildMapProductions(
    final StringBuffer buffer,
    ProductionsMap productionSet,
  ) {
    var index = 0;
    for (final entry in productionSet.entries) {
      if (index > 0) {
        buffer.write('\n');
      }

      buffer.write('${entry.key} ::= ');
      // Sub-productions foreach
      var subIndex = 0;
      for (final subProductions in entry.value) {
        if (subIndex > 0) {
          buffer.write(' |\n\t');
        }
        var counter = 0;
        for (final singleProduction in subProductions) {
          if (counter > 0) {
            buffer.write(' ');
          }
          buffer.write(sanitizeTerminal(singleProduction.lexeme));
          counter += 1;
        }
        subIndex += 1;
      }
      buffer.write('\n');
      index += 1;
    }
  }

  int _countMaxSize(Iterable<String> keyList) {
    var count = -1;
    for (final element in keyList) {
      count = math.max(count, element.length);
    }

    return count;
  }

  void _writeHeader(StringBuffer buffer, GrammarInformation grammarData) {
    final headerMap = {
      '"Name"': stringify(grammarData.name, CHAR_SINGLE_QUOTE),
      '"Author"': stringify(grammarData.author, CHAR_SINGLE_QUOTE),
      '"Version"': stringify(grammarData.version, CHAR_SINGLE_QUOTE),
      '"About"': stringify(grammarData.about, CHAR_SINGLE_QUOTE),
      '"Case Sensitive"': stringify(
        grammarData.caseSensitive.toString(),
        CHAR_SINGLE_QUOTE,
      ),
      '"Start Symbol"': grammarData.startSymbol.lexeme
    };

    final maxKeySize = _countMaxSize(headerMap.keys);
    for (final entry in headerMap.entries) {
      final formattedKey = entry.key.padRight(maxKeySize, ' ');
      buffer.write('$formattedKey = ${entry.value}\n');
    }
  }

  /// Execute the BNF grammar generation using the given information
  void call(StringBuffer buffer, GrammarInformation grammarData) {
    _writeHeader(buffer, grammarData);

    buffer.write('\n');
    final maxKeySize = _countMaxSize(grammarData.extraDefinitions.keys);
    for (final entry in grammarData.extraDefinitions.entries) {
      if (entry.key == 'Start Symbol') {
        continue;
      }
      final formattedKey = entry.key.padRight(maxKeySize, ' ');
      buffer.write('$formattedKey = ${entry.value}\n');
    }

    buffer.write('\n');
    _buildMapProductions(buffer, grammarData.productions);
  }
}
