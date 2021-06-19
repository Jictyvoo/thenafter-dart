import 'package:synthatic_productions_code_gen/src/controllers/abstract_production_analyzer.dart';

class FirstGenerator extends AbstractProductionAnalyzer {
  Set<String> joinSets(
    Set<String> main,
    Set<String> secondary,
  ) {
    for (final index in secondary) {
      if (!valueIsEmpty(index)) {
        main.add(index);
      }
    }
    return main;
  }

  Set<String> of(
    String productionName,
    Map<String, List<List<String>>> allProductions,
    Map<String, Set<String>> first,
  ) {
    if (first.containsKey(productionName)) {
      return first[productionName]!;
    }
    final firstSet = <String>{};
    first[productionName] = firstSet;
    if (!allProductions.containsKey(productionName)) {
      throw ('Production "$productionName" not defined');
    }
    for (final production in allProductions[productionName]!) {
      for (var count = 0; count < production.length; count++) {
        if (isProduction(production[count])) {
          // in case first element in allProductions is a sub-production,
          // it will get the first set of it
          var firstOfSubProduction = of(
            production[count],
            allProductions,
            first,
          );
          joinSets(firstSet, firstOfSubProduction);
          // if sub production doesn't have a empty first, stop loop
          if (!firstOfSubProduction.contains('')) {
            count = production.length + 1;
          }
        } else {
          // if during the loop it gets a terminal symbol, add it to first set
          firstSet.add(sanitizeTerminals(production[count]));
        }
        count = count + 1;
      }
    }

    return firstSet;
  }

  Map<String, Set<String>> start(Map<String, List<List<String>>> productions) {
    final firstSet = <String, Set<String>>{};
    for (final entry in productions.entries) {
      of(entry.key, productions, firstSet);
    }
    return firstSet;
  }
}
