import 'package:flutter_test/flutter_test.dart';
import 'package:todo_list/utils/passcode_validator.dart';

void main() {
  group('PasscodeValidator', () {
    test('Valid passcode returns true', () {
      final validator = PasscodeValidator(correctPasscode: '123456');
      expect(validator.validate('123456'), isTrue);
    });

    test('Invalid passcode returns false', () {
      final validator = PasscodeValidator(correctPasscode: '123456');
      expect(validator.validate('654321'), isFalse);
    });

    test('Empty passcode returns false', () {
      final validator = PasscodeValidator(correctPasscode: '123456');
      expect(validator.validate(''), isFalse);
    });
  });
}