import 'dart:io';

import 'package:args/args.dart';
import 'package:thenafter_dart/thenafter_dart.dart';

import 'util/syntactic_generator.dart';

ArgParser _configureArgParser() {
  return ArgParser()
    ..addCommand(
      'generate',
      ArgParser()
        ..addFlag(
          'productions',
          abbr: 'p',
          help: 'During code generation, '
              'generate productions representation from .grm file',
          defaultsTo: true,
        )
        ..addOption(
          'language',
          abbr: 'l',
          help: 'Choose the output language for first, follow and productions',
          defaultsTo: 'v',
          mandatory: false,
        )
        ..addFlag(
          'all',
          abbr: 'a',
          help: 'Parse all in current directory',
          defaultsTo: false,
        ),
    )
    ..addCommand('syntactic');
}

void main(List<String> args) {
  // configure parser, parse args and get it's values
  final argsParser = _configureArgParser();
  final argResults = argsParser.parse(args);
  for (final fileName in argResults.command?.rest ?? ['grammar.grm']) {
    if (!fileName.endsWith('.grm')) {
      continue;
    }
    final byteLines = File(fileName).readAsBytesSync();
    final startTime = DateTime.now();
    final parseResult = BNFParser().start(byteLines);
    final result = FirstFollow().start(
      parseResult.productions,
      parseResult.startSymbol.lexeme,
    );
    print(
      'Finished in ${DateTime.now().difference(startTime).inMicroseconds} '
      'microseconds parse for file $fileName',
    );
    final commandName = argResults.command?.name ?? 'generate';
    if (commandName == 'generate') {
      print('${result.firstList}\n\n${result.followList}');
    } else {
      generateSyntacticFile(parseResult, result);
    }
  }
}
