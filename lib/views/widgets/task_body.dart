import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo_list/viewmodels/task_viewmodel.dart';
import 'task_card.dart';

class TaskBody extends StatelessWidget {
  final TaskViewModel taskViewModel;
  final String status;

  const TaskBody({
    super.key,
    required this.taskViewModel,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    final groupedTasks = taskViewModel.getGroupedTasksWithReadableDates();

    if (taskViewModel.isLoading && taskViewModel.tasks.isEmpty) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (taskViewModel.hasError) {
      return Center(
        child: Text(
          taskViewModel.errorMessage ?? 'Failed to load tasks.',
          style: TextStyle(color: Colors.red, fontSize: 16),
        ),
      );
    }

    return NotificationListener<ScrollNotification>(
      onNotification: (scrollInfo) {
        if (scrollInfo.metrics.pixels >=
                scrollInfo.metrics.maxScrollExtent - 200 &&
            taskViewModel.hasMore &&
            !taskViewModel.isLoading) {
          taskViewModel.fetchMoreTasks(status: status);
        }
        return false;
      },
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 25),
        itemCount: groupedTasks.length + (taskViewModel.hasMore ? 1 : 0),
        itemBuilder: (context, index) {
          if (index == groupedTasks.length) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0),
                child: CircularProgressIndicator(),
              ),
            );
          }

          final entry = groupedTasks.entries.toList()[index];
          final readableDate = entry.key;
          final tasks = entry.value;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 6.0,
                  vertical: 12.0,
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
              ...tasks.map((task) => Slidable(
                    key: ValueKey(task.id),
                    endActionPane: ActionPane(
                      motion: const ScrollMotion(),
                      children: [
                        SlidableAction(
                          onPressed: (context) {
                            taskViewModel.removeTask(task.id);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('${task.title} deleted'),
                              ),
                            );
                          },
                          backgroundColor: Colors.redAccent,
                          foregroundColor: Colors.white,
                          icon: Icons.delete,
                          label: 'Delete',
                        ),
                      ],
                    ),
                    child: TaskCard(task: task),
                  )),
            ],
          );
        },
      ),
    );
  }
}
