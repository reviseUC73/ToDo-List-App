import 'package:flutter/material.dart';
import 'package:todo_list/views/passcode_screen.dart';
import 'views/task_manager.dart';
import 'package:provider/provider.dart';
import 'viewmodels/task_viewmodel.dart';

// void main() {
//   runApp(
//     ChangeNotifierProvider(
//       create: (_) => TaskViewModel(), // Provide TaskViewModel
//       child: MaterialApp(
//         debugShowCheckedModeBanner: false,
//         home: TaskManager(), // Home screen
//       ),
//     ),
//   );
// }

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<TaskViewModel>(
          create: (_) => TaskViewModel(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/passcode',
        routes: {
          '/passcode': (context) => const PasscodeScreen(),
          '/taskManager': (context) => const TaskManager(),
        },
      ),
    );
  }
}
