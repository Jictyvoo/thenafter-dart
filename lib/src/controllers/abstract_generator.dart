abstract class SynthaticCodeGenerator {
  bool isProduction(String toTest) {
    return toTest.startsWith('<') && toTest.endsWith('>');
  }
}
