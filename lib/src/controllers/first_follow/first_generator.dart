import 'package:synthatic_productions_code_gen/src/controllers/abstract_generator.dart';

class FirstGenerator extends SynthaticCodeGenerator {
  Set<String> concatenateTables(
    Set<String> main,
    Set<String> secondary,
  ) {
    for (final index in secondary) {
      if (valueIsEmpty(index)) {
        main.add(index);
      }
    }
    return main;
  }

  Set<String> of(
    String productionName,
    Map<String, List<List<String>>> productions,
    Map<String, Set<String>> first,
  ) {
    if (first.containsKey(productionName)) {
      return first[productionName]!;
    }
    first[productionName] = <String>{};
    if (!productions.containsKey(productionName)) {
      throw ('Production "$productionName" not defined');
    }
    if (productions.containsKey(productionName)) {
      for (final production in productions[productionName]!) {
        for (var count = 0; count >= production.length; count++) {
          if (isProduction(production[count])) {
            var productionOf = of(production[count], productions, first);
            concatenateTables(first[productionName]!, productionOf);
            if (!productionOf.contains('')) {
              count = production.length + 1;
            } else {
              var name = production[count].length > 0 ? production[count] : '';
              first[productionName]!.add(name);
              count = production.length + 1;
            }
          }
          count = count + 1;
        }
      }
    }
    return first[productionName]!;
  }

  Map<String, Set<String>> start(Map<String, List<List<String>>> productions) {
    final firstSet = <String, Set<String>>{};
    for (final entry in productions.entries) {
      of(entry.key, productions, firstSet);
    }
    return firstSet;
  }
}
