import 'package:thenafter_dart/src/models/value/token.dart';

/// A map that helps binding generic terminals
typedef GivenInformation = Map<String, String>;

/// Map to help storing sub productions for a given production
typedef SubProductionsList = List<List<Token>>;

/// A productions map that stores the
/// production as key and sub-production as value
typedef ProductionsMap = Map<String, SubProductionsList>;

/// A symbol set that stores all symbols
typedef SymbolSet = Set<String>;

/// A map with all terminals generated for each production
typedef ProductionTerminals = Map<String, SymbolSet>;

/// Iterator for input that receives character by character
typedef InputIterator = Iterable<int>;
