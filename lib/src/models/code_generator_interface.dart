abstract class CodeGeneratorInterface {
  void buildNeededImports(StringBuffer buffer);

  String genFunctionName(String productionName);

  String genFunctionDoc(String name, List<List<String>> productions);
}
