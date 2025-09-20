// data/in_memory_task_repository.dart
import 'package:uuid/uuid.dart';

import '../../domain/repository/task_repository.dart';
import '../../domain/status.dart';
import '../../domain/task.dart';

class TaskRepositoryImpl implements TaskRepository {
  final List<Task> _tasks = [
    Task(
      id: Uuid().v7(),
      title: "メールに返信",
      memo: "Aさんからのお誘いに回答",
      deadline: DateTime(2025, 1, 1),
      status: Status.incomplete,
    ),
    Task(
      id: Uuid().v7(),
      title: "ジムに行く",
      memo: "",
      deadline: DateTime(2025, 1, 1),
      status: Status.incomplete,
    ),
    Task(
      id: Uuid().v7(),
      title: "買い物",
      memo: "ティッシュを買うの忘れずに",
      deadline: DateTime(2025, 1, 1),
      status: Status.incomplete,
    ),
    Task(
      id: Uuid().v7(),
      title: "写真の整理",
      memo: "",
      deadline: DateTime(2025, 1, 1),
      status: Status.incomplete,
    ),
    Task(
      id: Uuid().v7(),
      title: "今週の開発",
      memo: "コンポーネント1個作る",
      deadline: DateTime(2025, 1, 1),
      status: Status.incomplete,
    ),
  ];

  @override
  Future<List<Task>> getTasks() async {
    // TODO DBからの取得に変更
    await Future.delayed(const Duration(milliseconds: 500)); // 擬似的な非同期処理
    return List.unmodifiable(_tasks);
  }

  @override
  Future<void> addTask(Task task) async {
    // TODO DBへの保存に変更
    await Future.delayed(const Duration(milliseconds: 500)); // 擬似的な非同期処理
    _tasks.add(task);
  }

  @override
  Future<void> deleteTask(Task task) async {
    // TODO DBへの保存に変更
    await Future.delayed(const Duration(milliseconds: 500)); // 擬似的な非同期処理
    _tasks.remove(task);
  }

  @override
  Future<void> updateTask(Task task) async {
    // TODO DBへの更新に変更
    await Future.delayed(const Duration(milliseconds: 500)); // 擬似的な非同期処理
    final index = _tasks.indexWhere((t) => t.id == task.id);
    if (index != -1) {
      _tasks[index] = task;
    }
  }
}
