import 'package:test/test.dart';
import 'package:thenafter_dart/src/util/abstract_sanitizer.dart';

class _TestSubject with AbstractSanitizer {
  const _TestSubject();
}

class _TestNormalizeIdentifierCase {
  final sanitizer = const _TestSubject();

  final String input;
  final String output;
  final IdentifierFormat format;
  final String Function(String)? unknownCharCallback;

  const _TestNormalizeIdentifierCase({
    required this.input,
    required this.output,
    required this.format,
    this.unknownCharCallback,
  });

  void runTest() {
    final testName = 'normalizeIdentifier `(${format.name}){$input}'
        '${unknownCharCallback == null ? "" : unknownCharCallback.toString()}`';
    test(testName, () {
      expect(
        sanitizer.normalizeIdentifier(
          input,
          format: format,
          unknownCharacterFallback: unknownCharCallback,
        ),
        equals(output),
      );
    });
  }
}

String _as$(String _) {
  return '\$';
}

String _asHexadecimal(String from) {
  final buffer = StringBuffer();
  for (final character in from.codeUnits) {
    buffer.write(character.toRadixString(16));
  }
  return buffer.toString();
}

void main() {
  const testCases = [
    _TestNormalizeIdentifierCase(
      input: 'this_is\t-a_   \n test_identifier',
      output: 'thisIsATestIdentifier',
      format: IdentifierFormat.camelCase,
    ),
    _TestNormalizeIdentifierCase(
      input: 'this-   \t_ is -a_- --TEST_\n__identifier',
      output: 'this_is_a_test_identifier',
      format: IdentifierFormat.snakeCase,
    ),
    _TestNormalizeIdentifierCase(
      input: 'this\r\n_is-a_Test_--\t\t\t--identifier',
      output: 'ThisIsATestIdentifier',
      format: IdentifierFormat.pascalCase,
    ),
    _TestNormalizeIdentifierCase(
      input: '0\tidentifier_number \nQ\t',
      output: '_0IdentifierNumberQ',
      format: IdentifierFormat.pascalCase,
    ),
    _TestNormalizeIdentifierCase(
      input: 'this\tis-a <Test>_-__--<identifier\\%^',
      output: 'ThisIsA\$Test\$\$identifier\$\$\$',
      format: IdentifierFormat.pascalCase,
      unknownCharCallback: _as$,
    ),
    _TestNormalizeIdentifierCase(
      input: 'this\tis-a <Test>_-\$_--<identifier%^`',
      output: 'ThisIsA3cTest3e243cidentifier255e60',
      format: IdentifierFormat.pascalCase,
      unknownCharCallback: _asHexadecimal,
    ),
  ];

  for (final tCase in testCases) {
    tCase.runTest();
  }
}
