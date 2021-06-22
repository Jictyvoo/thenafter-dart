enum ArgsCommands { generated, syntactic }

extension ArgsCommandsUtil on ArgsCommands {
  String get value {
    switch (this) {
      case ArgsCommands.generated:
        return 'generate';
      case ArgsCommands.syntactic:
        return 'syntactic';
    }
  }
}

enum GeneratedOptions { productions, language, all }

extension GeneratedOptionsUtil on GeneratedOptions {
  String get value {
    switch (this) {
      case GeneratedOptions.productions:
        return 'productions';
      case GeneratedOptions.language:
        return 'language';
      case GeneratedOptions.all:
        return 'all';
    }
  }

  String get abbreviation {
    switch (this) {
      case GeneratedOptions.productions:
        return 'p';
      case GeneratedOptions.language:
        return 'l';
      case GeneratedOptions.all:
        return 'a';
    }
  }
}
