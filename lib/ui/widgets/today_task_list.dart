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
              trailing: Icon(Icons.delete_outline),
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
