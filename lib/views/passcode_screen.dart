import 'package:flutter/material.dart';
import 'package:todo_list/utils/passcode_validator.dart';

class PasscodeScreen extends StatefulWidget {
  const PasscodeScreen({super.key});

  @override
  State<PasscodeScreen> createState() => _PasscodeScreenState();
}

class _PasscodeScreenState extends State<PasscodeScreen> {
  static const int passcodeLength = 6;
  static const String correctPasscode = "123456";

  final PasscodeValidator passcodeValidator =
      PasscodeValidator(correctPasscode: correctPasscode);

  String enteredPasscode = "";

  // Add a digit to the passcode
  void _addDigit(String digit) {
    if (enteredPasscode.length < passcodeLength) {
      setState(() {
        enteredPasscode += digit;
      });

      if (enteredPasscode.length == passcodeLength) {
        _validatePasscode();
      }
    }
  }

  // Remove the last digit from the passcode
  void _removeDigit() {
    if (enteredPasscode.isNotEmpty) {
      setState(() {
        enteredPasscode =
            enteredPasscode.substring(0, enteredPasscode.length - 1);
      });
    }
  }

  // Validate the entered passcode
  void _validatePasscode() {
    if (passcodeValidator.validate(enteredPasscode)) {
      Navigator.pushReplacementNamed(context, '/TaskManagerScreen').catchError(
        (error) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Error navigating to TaskManagerScreen.'),
              duration: Duration(seconds: 2),
            ),
          );
        },
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Incorrect Passcode'),
          action: SnackBarAction(
            label: 'Hint',
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Passcode: 123456')),
              );
            },
          ),
          duration: const Duration(seconds: 2),
        ),
      );
      setState(() {
        enteredPasscode = "";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 208, 214, 248),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 100),
            const Text(
              "This is just sample UI.\nOpen to create your style :D",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 40),
            // Passcode Dots
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(passcodeLength, (index) {
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  width: 16,
                  height: 16,
                  decoration: BoxDecoration(
                    color: index < enteredPasscode.length
                        ? Colors.grey[500]
                        : Colors.grey[300],
                    shape: BoxShape.circle,
                  ),
                );
              }),
            ),
            const SizedBox(height: 40),
            // Keypad
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 45),
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                ),
                itemCount: 12,
                itemBuilder: (context, index) {
                  if (index == 9) {
                    return const SizedBox.shrink(); // Empty Space for layout
                  } else if (index == 10) {
                    return _buildKey('0', Colors.grey[300]);
                  } else if (index == 11) {
                    return GestureDetector(
                      onTap: _removeDigit,
                      child: CircleAvatar(
                        radius: 40,
                        backgroundColor: Colors.red,
                        child: const Icon(
                          Icons.backspace,
                          color: Colors.white,
                          size: 28,
                        ),
                      ),
                    );
                  } else {
                    return _buildKey((index + 1).toString(), Colors.grey[300]);
                  }
                },
              ),
            ),
            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }

  // Builds a key for the keypad
  Widget _buildKey(String label, Color? backgroundColor) {
    return GestureDetector(
      onTap: () => _addDigit(label),
      child: CircleAvatar(
        radius: 40,
        backgroundColor:
            (backgroundColor != null) ? backgroundColor : Colors.grey[300],
        child: Text(
          label,
          style: const TextStyle(fontSize: 28, color: Colors.grey),
        ),
      ),
    );
  }
}
