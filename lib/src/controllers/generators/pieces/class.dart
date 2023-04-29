import 'field.dart';

/// Represents a class definition with a [name] and a list of [FieldDefinition]s.
class ClassDefinition {
  /// The name of the class.
  final String name;

  /// The list of [FieldDefinition]s for the class.
  final List<FieldDefinition> fieldList;

  /// Creates a new instance of [ClassDefinition] with the given [name] and [fieldList].
  const ClassDefinition(this.name, this.fieldList);

  @override
  String toString() {
    return '{"ClassDefinition":{"name": "$name", "fieldList": $fieldList}}';
  }
}

/// Represents a definition of static values with a [fieldList].
class StaticValuesDefinition {
  /// The list of [FieldValue]s for the static values definition.
  final List<FieldValue> fieldList;

  /// Creates a new instance of [StaticValuesDefinition] with the given [fieldList].
  const StaticValuesDefinition(this.fieldList);

  @override
  String toString() {
    return '{"StaticValuesDefinition": {"fieldList": $fieldList}}';
  }
}

/// Represents a definition of a code structure with a [classList] and [staticValuesList].
class CodeStructureDefinition {
  /// The list of [ClassDefinition]s for the code structure definition.
  final List<ClassDefinition> classList;

  /// The list of [StaticValuesDefinition]s for the code structure definition.
  final List<StaticValuesDefinition> staticValuesList;

  /// Creates a new instance of [CodeStructureDefinition] with the given [classList] and [staticValuesList].
  const CodeStructureDefinition(
    this.classList, {
    this.staticValuesList = const [],
  });

  @override
  String toString() {
    return '{"CodeStructureDefinition": {"classList": $classList, "staticValuesList": $staticValuesList}}';
  }
}
