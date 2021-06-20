import 'package:synthatic_productions_code_gen/src/models/value/first_follow_result.dart';

import 'abstract_analyzer.dart';
import 'first_follow/first_analyzer.dart';
import 'first_follow/follow_analyzer.dart';

class FirstFollow extends AbstractAnalyzer with FirstAnalyzer, FollowAnalyzer {
  final Map<String, Set<String>> allProducers;
  final Map<String, Set<String>> firstList;
  final Map<String, Set<String>> followList;

  FirstFollow()
      : allProducers = <String, Set<String>>{},
        firstList = <String, Set<String>>{},
        followList = <String, Set<String>>{};

  /// Method to identify who produce every production in list
  void itProduces(String parentProduction, List<List<String>> subProductions) {
    for (final symbolList in subProductions) {
      for (final symbol in symbolList) {
        if (isProduction(symbol)) {
          final producer = allProducers[symbol] ?? <String>{};
          if (!allProducers.containsKey(symbol)) {
            allProducers[symbol] = producer;
          }
          producer.add(parentProduction);
        }
      }
    }
  }

  FirstFollowResult start(
    Map<String, List<List<String>>> productions, [
    String startSymbol = '',
  ]) {
    firstList.clear();
    followList.clear();
    followList[startSymbol] = <String>{"'\$'"};
    for (final entry in productions.entries) {
      itProduces(entry.key, entry.value);
      firstOf(entry.key, productions, firstList);
    }
    followLoop:
    for (final entry in productions.entries) {
      if (entry.key == startSymbol) {
        continue followLoop;
      }
      followOf(
        entry.key,
        productions,
        followList: followList,
        hasToo: <String>{},
        firstList: firstList,
        allProducers: allProducers,
      );
    }
    return FirstFollowResult(firstList, followList);
  }
}
