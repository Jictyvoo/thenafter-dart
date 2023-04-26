import 'dart:io';

import 'package:thenafter_dart/generators.dart';
import 'package:thenafter_dart/src/models/value/grammar_information.dart';

void execute(String fileName, GrammarInformation parseResult) {
  final file = File('new_$fileName');
  final contentsBuffer = StringBuffer();
  final generator = BNFGrammarGenerator();
  generator(contentsBuffer, parseResult);
  file.writeAsStringSync(contentsBuffer.toString());
}
