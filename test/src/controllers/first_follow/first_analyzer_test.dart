import 'package:test/test.dart';
import 'package:thenafter_dart/src/controllers/abstract_analyzer.dart';
import 'package:thenafter_dart/src/controllers/first_follow/first_analyzer.dart';
import 'package:thenafter_dart/thenafter_dart.dart';

import 'subject_productions.dart' show expressionProductions, basicProductions;

// ignore: camel_case_types
class TestSubject_First extends AbstractAnalyzer with FirstAnalyzer {}

void _firstTest(
  final ProductionsMap fromProduction,
  final String ofProduction, {
  required final SymbolSet expected,
}) {
  // Define the FIRST set that will be filled after diving in first sets
  final ProductionTerminals firstList = {};
  final firstAnalyzer = TestSubject_First();

  // Compute the FIRST set for the given production
  final result = firstAnalyzer.firstOf(ofProduction, fromProduction, firstList);

  expect(result, equals(expected));
}

void main() {
  test('test first set generation from `expression` grammar', () {
    const expectedFirst = {
      '(',
      '0',
      '1',
      '2',
      '3',
      '4',
      '5',
      '6',
      '7',
      '8',
      '9',
      '*',
      '/',
      '+',
      '-',
      ''
    };
    _firstTest(expressionProductions, '<expr>', expected: expectedFirst);
  });

  test('test first set generation from `basic` grammar', () {
    const expectedFirst = {
      '<S>': {'a'},
      '<B>': {'c'},
      '<C>': {'b', ''},
      '<D>': {'g', 'f', ''},
      '<E>': {'g', ''},
      '<F>': {'f', ''},
    };
    for (final entry in expectedFirst.entries) {
      _firstTest(basicProductions, entry.key, expected: entry.value);
    }
  });
}
