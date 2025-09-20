import "package:flutter/material.dart";
import 'package:formopus/ui/widgets/date_switcher.dart';
import 'package:provider/provider.dart';

import '../viewmodel/task_view_model.dart';
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
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => Provider.of<TaskViewModel>(context, listen: false).loadTasks(),
    );
  }

  @override
  Widget build(BuildContext context) => Consumer<TaskViewModel>(
    builder: (context, viewModel, child) => Scaffold(
      appBar: FormopusAppBar(title: widget.title),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            DateSwitcher(),
            DailySummary(
              date: viewModel.selectedDate,
              total: viewModel.selectedTasks.length,
              completed: viewModel.selectedTasks
                  .where((task) => task.status.isComplete())
                  .length,
            ),
            Expanded(child: TodayTaskList(tasks: viewModel.selectedTasks)),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _createTask(context),
        tooltip: "タスクの追加",
        shape: CircleBorder(),
        child: const Icon(Icons.add),
      ),
    ),
  );

  void _createTask(BuildContext dialogContext) async {
    final newTaskDetails = await showDialog<Map<String, dynamic>>(
      context: dialogContext,
      builder: (BuildContext innerDialogContext) => CreateTaskDialog(),
    );

    if (!mounted) return;

    if (newTaskDetails != null) {
      await Provider.of<TaskViewModel>(context, listen: false).createTask(
        newTaskDetails["title"] as String,
        newTaskDetails["memo"] as String,
        newTaskDetails["deadline"] as DateTime,
      );
    }
  }
}
