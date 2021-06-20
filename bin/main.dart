import 'dart:io';

import 'package:thenafter_dart/thenafter_dart.dart';

import 'models/source_firsts.dart';
import 'models/source_productions.dart';

void main() {
  final result = FirstFollow().start(SourceProductions, '<Program>');
  print(result.firstList);
  print('\n${result.followList}');
  final generator = PythonGenerator();
  final fileBuffer = StringBuffer();
  final givenInfo = <String, String>{
    'Identifier': 'TokenTypes.IDENTIFIER',
    'DecLiteral': 'TokenTypes.NUMBER',
    'OctLiteral': 'TokenTypes.NUMBER',
    'HexLiteral': 'TokenTypes.NUMBER',
    'FloatLiteral': 'TokenTypes.NUMBER',
    'StringLiteral': 'TokenTypes.STRING',
  };
  generator.buildNeededImports(fileBuffer);
  generator.buildTypeDeclarations(fileBuffer);
  for (final currentProduction in SourceProductions.entries) {
    fileBuffer.writeln(
      generator.buildFunction(
        currentProduction.key,
        currentProduction.value,
        SourceFirst,
        givenInfo,
      ),
    );
  }

  final file = File('./synthatic_productions.log');
  file.writeAsStringSync(fileBuffer.toString());
}
