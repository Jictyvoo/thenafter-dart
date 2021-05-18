import 'dart:io';

import 'package:synthatic_productions_code_gen/src/controllers/first_follow/first_generator.dart';
import 'package:synthatic_productions_code_gen/src/models/given_information.dart';
import 'package:synthatic_productions_code_gen/src/models/source_firsts.dart';
import 'package:synthatic_productions_code_gen/src/models/source_productions.dart';
import 'package:synthatic_productions_code_gen/src/synthatic_productions_code_gen.dart';

void main() {
  print(FirstGenerator().start(SourceProductions));
  final generator = PythonGenerator();
  final fileBuffer = StringBuffer();
  final givenInfo = GivenInformation(<String, String>{
    'Identifier': 'TokenTypes.IDENTIFIER',
    'DecLiteral': 'TokenTypes.NUMBER',
    'OctLiteral': 'TokenTypes.NUMBER',
    'HexLiteral': 'TokenTypes.NUMBER',
    'FloatLiteral': 'TokenTypes.NUMBER',
    'StringLiteral': 'TokenTypes.STRING',
  });
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

  final file = File('./synthatic_productions.py');
  file.writeAsStringSync(fileBuffer.toString());
}
