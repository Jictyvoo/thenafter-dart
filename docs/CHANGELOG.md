## [0.0.1] - 20210815: First release version.

### Library

- Parse `.grm` files
- Analyze grammar productions
    - Generate a First-set
    - Generate a Follow-set
- Output a generated code with productions map, first and follow sets
    - Dart
    - Lua

### Binary

- Take a file from the args
- Select a output language
- Choose if generates in output file the productions map

## [0.5.0] - 20210815: Documentation, examples and code style

- Documented all public APIs

## [0.6.0] - 20230426: Parse, generation, first-follow fixes

- Update used dependencies
- Add unit-tests for `FirstAnalyzer` and `FollowAnalyzer`
- Change default code generation to be **dart**
- `GrammarDefinition` generator
    - Add a new _*Python*_ generator
    - Fix Dart generation
- Fix `FirstAnalyzer`
    - Add _empty_ to first set when needed
- **BNFParser**
    - Fix lexical parse when a **identifier** is joined with a **string**
    - Convert `<>` to be a **empty** production on lexical
    - On syntactic, add the possibility to declare variables in the middle of file
        - Previously it should be declared at first, now you can declare it after start declaring
          productions
    - Add treatment to duplicated production declarations
        - Now, when a production is declared twice it will be treated as an OR
