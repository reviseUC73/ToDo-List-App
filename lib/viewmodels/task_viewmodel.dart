import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:todo_list/utils/date_formatter.dart';
import '../models/task.dart';

class TaskViewModel with ChangeNotifier {
  final List<Task> _tasks = [];

  final List<IconData> _icons = [
    Icons.task,
    Icons.star,
    Icons.check_circle,
    Icons.access_alarm,
    Icons.bookmark,
  ];

  final List<Color> _colors = [
    Colors.blue,
    Colors.green,
    Colors.orange,
    Colors.purple,
    Colors.red,
  ];

  final Random _random = Random();

  final int _limit = 10;
  bool _isLoading = false;
  bool _hasMore = true;
  String? _errorMessage;
  int _currentPage = 1;
  int _totalPages = 1;

  List<Task> get tasks => _tasks;
  bool get isLoading => _isLoading;
  bool get hasError => _errorMessage != null;
  String? get errorMessage => _errorMessage;
  bool get hasMore => _hasMore;

  void removeTask(String taskId) {
    _tasks.removeWhere((task) => task.id == taskId);
    notifyListeners();
  }

  Future<void> fetchTasks({
    String sortBy = 'createdAt',
    bool isAsc = true,
    required String status,
  }) async {
    _resetPagination();
    await _loadTasks(sortBy: sortBy, isAsc: isAsc, status: status);
  }

  Future<void> fetchMoreTasks({
    String sortBy = 'createdAt',
    bool isAsc = true,
    required String status,
  }) async {
    if (!_hasMore || _isLoading) return;
    _currentPage += 1;
    await _loadTasks(sortBy: sortBy, isAsc: isAsc, status: status);
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

  Future<void> _loadTasks({
    String sortBy = 'createdAt',
    bool isAsc = true,
    required String status,
  }) async {
    final String url =
        'https://todo-list-api-mfchjooefq-as.a.run.app/todo-list';
    final queryParameters = {
      'offset': (_currentPage - 1)
          .toString(), // -1 because req api para of offset field -> offset = page - 1
      'limit': _limit.toString(),
      'sortBy': sortBy,
      'isAsc': isAsc.toString(),
      'status': status,
    };

    final uri = Uri.parse(url).replace(queryParameters: queryParameters);
    _isLoading = true;
    notifyListeners();

    try {
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        final List<Task> fetchedTasks = (data['tasks'] as List)
            .map((taskJson) => Task.fromJson(taskJson))
            .toList();

        _assignRandomAttributes(fetchedTasks);
        _currentPage = data['pageNumber'];
        _totalPages = data['totalPages'];
        _hasMore = _currentPage < _totalPages;

        _tasks.addAll(fetchedTasks);
      } else {
        _errorMessage =
            'Failed to load tasks: Server responded with ${response.statusCode}.';
        throw Exception(
          'Failed to load tasks. Status code: ${response.statusCode}',
        );
      }
    } catch (e) {
      _errorMessage = 'Failed to load tasks: ${e.toString()}';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void _assignRandomAttributes(List<Task> tasks) {
    for (var task in tasks) {
      if (task.icon == null || task.color == null) {
        task.icon = _icons[_random.nextInt(_icons.length)];
        task.color = _colors[_random.nextInt(_colors.length)];
      }
    }
  }

  void _resetPagination() {
    _tasks.clear();
    _hasMore = true;
    _errorMessage = null;
    _currentPage = 1;
    _totalPages = 1;
    notifyListeners();
  }
}
