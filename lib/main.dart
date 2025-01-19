import 'package:flutter/material.dart';
import 'views/task_manager.dart';
import 'package:provider/provider.dart';
import 'viewmodels/task_viewmodel.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => TaskViewModel(), // Provide TaskViewModel
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: TaskManager(), // Home screen
      ),
    ),
  );
}
