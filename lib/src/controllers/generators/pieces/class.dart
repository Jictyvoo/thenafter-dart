import 'field.dart';

class ClassDefinition {
  final String name;
  final List<FieldDefinition> fieldList;

  const ClassDefinition(this.name, this.fieldList);

  @override
  String toString() {
    return '{"ClassDefinition":{"name": "$name", "fieldList": $fieldList}}';
  }
}

class StaticValuesDefinition {
  final List<FieldValue> fieldList;

  const StaticValuesDefinition(this.fieldList);

  @override
  String toString() {
    return '{"StaticValuesDefinition": {"fieldList": $fieldList}}';
  }
}

class CodeStructureDefinition {
  final List<ClassDefinition> classList;
  final List<StaticValuesDefinition> staticValuesList;

  const CodeStructureDefinition(
    this.classList, {
    this.staticValuesList = const [],
  });

  @override
  String toString() {
    return '{"CodeStructureDefinition": {"classList": $classList, "staticValuesList": $staticValuesList}}';
  }
}
