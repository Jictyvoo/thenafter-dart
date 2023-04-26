import 'dart:io';

import 'package:args/args.dart';
import 'package:thenafter_dart/thenafter_dart.dart';

import 'generator_cmd.dart' as generator;
import 'util/args_types.dart';
import 'util/syntactic_generator.dart';

ArgParser _configureArgParser() {
  return ArgParser()
    ..addCommand(
      ArgsCommands.generated.value,
      ArgParser()
        ..addFlag(
          GeneratedOptions.productions.value,
          abbr: GeneratedOptions.productions.abbreviation,
          help: 'During code generation, '
              'generate productions representation from .grm file',
          defaultsTo: false,
        )
        ..addOption(
          GeneratedOptions.language.value,
          abbr: GeneratedOptions.language.abbreviation,
          help: 'Choose the output language for first, follow and productions',
          defaultsTo: 'dart',
          mandatory: false,
        ),
    )
    ..addCommand(ArgsCommands.syntactic.value)
    ..addCommand(ArgsCommands.format.value);
}

ArgsCommands _stringToCommand(String? value) {
  for (final command in ArgsCommands.values) {
    if (command.value == value) {
      return command;
    }
  }
  return ArgsCommands.generated;
}

void main(List<String> args) {
  // configure parser, parse args and get it's values
  final argsParser = _configureArgParser();
  final argResults = argsParser.parse(args);
  final fileList = argResults.command?.rest ?? [];

  for (final fileName in fileList.isEmpty ? ['grammar.grm'] : fileList) {
    if (!fileName.endsWith('.grm')) {
      continue;
    }
    final byteLines = File(fileName).readAsBytesSync();
    final startTime = DateTime.now();
    final parseResult = BNFParser().call(byteLines);
    final result = FirstFollow().call(
      parseResult.productions,
      parseResult.startSymbol.lexeme,
    );
    print(
      'Finished in ${DateTime.now().difference(startTime).inMicroseconds} '
      'microseconds parse for file $fileName',
    );
    final commandName = _stringToCommand(argResults.command?.name);
    if (commandName == ArgsCommands.generated) {
      generator.execute(argResults, parseResult, result, fileName);
    } else {
      generateSyntacticFile(parseResult, result);
    }
  }
}
