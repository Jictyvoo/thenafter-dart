import 'package:thenafter_dart/generators.dart';
import 'package:thenafter_dart/thenafter_dart.dart';

import '../util/output_languages.dart';

StringBuffer generateFileContents(
  OutputLanguage outputLanguage,
  GrammarInformation grammarData,
  FirstFollowResult firstFollow,
  bool generateProductions,
) {
  final buffer = StringBuffer();
  CodeGeneratorInterface generator;
  switch (outputLanguage) {
    case OutputLanguage.lua:
      generator = LuaGenerator();
      break;
    case OutputLanguage.dart:
      generator = DartGenerator();
      break;
    case OutputLanguage.java:
      throw UnimplementedError('Java language generator unimplemented');
    case OutputLanguage.python:
      generator = PythonGenerator();
      break;
    case OutputLanguage.vlang:
      throw UnimplementedError('V language generator unimplemented');
  }
  generator.generate(
    buffer,
    grammarData,
    firstFollow,
    generateProductions,
  );
  return buffer;
}
