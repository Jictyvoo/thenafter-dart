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
