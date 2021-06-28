import '../util/types_util.dart';
import 'value/first_follow_result.dart';
import 'value/grammar_information.dart';

abstract class SyntacticGeneratorInterface {
  void buildNeededImports(StringBuffer buffer);

  String genFunctionName(String productionName);

  String genFunctionDoc(String name, SubProductionsList productions);
}

abstract class CodeGeneratorInterface {
  void generate(
    StringBuffer buffer,
    GrammarInformation grammarData,
    FirstFollowResult firstFollow, [
    bool generateProductions = false,
  ]);
}
