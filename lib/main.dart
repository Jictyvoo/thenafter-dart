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
    'id': 'TokenTypes.IDENTIFIER',
    'num': 'TokenTypes.NUMBER',
    'str': 'TokenTypes.STRING',
    'log': 'TokenTypes.RESERVED_WORD',
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
