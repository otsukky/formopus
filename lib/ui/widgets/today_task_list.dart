import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:formopus/domain/status.dart';
import 'package:formopus/domain/task.dart';

class TodayTaskList extends StatefulWidget {
  const TodayTaskList({super.key, required this.tasks});

  final List<Task> tasks;

  @override
  State<TodayTaskList> createState() => _TodayTaskListState();
}

class _TodayTaskListState extends State<TodayTaskList> {
  void _deleteTask(Task taskToDelete) async {
    final theme = Theme.of(context);
    final bool? shouldDelete = await showModalBottomSheet<bool>(
      context: context, // 現在の BuildContext
      backgroundColor: theme.colorScheme.surface,
      builder: (BuildContext bc) {
        return Container(
          padding: const EdgeInsets.all(16.0),
          // コンテンツの高さに合わせてサイズ調整
          child: Wrap(
            children: <Widget>[
              Center(
                child: Text(
                  '「${taskToDelete.title}」を本当に削除しますか？',
                  style: theme.textTheme.titleMedium,
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 48),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  FilledButton.tonal(
                    style: FilledButton.styleFrom(
                      backgroundColor:
                          theme.colorScheme.surfaceContainerHighest,
                      foregroundColor: theme.colorScheme.onSurface,
                    ),
                    child: const Text('キャンセル'),
                    onPressed: () {
                      Navigator.of(bc).pop(false);
                    },
                  ),
                  FilledButton.tonal(
                    style: FilledButton.styleFrom(
                      backgroundColor: theme.colorScheme.errorContainer,
                      foregroundColor: theme.colorScheme.onErrorContainer,
                    ),
                    child: const Text('削除'),
                    onPressed: () {
                      Navigator.of(bc).pop(true);
                    },
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );

    if (!mounted) return;

    if (shouldDelete == true) {
      setState(() {
        widget.tasks.remove(taskToDelete);
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("${taskToDelete.title} を削除しました"),
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

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
                onChanged: (value) {
                  setState(() {
                    value!
                        ? task.status = Status.complete
                        : task.status = Status.incomplete;
                  });
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
}
