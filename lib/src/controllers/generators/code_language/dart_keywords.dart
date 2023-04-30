/// A mixin containing all Dart language keywords and a method to normalize it as identifier
mixin DartKeywords {
  static const _reservedKeywords = {
    'abstract',
    'else',
    'import',
    'show',
    'as',
    'enum',
    'in',
    'static',
    'assert',
    'export',
    'interface',
    'super',
    'async',
    'extends',
    'is',
    'switch',
    'await',
    'extension',
    'late',
    'sync',
    'break',
    'external',
    'library',
    'this',
    'case',
    'factory',
    'mixin',
    'throw',
    'catch',
    'false',
    'new',
    'true',
    'class',
    'final',
    'null',
    'try',
    'const',
    'finally',
    'on',
    'typedef',
    'continue',
    'for',
    'operator',
    'var',
    'covariant',
    'Function',
    'part',
    'void',
    'default',
    'get',
    'required',
    'while',
    'deferred',
    'hide',
    'rethrow',
    'with',
    'do',
    'if',
    'return',
    'yield',
    'dynamic',
    'implements',
    'set'
  };

  /// Takes a String and checks if its value is a reserved word,
  /// if it is, it will append a value to make it usable.
  String preventReservedIdentifier(
    final String from, [
    final String valueToAppend = 'Prod',
  ]) {
    if (!_reservedKeywords.contains(from)) {
      return from;
    }

    return '$from$valueToAppend';
  }
}
