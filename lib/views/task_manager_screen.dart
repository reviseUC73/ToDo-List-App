import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/task_viewmodel.dart';
import 'widgets/task_header.dart';
import 'widgets/task_body.dart';

class TaskManagerScreen extends StatefulWidget {
  const TaskManagerScreen({super.key});

  @override
  State<TaskManagerScreen> createState() => _TaskManagerScreenState();
}

class _TaskManagerScreenState extends State<TaskManagerScreen> {
  int selectedIndex = 0;
  final List<String> tabs = ['TODO', 'DOING', 'DONE'];

  @override
  void initState() {
    super.initState();
    Future.microtask(() => _fetchInitialTasks());
  }

  Future<void> _fetchInitialTasks() async {
    final taskViewModel = Provider.of<TaskViewModel>(context, listen: false);
    await taskViewModel.fetchTasks(status: tabs[selectedIndex]);
  }

  Future<void> _fetchTasksByStatus(String status) async {
    final taskViewModel = Provider.of<TaskViewModel>(context, listen: false);
    await taskViewModel.fetchTasks(status: status);
  }

  @override
  Widget build(BuildContext context) {
    final taskViewModel = Provider.of<TaskViewModel>(context);

    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            SliverToBoxAdapter(
              child: TaskHeader(
                selectedIndex: selectedIndex,
                tabs: tabs,
                onTabSelected: (index) async {
                  setState(() {
                    selectedIndex = index;
                  });
                  await _fetchTasksByStatus(tabs[index]);
                },
              ),
            ),
          ];
        },
        body: TaskBody(
          status: tabs[selectedIndex],
          taskViewModel: taskViewModel,
        ),
      ),
    );
  }
}
