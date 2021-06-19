import 'abstract_analyzer.dart';
import 'first_follow/first_analyzer.dart';
import 'first_follow/follow_generator.dart';

class FirstFollow extends AbstractAnalyzer with FirstAnalyzer, FollowAnalyzer {
  final Map<String, Set<String>> allProducers;

  FirstFollow() : allProducers = <String, Set<String>>{};

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

  Map<String, Set<String>> start(
    Map<String, List<List<String>>> productions, [
    String startSymbol = '',
  ]) {
    final firstList = <String, Set<String>>{};
    for (final entry in productions.entries) {
      itProduces(entry.key, entry.value);
      firstOf(entry.key, productions, firstList);
    }
    final followList = <String, Set<String>>{
      startSymbol: <String>{"'\$'"}
    };
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
    return firstList;
  }
}
