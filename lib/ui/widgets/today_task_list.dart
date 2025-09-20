import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:formopus/domain/status.dart';
import 'package:formopus/domain/task.dart';
import 'package:formopus/ui/widgets/delete_confirmation.dart';
import 'package:provider/provider.dart';

import '../viewmodel/task_view_model.dart';

class TodayTaskList extends StatefulWidget {
  const TodayTaskList({super.key, required this.tasks});

  final List<Task> tasks;

  @override
  State<TodayTaskList> createState() => _TodayTaskListState();
}

class _TodayTaskListState extends State<TodayTaskList> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ListView(
      padding: EdgeInsets.symmetric(horizontal: 16),
      children: widget.tasks
          .map(
            (task) => ListTile(
              title: Text(task.title),
              subtitle: Text(task.memo),
              leading: Checkbox(
                value: task.status.isComplete(),
                onChanged: (value) async {
                  setState(
                    () => value!
                        ? task.status = Status.complete
                        : task.status = Status.incomplete,
                  );
                  try {
                    await Provider.of<TaskViewModel>(
                      context,
                      listen: false,
                    ).updateTask(task);
                  } catch (e) {
                    if (mounted) {
                      setState(
                        () => value!
                            ? task.status = Status.incomplete
                            : task.status = Status.complete,
                      );
                    }
                  }
                },
              ),
              trailing: IconButton(
                icon: Icon(Icons.delete_outline),
                tooltip: "削除",
                onPressed: () {
                  _deleteTask(task);
                },
              ),
              hoverColor: theme.colorScheme.surfaceContainerHighest,
              onTap: () {
                // TODO タップしたらタスク修正画面に遷移
                if (kDebugMode) {
                  print("Tapped on ${task.title}");
                }
              },
            ),
          )
          .toList(),
    );
  }

  void _deleteTask(Task task) async {
    final theme = Theme.of(context);
    final taskTitle = task.title;
    final bool? shouldDelete = await showModalBottomSheet<bool>(
      context: context,
      backgroundColor: theme.colorScheme.surface,
      builder: (BuildContext bc) => DeleteConfirmation(
        taskTitle: taskTitle,
        theme: theme,
        bottomSheetContext: bc,
      ),
    );

    if (!mounted) return;

    if (shouldDelete == true) {
      try {
        await Provider.of<TaskViewModel>(
          context,
          listen: false,
        ).deleteTask(task);

        if (!mounted) return;

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("$taskTitle を削除しました"),
            duration: const Duration(seconds: 2),
          ),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("$taskTitle を削除に失敗しました"),
            duration: const Duration(seconds: 2),
          ),
        );
      }
    }
  }
}
