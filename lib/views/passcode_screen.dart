import 'package:flutter/material.dart';
import 'package:todo_list/utils/passcode_validator.dart';

class PasscodeScreen extends StatefulWidget {
  const PasscodeScreen({super.key});

  @override
  State<PasscodeScreen> createState() => _PasscodeScreenState();
}

class _PasscodeScreenState extends State<PasscodeScreen> {
  final PasscodeValidator passcodeValidator =
      PasscodeValidator(correctPasscode: "123456");

  String enteredPasscode = "";

  void _addDigit(String digit) {
    if (enteredPasscode.length < 6) {
      setState(() {
        enteredPasscode += digit;
      });

      if (enteredPasscode.length == 6) {
        _validatePasscode();
      }
    }
  }

  void _removeDigit() {
    if (enteredPasscode.isNotEmpty) {
      setState(() {
        enteredPasscode =
            enteredPasscode.substring(0, enteredPasscode.length - 1);
      });
    }
  }

  void _validatePasscode() {
    if (passcodeValidator.validate(enteredPasscode)) {
      Navigator.pushReplacementNamed(context, '/taskManager');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Incorrect Passcode'),
          duration: Duration(seconds: 2),
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
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
            children: List.generate(6, (index) {
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 18),
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
          // Keypad
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 45),
            child: GridView.builder(
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
                childAspectRatio: 1,
              ),
              itemCount: 12,
              itemBuilder: (context, index) {
                if (index == 9) {
                  return const SizedBox.shrink(); // Empty Space for layout
                } else if (index == 10) {
                  return GestureDetector(
                    onTap: () => _addDigit("0"),
                    child: CircleAvatar(
                      radius: 40,
                      backgroundColor: Colors.grey[300],
                      child: Text(
                        "0",
                        style: TextStyle(
                          fontSize: 56,
                          color: Colors.grey[600],
                        ),
                      ),
                    ),
                  );
                } else if (index == 11) {
                  return GestureDetector(
                    onTap: _removeDigit,
                    child: CircleAvatar(
                      radius: 40,
                      backgroundColor: Colors.red,
                      child: const Icon(
                        Icons.backspace,
                        color: Colors.white,
                        size: 56,
                      ),
                    ),
                  );
                } else {
                  return GestureDetector(
                    onTap: () => _addDigit((index + 1).toString()),
                    child: CircleAvatar(
                      radius: 40,
                      backgroundColor: Colors.grey[300],
                      child: Text(
                        (index + 1).toString(),
                        style: TextStyle(
                          fontSize: 56,
                          color: Colors.grey[600],
                        ),
                      ),
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
