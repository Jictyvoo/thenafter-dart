enum OutputLanguage { lua, dart, java, python, vlang }

extension OutputLanguageUtil on OutputLanguage {
  String get extension {
    switch (this) {
      case OutputLanguage.lua:
        return 'lua';
      case OutputLanguage.dart:
        return 'dart';
      case OutputLanguage.java:
        return 'java';
      case OutputLanguage.python:
        return 'py';
      case OutputLanguage.vlang:
        return 'v';
    }
  }

  String get name {
    switch (this) {
      case OutputLanguage.lua:
        return 'lua';
      case OutputLanguage.dart:
        return 'dart';
      case OutputLanguage.java:
        return 'java';
      case OutputLanguage.python:
        return 'python';
      case OutputLanguage.vlang:
        return 'v';
    }
  }
}
