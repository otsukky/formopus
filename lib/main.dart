import 'package:flutter/material.dart';
import 'package:formopus/ui/screens/task_screen.dart';
import 'package:formopus/ui/viewmodel/task_view_model.dart';
import 'package:provider/provider.dart';

import 'data/repository/task_repository_impl.dart';
import 'domain/repository/task_repository.dart';
import 'ui/theme/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final brightness = View.of(context).platformDispatcher.platformBrightness;

    AppTheme theme = AppTheme();
    return MultiProvider(
      providers: [
        Provider<TaskRepository>(
          create: (_) => TaskRepositoryImpl(),
        ),
        ChangeNotifierProvider(
          create: (context) => TaskViewModel(context.read<TaskRepository>()),
        ),
      ],
      child: MaterialApp(
        title: "Formopus",
        theme: brightness == Brightness.light ? theme.light() : theme.dark(),
        home: const TaskScreen(title: "タスク"),
      ),
    );
  }
}
