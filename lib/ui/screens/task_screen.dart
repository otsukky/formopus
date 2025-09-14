import 'package:flutter/material.dart';

import '../../domain/status.dart';
import '../../domain/task.dart';
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
  void _createTask() {
    // TODO タスクの登録処理追加
  }

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
            Expanded(
              child: TodayTaskList(
                tasks: [
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
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _createTask,
        tooltip: "Increment",
        child: const Icon(Icons.add),
      ),
    );
  }
}