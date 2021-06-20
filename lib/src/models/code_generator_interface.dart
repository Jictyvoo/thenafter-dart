import '../util/types_util.dart';

abstract class CodeGeneratorInterface {
  void buildNeededImports(StringBuffer buffer);

  String genFunctionName(String productionName);

  String genFunctionDoc(String name, SubProductionsList productions);
}
