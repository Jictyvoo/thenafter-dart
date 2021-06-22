import '../../util/types_util.dart';
import '../abstract_analyzer.dart';

mixin FirstAnalyzer on AbstractAnalyzer {
  Set<String> firstOf(
    String productionName,
    ProductionsMap allProductions,
    ProductionTerminals firstList,
  ) {
    if (firstList.containsKey(productionName)) {
      return firstList[productionName]!;
    }
    final firstSet = <String>{};
    firstList[productionName] = firstSet;
    if (!allProductions.containsKey(productionName)) {
      throw ('Production "$productionName" not defined');
    }
    for (final production in allProductions[productionName]!) {
      for (var count = 0; count < production.length; count += 1) {
        if (isProduction(production[count])) {
          // in case first element in allProductions is a sub-production,
          // it will get the first set of it
          var firstOfSubProduction = firstOf(
            production[count],
            allProductions,
            firstList,
          );
          joinSets(firstSet, firstOfSubProduction);
          // if sub production doesn't have a empty first, stop loop
          if (!firstOfSubProduction.contains('')) {
            count = production.length + 1;
          }
        } else {
          // if during the loop it gets a terminal symbol, add it to first set
          // FIXME: When ProductionsMap type change to Token, verify "if (token.tokenType != TokenType.genericTerminal)"
          firstSet.add(sanitizeTerminals(production[count]));
          count = production.length + 1;
        }
      }
    }

    return firstSet;
  }
}
