import 'package:thenafter_dart/src/models/value/token.dart';

typedef GivenInformation = Map<String, String>;
typedef SubProductionsList = List<List<Token>>;
typedef ProductionsMap = Map<String, SubProductionsList>;
typedef SymbolSet = Set<String>;
typedef ProductionTerminals = Map<String, SymbolSet>;

/// Iterator for input that receives character by character
typedef InputIterator = Iterable<int>;
