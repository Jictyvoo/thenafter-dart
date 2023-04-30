enum ArgsCommands { generated, syntactic, format }

extension ArgsCommandsUtil on ArgsCommands {
  String get value {
    switch (this) {
      case ArgsCommands.generated:
        return 'generate';
      case ArgsCommands.syntactic:
        return 'syntactic';
      case ArgsCommands.format:
        return 'fmt';
    }
  }
}

enum GeneratedOptions { all, productions, language, abstractSyntaxTree }

extension GeneratedOptionsUtil on GeneratedOptions {
  String get value {
    switch (this) {
      case GeneratedOptions.all:
        return 'all';
      case GeneratedOptions.productions:
        return 'productions';
      case GeneratedOptions.language:
        return 'language';
      case GeneratedOptions.abstractSyntaxTree:
        return 'ast';
    }
  }

  String get abbreviation {
    switch (this) {
      case GeneratedOptions.all:
        return 'a';
      case GeneratedOptions.productions:
        return 'p';
      case GeneratedOptions.language:
        return 'l';
      case GeneratedOptions.abstractSyntaxTree:
        return '';
    }
  }
}
