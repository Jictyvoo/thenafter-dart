import 'package:test/test.dart';
import 'package:thenafter_dart/src/controllers/abstract_analyzer.dart';
import 'package:thenafter_dart/src/controllers/first_follow/first_analyzer.dart';
import 'package:thenafter_dart/thenafter_dart.dart';

import 'subject_productions.dart' show allProductions;

// ignore: camel_case_types
class TestSubject_First extends AbstractAnalyzer with FirstAnalyzer {}

void main() {
  test('test if first set is generating well', () {
    // Define the FIRST set that will be filled after diving in first sets
    final ProductionTerminals firstList = {};
    final firstAnalyzer = TestSubject_First();

    // Compute the FIRST set for the '<expr>' production
    final result = firstAnalyzer.firstOf('<expr>', allProductions, firstList);

    // Check that the computed FIRST set is correct
    const expectedFirstOfExpr = {
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
      '-'
    };

    expect(result, equals(expectedFirstOfExpr));
  });
}
