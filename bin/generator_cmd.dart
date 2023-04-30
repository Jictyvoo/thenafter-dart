import 'dart:io';

import 'package:args/args.dart';
import 'package:thenafter_dart/thenafter_dart.dart';

import 'controllers/delegate_generator_language.dart';
import 'util/args_types.dart';
import 'util/output_languages.dart';

OutputLanguage stringToLanguage(String value) {
  for (final language in OutputLanguage.values) {
    if (language.name == value || language.extension == value) {
      return language;
    }
  }
  return OutputLanguage.dart;
}

void execute(
  ArgResults argResults,
  GrammarInformation parseResult,
  FirstFollowResult result,
  String fileName,
) {
  final generateProductions =
      argResults.command?[GeneratedOptions.productions.value] ?? false;
  final outputLanguage = argResults.command?[GeneratedOptions.language.value];
  final selectedLanguage = stringToLanguage(
    outputLanguage ?? OutputLanguage.dart.extension,
  );
  final contentsBuffer = generateFileContents(
    selectedLanguage,
    parseResult,
    result,
    generateProductions,
  );
  final file = File('$fileName.${selectedLanguage.extension}');
  file.writeAsStringSync(contentsBuffer.toString());
}
