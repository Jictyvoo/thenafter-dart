import 'package:synthatic_productions_code_gen/src/controllers/abstract_analyzer.dart';

mixin FollowAnalyzer on AbstractAnalyzer {
  Set<String> getFirst(String production, Map<String, Set<String>> firstList) {
    if (isProduction(production)) {
      return firstList[production] ?? <String>{};
    }
    return <String>{}..add(production);
  }

  Set<String> followOf(
    String productionName,
    Map<String, List<List<String>>> allProductions, {
    required Map<String, Set<String>> followList,
    required Set<String> hasToo,
    required Map<String, Set<String>> firstList,
    required Map<String, Set<String>> allProducers,
  }) {
    if (followList.containsKey(productionName)) {
      return followList[productionName]!;
    }
    final followSet = joinSets({}, hasToo);
    followList[productionName] = followSet;
    if (!allProducers.containsKey(productionName)) {
      throw ('Production $productionName is not used, please fix it');
    }
    final concatenateList = <String, Set<String>>{};
    /*for (final key in allProducers[productionName] ?? <String>{}) {
      for (var count = 1; count < allProductions[key].length; count++) {
        for (var index = 1;
            index < allProductions[key][count].length;
            index++) {
          final value = allProductions[key][count][index];
          if (value == productionName) {
            if (index == allProductions[key][count].length) {
              toConcatenate(
                followSet,
                followOf(key, {}, allProducers),
              );
            } else if (index > 1) {
              toConcatenate(followSet, firstList[key]);
              if (firstList[key]["''"]) {
                toConcatenate(followSet, followOf(key, {}, allProducers));
              }
            } else {
              final newFirst = getFirst(allProductions[key][count][index + 1]);
              toConcatenate(followSet, newFirst);
            }
            index = allProductions[key][count].length + 1;
          }
        }
      }
    }*/
    return followSet;
  }
}
