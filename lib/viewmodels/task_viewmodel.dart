import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:todo_list/utils/date_formatter.dart';
import '../models/task.dart';

class TaskViewModel with ChangeNotifier {
  List<Task> _tasks = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<Task> get tasks => _tasks; // Get tasks
  bool get isLoading => _isLoading; // Get loading state
  bool get hasError => _errorMessage != null; // Check if there’s an error
  String? get errorMessage => _errorMessage; // Get the error message

  // Fetch tasks from the API
  Future<void> fetchTasks({
    int offset = 0,
    int limit = 20,
    String sortBy = 'createdAt',
    bool isAsc = true,
    String? status,
  }) async {
    final String url =
        'https://todo-list-api-mfchjooefq-as.a.run.app/todo-list';
    final queryParameters = {
      'offset': offset.toString(),
      'limit': limit.toString(),
      'sortBy': sortBy,
      'isAsc': isAsc.toString(),
      if (status != null) 'status': status,
    };

    final uri = Uri.parse(url).replace(queryParameters: queryParameters);

    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        final List<Task> fetchedTasks = (data['tasks'] as List)
            .map((taskJson) => Task.fromJson(taskJson))
            .toList();

        _tasks = fetchedTasks;
      } else {
        throw Exception(
            'Failed to load tasks. Status code: ${response.statusCode}');
      }
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Map<String, List<Task>> getGroupedTasksWithReadableDates() {
    Map<String, List<Task>> groupedTasks = {};

    for (var task in _tasks) {
      String readableDate = DateFormatter.getReadableDate(task.createdAt);

      if (!groupedTasks.containsKey(readableDate)) {
        groupedTasks[readableDate] = [];
      }

      groupedTasks[readableDate]!.add(task);
    }

    return groupedTasks;
  }
}
