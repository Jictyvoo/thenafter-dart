/// An enumeration of the basic types available for fields.
enum BasicTypes {
  /// Indicates that the field has a custom type name.
  custom,

  /// Indicates that the field is of type string.
  string,

  /// Indicates that the field is of type boolean.
  boolean,

  /// Indicates that the field is of type integer.
  integer,

  /// Indicates that the field is of type unsigned integer.
  unsignedInteger,

  /// Indicates that the field is of type float.
  float,

  /// Indicates that the field is of type double.
  double
}

/// An enumeration of the complex types available for fields.
enum ComplexType {
  /// Indicates that the field is not of a complex type.
  none,

  /// Indicates that the field is of type list.
  list,

  /// Indicates that the field is of type map.
  map,

  /// Indicates that the field is of type set.
  set,

  /// Indicates whether the type should be generated as a reference,
  /// preventing cycle declaration and other problems
  reference
}

/// Represents a field type with a [kind], [complexType], and [customTypeName].
class FieldType {
  /// The [BasicTypes] of the field.
  final BasicTypes kind;

  /// The [ComplexType] of the field.
  final ComplexType complexType;

  /// In case the field kind was [BasicTypes.custom], it will define the type name of the field.
  final String customTypeName;

  /// Creates a new instance of [FieldType] with the given [kind], [customTypeName], and [complexType].
  const FieldType(
    this.kind, {
    this.customTypeName = '',
    this.complexType = ComplexType.none,
  });

  @override
  String toString() {
    return '{"FieldType": {"kind": "$kind", "complexType": "$complexType", "customTypeName": "$customTypeName"}}';
  }
}

/// Represents a field definition with a [name] and a [type].
class FieldDefinition {
  /// The name of the field.
  final String name;

  /// The [FieldType] of the field.
  final FieldType type;

  /// Creates a new instance of [FieldDefinition] with the given [name] and [type].
  const FieldDefinition(this.name, this.type);

  @override
  String toString() {
    return '{"FieldDefinition":{"name": "$name", "type": $type}}';
  }
}

/// Represents a field value with a [definition] and a [value]
class FieldValue<T> {
  /// The [FieldDefinition] of the field value.
  final FieldDefinition definition;

  /// The value of the field.
  final T value;

  /// Creates a new instance of [FieldValue] with the given [definition] and [value].
  const FieldValue(this.definition, {required this.value});

  @override
  String toString() {
    return '{"FieldValue": {"definition": $definition, "value": "$value"}}';
  }
}
