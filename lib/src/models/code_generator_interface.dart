import '../util/types_util.dart';
import 'value/first_follow_result.dart';
import 'value/grammar_information.dart';

/// A interface that guides a syntactic generator to build automatically
/// a syntactic analyzer, with a given production list
abstract class SyntacticGeneratorInterface {
  /// Build all imports that the generated code will need
  void buildNeededImports(StringBuffer buffer);

  /// Generate a function name in the way the language allows
  String genFunctionName(String productionName);

  /// Generate a documentation of a function to provide help during
  /// generation analysis
  String genFunctionDoc(String name, SubProductionsList productions);
}

/// An interface for all code generators that will be generate data extracted
/// from a grammar
abstract class CodeGeneratorInterface {
  /// Generates data into a StringBuffer, that is the result of
  /// grammar productions and a first-follow sets
  void generate(
    StringBuffer buffer,
    GrammarInformation grammarData,
    FirstFollowResult firstFollow, [
    bool generateProductions = false,
  ]);
}
