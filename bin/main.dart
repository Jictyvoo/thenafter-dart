import 'dart:io';

import 'package:thenafter_dart/thenafter_dart.dart';

void main() {
  final startTime = DateTime.now();
  final parseResult = BNFParser().start(
    File('grammar.grm').readAsBytesSync(),
  );
  final result = FirstFollow().start(
    parseResult.productions,
    parseResult.startSymbol.lexeme,
  );
  print(
    'Finished in ${DateTime.now().difference(startTime).inMicroseconds} microseconds',
  );
  //print('${result.firstList}\n\n${result.followList}');
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
  for (final currentProduction in parseResult.productions.entries) {
    fileBuffer.writeln(
      generator.buildFunction(
        currentProduction.key,
        currentProduction.value,
        result.firstList,
        givenInfo,
      ),
    );
  }

  final file = File('./synthatic_productions.log');
  file.writeAsStringSync(fileBuffer.toString());
}
