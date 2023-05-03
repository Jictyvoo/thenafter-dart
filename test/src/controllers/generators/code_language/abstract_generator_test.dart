import 'package:test/test.dart';
import 'package:thenafter_dart/src/controllers/generators/code_language/abstract_generator.dart';
import 'package:thenafter_dart/src/util/helpers/string_constants.dart';

class _TestSubject extends AbstractCodeGenerator {
  const _TestSubject();
}

void _testStringify(final _TestSubject testSubject) {
  // Test with empty string
  expect(testSubject.stringify(''), equals("''"));

  // Test with string containing special characters
  expect(
    testSubject.stringify('Hello "world"!', CHAR_QUOTES),
    equals('"Hello \\"world\\"!"'),
  );

  // Test with string containing backslashes
  expect(
    testSubject.stringify('C:\\Users\\John\\Documents\\file.txt'),
    equals("'C:\\\\Users\\\\John\\\\Documents\\\\file.txt'"),
  );

  // Test with string containing newlines and tabs
  expect(
    testSubject.stringify('This\nis\ta\nmultiline\tstring'),
    equals("'This\\nis\\ta\\nmultiline\\tstring'"),
  );
}

void main() {
  const testSubject = _TestSubject();
  test('stringify should escape all special characters', () {
    const input = 'This is a \n test \\ string with "special" \'characters\'.';
    const expected =
        '\'This is a \\n test \\\\ string with "special" \\\'characters\\\'.\'';
    final result = testSubject.stringify(input);
    expect(result, equals(expected));
  });

  test('test stringify with more cases', () => _testStringify(testSubject));
}
