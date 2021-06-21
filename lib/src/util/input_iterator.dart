abstract class InputIterator {
  Future<Iterable<String>> iterateLines();

  Iterable<String> iterateLinesSync();

  Stream<int> iterateCharacters();

  Iterable<int> iterateCharactersSync();
}
