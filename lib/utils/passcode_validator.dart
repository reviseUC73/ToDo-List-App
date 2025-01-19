class PasscodeValidator {
  final String correctPasscode;

  PasscodeValidator({required this.correctPasscode});

  bool validate(String enteredPasscode) {
    return enteredPasscode == correctPasscode;
  }
}