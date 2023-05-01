import 'dart:io';

import 'package:args/args.dart';
import 'package:thenafter_dart/src/controllers/generators/code_language/dart_generator.dart';
import 'package:thenafter_dart/src/controllers/generators/syntactic_tree.dart';
import 'package:thenafter_dart/thenafter_dart.dart';

import 'generator_cmd.dart' show stringToLanguage;
import 'util/args_types.dart';
import 'util/output_languages.dart';

class _DefinitionGenerator with SyntacticTreeGenerator {}

void execute(
  ArgResults argResults,
  GrammarInformation parseResult,
  FirstFollowResult result,
  String fileName,
) {
  final outputLanguage = argResults.command?[GeneratedOptions.language.value];
  final selectedLanguage = stringToLanguage(outputLanguage ?? '');

  final contentsBuffer = StringBuffer();
  final generator = DartGenerator(contentsBuffer);
  generator(_DefinitionGenerator().genDefinitions(parseResult));

  final file = File('${fileName}_ast.${selectedLanguage.extension}');
  file.writeAsStringSync(contentsBuffer.toString());
}
