import "package:flutter/material.dart";

import '../../domain/status.dart';
import '../../domain/task.dart';
import '../widgets/create_task.dart';
import '../widgets/daily_summary.dart';
import '../widgets/formopus_app_bar.dart';
import '../widgets/today_task_list.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({super.key, required this.title});

  final String title;

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  final List<Task> _tasks = [
    Task(
      title: "メールに返信",
      memo: "Aさんからのお誘いに回答",
      deadline: DateTime(2025, 1, 1),
      status: Status.incomplete,
    ),
    Task(
      title: "ジムに行く",
      memo: "",
      deadline: DateTime(2025, 1, 1),
      status: Status.incomplete,
    ),
    Task(
      title: "買い物",
      memo: "ティッシュを買うの忘れずに",
      deadline: DateTime(2025, 1, 1),
      status: Status.incomplete,
    ),
    Task(
      title: "写真の整理",
      memo: "",
      deadline: DateTime(2025, 1, 1),
      status: Status.incomplete,
    ),
    Task(
      title: "今週の開発",
      memo: "コンポーネント1個作る",
      deadline: DateTime(2025, 1, 1),
      status: Status.incomplete,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: FormopusAppBar(title: widget.title),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // TODO 登録されたタスクに応じてサマリを表示する
            DailySummary(date: DateTime(2025, 1, 1), total: 10, completed: 2),
            Expanded(child: TodayTaskList(tasks: _tasks)),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _createTask,
        tooltip: "タスクの追加",
        shape: CircleBorder(),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _createTask() async {
    final newTaskDetails = await showDialog<Map<String, dynamic>>(
      context: context,
      builder: (BuildContext dialogContext) => CreateTaskDialog(),
    );

    if (!mounted) return;

    if (newTaskDetails != null) {
      final newTask = Task(
        title: newTaskDetails["title"] as String,
        memo: newTaskDetails["memo"] as String,
        deadline: newTaskDetails["deadline"] as DateTime,
        status: Status.incomplete,
      );
      setState(() => _tasks.add(newTask));
    }
  }
}
