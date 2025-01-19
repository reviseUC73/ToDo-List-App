import 'package:flutter_test/flutter_test.dart';
import 'package:todo_list/viewmodels/task_viewmodel.dart';

void main() {
  group('TaskViewModel', () {
    late TaskViewModel viewModel;

    setUp(() {
      viewModel = TaskViewModel();
    });

    test('Initial state should have no tasks and be ready to load', () {
      expect(viewModel.tasks, isEmpty);
      expect(viewModel.isLoading, isFalse);
      expect(viewModel.hasMore, isTrue);
      expect(viewModel.hasError, isFalse);
    });

    test('Fetch tasks assigns random attributes to new tasks', () async {
      await viewModel.fetchTasks(status: 'TODO');
      for (var task in viewModel.tasks) {
        expect(task.icon, isNotNull);
        expect(task.color, isNotNull);
      }
    });

    test('Fetch more tasks appends data to the list', () async {
      await viewModel.fetchTasks(status: 'TODO');
      final initialCount = viewModel.tasks.length;

      await viewModel.fetchMoreTasks(status: 'TODO');
      expect(viewModel.tasks.length, greaterThan(initialCount));
    });

    test('Handles errors during task fetching', () async {
      await viewModel.fetchTasks(status: 'INVALID_STATUS');

      expect(viewModel.hasError, isTrue);
      expect(viewModel.errorMessage, isNotNull);
      expect(viewModel.tasks, isEmpty);
    });
  });
}
