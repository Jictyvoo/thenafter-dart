import 'package:thenafter_dart/src/models/value/token.dart';

import '../../util/types_util.dart';
import '../abstract_analyzer.dart';

mixin FollowAnalyzer on AbstractAnalyzer {
  SymbolSet getFirst(String production, ProductionTerminals firstList) {
    if (isProduction(production)) {
      return firstList[production] ?? <String>{};
    }
    return <String>{}..add(production);
  }

  int getAheadSymbol(String lookingFor, List<Token> searchIn) {
    for (var index = 0; index < searchIn.length; index++) {
      final value = searchIn[index];
      if (value.lexeme == lookingFor) {
        if (index + 1 < searchIn.length) {
          return index + 1;
        }
        return searchIn.length;
      }
    }
    return -1;
  }

  SymbolSet followOf(
    String productionName,
    ProductionsMap allProductions, {
    required ProductionTerminals followList,
    required SymbolSet hasToo,
    required ProductionTerminals firstList,
    required Map<String, SymbolSet> allProducers,
  }) {
    if (followList.containsKey(productionName)) {
      return followList[productionName]!;
    }
    final followSet = joinSets({}, hasToo);
    followList[productionName] = followSet;
    if (!allProducers.containsKey(productionName)) {
      throw ('Production $productionName is not used, please fix it');
    }
    for (final producedBy in allProducers[productionName] ?? <String>{}) {
      final producerProduction = allProductions[producedBy] ?? <List<Token>>[];
      for (var counter = 0; counter < producerProduction.length; counter++) {
        final index = getAheadSymbol(
          productionName,
          producerProduction[counter],
        );
        var getProducedByFollow = false;
        /*print(
          '$index $productionName ---> $producedBy ::= ${producerProduction[counter]}',
        );*/
        if (index >= producerProduction[counter].length) {
          getProducedByFollow = true;
        } else if (index > 0) {
          final aheadSymbol = producerProduction[counter][index];
          final aheadFirstSet = getFirst(aheadSymbol.lexeme, firstList);
          joinSets(followSet, aheadFirstSet);
          if (aheadFirstSet.contains("''") || aheadFirstSet.contains('')) {
            getProducedByFollow = true;
          }
        } else {
          continue;
        }
        if (getProducedByFollow) {
          joinSets(
            followSet,
            followOf(
              producedBy,
              allProductions,
              followList: followList,
              hasToo: {},
              firstList: firstList,
              allProducers: allProducers,
            ),
          );
        }
      }
    }
    return followSet;
  }
}
