import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:todo_list/utils/date_formatter.dart';
import '../models/task.dart';

class TaskViewModel with ChangeNotifier {
  List<Task> _tasks = [];
  bool _isLoading = false;
  bool _hasMore = true;
  String? _errorMessage;
  final int _limit = 10;
  int _currentPage = 0; // เก็บ page ปัจจุบัน
  int _totalPages = 1; // เก็บจำนวน page ทั้งหมด

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

  void _resetPagination() {
    _tasks = [];
    _hasMore = true;
    _errorMessage = null;
    _currentPage = 0;
    _totalPages = 1;
    notifyListeners();
  }

  Future<void> _loadTasks({
    String sortBy = 'createdAt',
    bool isAsc = true,
    required String status,
  }) async {
    final String url =
        'https://todo-list-api-mfchjooefq-as.a.run.app/todo-list';
    final queryParameters = {
      'offset': _currentPage.toString(),
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

        // ดึงข้อมูล task และ page
        final List<Task> fetchedTasks = (data['tasks'] as List)
            .map((taskJson) => Task.fromJson(taskJson))
            .toList();
        _currentPage = data['pageNumber']; // หน้าปัจจุบัน
        _totalPages = data['totalPages']; // จำนวนหน้าทั้งหมด

        // คำนวณ `hasMore`
        _hasMore = _currentPage < _totalPages;

        // เพิ่มข้อมูลใหม่
        _tasks.addAll(fetchedTasks);
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
