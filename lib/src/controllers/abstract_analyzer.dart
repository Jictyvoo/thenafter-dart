import 'package:thenafter_dart/src/util/abstract_sanitizer.dart';

/// Abstract class that provides default methods to help dealing with
/// the BNF grammar analysis
abstract class AbstractAnalyzer with AbstractSanitizer {
  /// Check whether a string represents a production `<PRODUCTION>` or not
  bool isProduction(String toTest) {
    return toTest.startsWith('<') && toTest.endsWith('>');
  }

  /// Checks if the character has an empty value.
  ///
  /// Commonly used to check terminals
  bool valueIsEmpty(String toTest) {
    return toTest.isEmpty || toTest == "''" || toTest == '""';
  }

  /// Takes two Set objects and return the concatenation of both,
  /// disregarding the empty values using the
  /// method [AbstractAnalyzer.valueIsEmpty]
  Set<String> joinSets(
    Set<String> main,
    Set<String> secondary,
  ) {
    main.addAll(secondary.where((element) => !valueIsEmpty(element)));
    return main;
  }
}
