import 'package:thenafter_dart/src/util/types_util.dart';

import 'token.dart';

class GrammarInformation {
  // Known definitions
  final Token startSymbol;
  final String name;
  final String author;
  final String version;
  final String about;
  final bool caseSensitive;

  // Generated elements
  final ProductionsMap productions;
  final Map<String, String> extraDefinitions;

  const GrammarInformation({
    required this.startSymbol,
    String? name,
    String? author,
    String? version,
    String? about,
    this.caseSensitive = true,
    this.extraDefinitions = const <String, String>{},
    this.productions = const <String, List<List<String>>>{},
  })  : author = author ?? 'Thenafter',
        name = name ?? 'Thenafter: Loaded.grm',
        version = version ?? 'v0.0.1',
        about = about ?? 'Generated with the help of Thenafter';

  @override
  String toString() {
    return 'GrammarInformation{'
        'startSymbol: $startSymbol, name: $name, '
        'author: $author, version: $version, '
        'about: $about, caseSensitive: $caseSensitive'
        '}';
  }
}
