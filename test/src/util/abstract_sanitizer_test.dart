import 'package:test/test.dart';
import 'package:thenafter_dart/src/util/abstract_sanitizer.dart';

class _TestSubject with AbstractSanitizer {}

void main() {
  final sanitizer = _TestSubject();
  test('normalizeIdentifier camelCase', () {
    const input1 = 'this_is-a_    test_identifier';
    const output1 = 'thisIsATestIdentifier';
    expect(
      sanitizer.normalizeIdentifier(input1, format: IdentifierFormat.camelCase),
      equals(output1),
    );
  });

  test('normalizeIdentifier snakeCase', () {
    const input2 = 'this-   _ is -a_- --TEST____identifier';
    const output2 = 'this_is_a_test_identifier';
    expect(
      sanitizer.normalizeIdentifier(input2, format: IdentifierFormat.snakeCase),
      equals(output2),
    );
  });

  test('normalizeIdentifier pascalCase', () {
    const input3 = 'this_is-a_Test_---_----__--identifier';
    const output3 = 'ThisIsATestIdentifier';
    expect(
      sanitizer.normalizeIdentifier(
        input3,
        format: IdentifierFormat.pascalCase,
      ),
      equals(output3),
    );
  });
}
