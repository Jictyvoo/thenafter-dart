# Thenafter - Dart

The dart implementation of `thenafter`, a library that parses the **BNF** `.grm` file and produces the first and follow sets.
This implementation also generates syntactic functions from the grammar.

## Getting Started

Import this library in your project, load file contents as you wish, then send a Iterable<int> to `BNFParser`

## Future plans

As this lib was built in _dart_, and does not use any additional dependencies, in the future it is planned to publish this lib in JS compiled from _dart_ code.

```shell script
dartdevc -o test.js lib/thenafter_dart.dart
```

Or create a main containing desired API and compile it using `dart2js`

## How to contribute

- Currently we support a few languages that can be generated, so you can add or update any generator you want.
- Also, test our library never is enough, so you can add more tests to ensure the library is consistent and hard to break.
- Update the library documentation, making it more understandable
