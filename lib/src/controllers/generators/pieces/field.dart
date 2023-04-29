enum BasicTypes {
  custom,
  string,
  boolean,
  integer,
  unsinedInteger,
  float,
  double
}

enum ComplexType {
  none,
  list,
  map,
  set,

  /// Indicates whether the type should be generated as a reference,
  /// preventing cycle declaration and other problems
  reference
}

class FieldType {
  final BasicTypes kind;
  final ComplexType complexType;
  final String customTypeName;

  const FieldType(
    this.kind, {
    this.customTypeName = "",
    this.complexType = ComplexType.none,
  });

  @override
  String toString() {
    return '{"FieldType": {"kind": "$kind", "complexType": "$complexType", "customTypeName": "$customTypeName"}}';
  }
}

class FieldDefinition {
  final String name;
  final FieldType type;

  const FieldDefinition(this.name, this.type);

  @override
  String toString() {
    return '{"FieldDefinition":{"name": "$name", "type": $type}}';
  }
}

class FieldValue<T> {
  final FieldDefinition definition;
  final T value;

  const FieldValue(this.definition, {required this.value});

  @override
  String toString() {
    return '{"FieldValue": {"definition": $definition, "value": "$value"}}';
  }
}
