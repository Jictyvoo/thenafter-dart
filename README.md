# Thenafter - Dart

The dart implementation of `thenafter`, a library that parses the **BNF** `.grm` file and produces the first and follow sets.
This implementation also generates syntactic functions from the grammar.

## Getting Started

Import this library in your project, load file contents as you wish, then send a Iterable<int> to `BNFParser`.

## Future plans

As this lib was built in _dart_, and does not use any additional dependencies, in the future it is planned to compile and publish this lib in JS using dart's transpiler.

```shell script
dartdevc -o test.js lib/thenafter_dart.dart
```

Or create a main containing desired API and compile it using `dart2js`.

## How to contribute

- Currently we support code generation for a few languages, so you can add or update any generator you want.
- Also, testing is never enough, so you can add more tests to ensure the library is consistent and hard to break.
- Update the library documentation, making it more understandable.
