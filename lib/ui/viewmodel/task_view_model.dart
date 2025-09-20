// viewmodels/task_viewmodel.dart
import 'package:flutter/foundation.dart';

import '../../domain/repository/task_repository.dart';
import '../../domain/status.dart';
import '../../domain/task.dart';

class TaskViewModel extends ChangeNotifier {
  final TaskRepository _taskRepository;

  TaskViewModel(this._taskRepository);

  List<Task> _tasks = [];

  List<Task> get tasks => _tasks;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  Future<void> loadTasks() async {
    _isLoading = true;
    notifyListeners();
    try {
      _tasks = await _taskRepository.getTasks();
    } catch (e) {
      if (kDebugMode) print('Error loading tasks: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> createTask(String title, String memo, DateTime deadline) async {
    final newTask = Task(
      title: title,
      memo: memo,
      deadline: deadline,
      status: Status.incomplete,
    );
    try {
      await _taskRepository.addTask(newTask);
      await loadTasks();
    } catch (e) {
      if (kDebugMode) print('Error creating task: $e');
    }
  }

  Future<void> deleteTask(Task task) async {
    try {
      await _taskRepository.deleteTask(task);
      await loadTasks();
    } catch (e) {
      if (kDebugMode) print('Error deleting task: $e');
    }
  }
}
