import 'package:flutter/material.dart';
import 'package:todo_list/viewmodels/task_viewmodel.dart';
import 'task_card2.dart';

class TaskBody extends StatelessWidget {
  final TaskViewModel taskViewModel;

  const TaskBody({super.key, required this.taskViewModel});

  @override
  Widget build(BuildContext context) {
    final groupedTasks = taskViewModel.getGroupedTasksWithReadableDates();

    if (taskViewModel.isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (taskViewModel.hasError) {
      return Center(
        child: Text(
          'Failed to load tasks.',
          style: TextStyle(color: Colors.red, fontSize: 16),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
      physics: const AlwaysScrollableScrollPhysics(),
      itemCount: groupedTasks.length,
      itemBuilder: (context, index) {
        final entry = groupedTasks.entries.toList()[index];
        final readableDate = entry.key;
        final tasks = entry.value;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 16.0,
              ),
              child: Text(
                readableDate,
                style: const TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ),
            ...tasks.map((task) => TaskCard(task: task)),
          ],
        );
      },
    );
  }
}
