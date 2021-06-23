import 'package:thenafter_dart/thenafter_dart.dart';

import '../util/output_languages.dart';

StringBuffer generateFileContents(
  OutputLanguage outputLanguage,
  GrammarInformation grammarData,
  FirstFollowResult firstFollow,
  bool generateProductions,
) {
  final buffer = StringBuffer();
  switch (outputLanguage) {
    case OutputLanguage.lua:
      LuaGenerator().generate(
        buffer,
        grammarData,
        firstFollow,
        generateProductions,
      );
      break;
    case OutputLanguage.dart:
      throw UnimplementedError('Dart language generator unimplemented');
    case OutputLanguage.java:
      throw UnimplementedError('Java language generator unimplemented');
    case OutputLanguage.python:
      throw UnimplementedError('Python language generator unimplemented');
    case OutputLanguage.vlang:
      throw UnimplementedError('V language generator unimplemented');
  }
  return buffer;
}
