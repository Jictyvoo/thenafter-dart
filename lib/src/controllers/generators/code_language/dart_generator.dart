import 'package:thenafter_dart/src/controllers/generators/pieces/class.dart';
import 'package:thenafter_dart/src/controllers/generators/pieces/field.dart';
import 'package:thenafter_dart/src/util/abstract_sanitizer.dart';
import 'package:thenafter_dart/src/util/helpers/string_helper.dart';

import 'dart_keywords.dart';

class DartGenerator with AbstractSanitizer, DartKeywords {
  final StringBuffer output;

  const DartGenerator(this.output);

  String normalizeCustomTypeName(final String customTypeName) {
    final buffer = StringBuffer();
    var index = 0;
    for (final character in customTypeName.codeUnits) {
      final isAlphabeticUnderline = StringHelper.isAlphabetic(character) ||
          StringHelper.isUnderline(character);
      if (isAlphabeticUnderline ||
          (index > 0 && StringHelper.isNumber(character))) {
        buffer.writeCharCode(character);
      } else if (!StringHelper.isWhitespace(character)) {
        buffer.write(character.toRadixString(16));
      }
      index += 1;
    }
    return buffer.toString();
  }

  String normalizeTypeName(final FieldType type) {
    var result = '';
    switch (type.kind) {
      case BasicTypes.string:
        result = 'String';
        break;
      case BasicTypes.boolean:
        result = 'bool';
        break;
      case BasicTypes.integer:
        result = 'int';
        break;
      case BasicTypes.unsignedInteger:
        result = 'int';
        break;
      case BasicTypes.float:
        result = 'double';
        break;
      case BasicTypes.double:
        result = 'double';
        break;
      case BasicTypes.custom:
        result = normalizeCustomTypeName(type.customTypeName);
        break;
    }

    switch (type.complexType) {
      case ComplexType.none:
        return result;
      case ComplexType.list:
        return 'List<$result>';
      case ComplexType.map:
        return 'Map<String, $result>';
      case ComplexType.set:
        return 'Set<$result>';
      case ComplexType.reference:
        return '$result?';
    }
  }

  void _writeFieldValue(FieldValue fieldValue) {
    var value = fieldValue.value.toString();
    if (fieldValue.definition.type.kind == BasicTypes.string) {
      value = sanitizeTerminal(value, true);
    }
    output.write(
      'const ${normalizeTypeName(fieldValue.definition.type)} '
      '${normalizeIdentifier(fieldValue.definition.name, format: IdentifierFormat.camelCase)} = $value;\n',
    );
  }

  void _writeStaticClass(StaticValuesDefinition staticClass) {
    for (final fieldValue in staticClass.fieldList) {
      _writeFieldValue(fieldValue);
    }
  }

  void call(final CodeStructureDefinition codeDefinition) {
    // Start by static values
    for (final staticClass in codeDefinition.staticValuesList) {
      _writeStaticClass(staticClass);
    }

    output.write('\n');
    for (final classDef in codeDefinition.classList) {
      _writeClassDef(classDef);
    }
  }

  void _writeClassDef(ClassDefinition classDef) {
    final className = normalizeIdentifier(
      normalizeCustomTypeName(classDef.name),
      format: IdentifierFormat.pascalCase,
    );
    output.write('class $className {\n');

    final constructorParams = <String>[];
    for (final field in classDef.fieldList) {
      final fieldName = preventReservedIdentifier(
        normalizeIdentifier(field.name, format: IdentifierFormat.camelCase),
      );
      constructorParams.add(fieldName);
      output.write(
        '\t${normalizeIdentifier(normalizeTypeName(field.type), format: IdentifierFormat.pascalCase)} $fieldName;\n',
      );
    }

    // Generate constructor
    output.write('\n\t$className(');
    var index = 0;
    for (final attribute in constructorParams) {
      if (index > 0) {
        output.write(',');
      }
      output.write('this.$attribute');
      index += 1;
    }
    output.write(');\n\n');

    output.write('}\n\n');
  }
}
