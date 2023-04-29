import 'package:thenafter_dart/src/controllers/generators/pieces/class.dart';
import 'package:thenafter_dart/src/controllers/generators/pieces/field.dart';
import 'package:thenafter_dart/src/controllers/parser/lexical_helper.dart';
import 'package:thenafter_dart/src/models/value/grammar_information.dart';
import 'package:thenafter_dart/src/models/value/token.dart';

/// Provides functionality for generating syntactic tree definitions for
/// a given grammar. It includes methods to generate class and field definitions,
/// and a method to generate all definitions for a given grammar.
mixin SyntacticTreeGenerator {
  // TODO: Create to check and mark complex type as reference
  final _usedBy = <String, List<String>>{};

  StaticValuesDefinition _genHeaderInfo(GrammarInformation grammar) {
    final fieldList = <FieldValue<dynamic>>[
      FieldValue(
        const FieldDefinition('About', FieldType(BasicTypes.string)),
        value: grammar.about,
      ),
      FieldValue(
        const FieldDefinition('Case Sensitive', FieldType(BasicTypes.boolean)),
        value: grammar.caseSensitive,
      ),
      FieldValue(
        const FieldDefinition('Version', FieldType(BasicTypes.string)),
        value: grammar.version,
      ),
      FieldValue(
        const FieldDefinition('Author', FieldType(BasicTypes.string)),
        value: grammar.author,
      ),
      FieldValue(
        const FieldDefinition('Name', FieldType(BasicTypes.string)),
        value: grammar.name,
      ),
    ];

    return StaticValuesDefinition(fieldList);
  }

  String _sanitizeProductionName(final String name) {
    final buffer = StringBuffer();
    var index = 0;
    for (final character in name.codeUnits) {
      final isOpen = index == 0 && character == CHAR_LESS_THAN;
      final isClose =
          index == name.length - 1 && character == CHAR_GREATER_THAN;
      index += 1;
      if (isOpen || isClose) {
        continue;
      }
      buffer.writeCharCode(character);
    }

    return buffer.toString();
  }

  List<FieldDefinition> _createFields(
    Map<String, String> extraDefinitions,
    List<Token> tokenList,
  ) {
    final resultList = <FieldDefinition>[
      for (final token in tokenList)
        if (token.tokenType == TokenType.production)
          FieldDefinition(
            _sanitizeProductionName(token.lexeme),
            FieldType(
              BasicTypes.custom,
              customTypeName: _sanitizeProductionName(token.lexeme),
            ),
          )
        else if (token.tokenType == TokenType.genericTerminal &&
            extraDefinitions.keys.contains(token.lexeme))
          FieldDefinition(
            _sanitizeProductionName(token.lexeme),
            const FieldType(BasicTypes.string),
          )
    ];

    return resultList;
  }

  /// Generate all definitions for a grammar in the form of multiple classes
  CodeStructureDefinition genDefinitions(GrammarInformation grammar) {
    final headerDefinition = _genHeaderInfo(grammar);

    final classList = <ClassDefinition>[];
    for (final entry in grammar.productions.entries) {
      final className = _sanitizeProductionName(entry.key);
      final shouldCreateHelperClasses = entry.value.length != 1;
      final fields = <FieldDefinition>[];
      var helperID = 0;
      for (final production in entry.value) {
        final resultFields = _createFields(
          grammar.extraDefinitions,
          production,
        );
        if (shouldCreateHelperClasses) {
          final firstTokenName =
              production.isNotEmpty ? production.first.lexeme : 'first';
          final subClassName =
              '$className Definition ${firstTokenName}_${helperID++}';
          if (resultFields.isNotEmpty) {
            classList.add(ClassDefinition(subClassName, resultFields));
            fields.add(
              FieldDefinition(
                subClassName,
                FieldType(BasicTypes.custom, customTypeName: subClassName),
              ),
            );
          }
        } else {
          fields.addAll(resultFields);
        }
      }
      classList.add(ClassDefinition(className, fields));
    }

    return CodeStructureDefinition(
      classList,
      staticValuesList: [headerDefinition],
    );
  }
}
