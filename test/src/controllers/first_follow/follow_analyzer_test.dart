import 'package:test/test.dart';
import 'package:thenafter_dart/src/controllers/abstract_analyzer.dart';
import 'package:thenafter_dart/src/controllers/first_follow/follow_analyzer.dart';
import 'package:thenafter_dart/thenafter_dart.dart';

import 'subject_productions.dart';

// ignore: camel_case_types
class TestSubject_Follow extends AbstractAnalyzer with FollowAnalyzer {}

void main() {
  test('test if follow set is generating well', () {
    // Generate needed info
    const ProductionTerminals firstList = {
      '<S>': {'a'},
      '<B>': {'c'},
      '<C>': {'b', ''},
      '<D>': {'g', 'f', ''},
      '<E>': {'g', ''},
      '<F>': {'f', ''}
    };
    final ProductionTerminals followList = {
      '<S>': {'\$'}
    };
    const producedBy = {
      '<B>': {'<S>'},
      '<D>': {'<S>'},
      '<C>': {'<B>', '<C>'},
      '<E>': {'<D>'},
      '<F>': {'<D>'}
    };

    // Test followOf function
    final followAnalyzer = TestSubject_Follow();
    for (final entry in basicProductions.entries) {
      if (entry.key == '<S>') {
        continue;
      }
      followAnalyzer.followOf(
        entry.key,
        basicProductions,
        followList: followList,
        hasToo: {},
        firstList: firstList,
        allProducers: producedBy,
      );
    }

    const ProductionTerminals expectedFollowList = {
      '<S>': {'\$'},
      '<B>': {'g', 'f', 'h'},
      '<C>': {'g', 'f', 'h'},
      '<D>': {'h'},
      '<E>': {'f', 'h'},
      '<F>': {'h'}
    };

    expect(followList, equals(expectedFollowList));
  });
}
