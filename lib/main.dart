import 'package:flutter/material.dart';
import 'package:formopus/ui/screens/task_screen.dart';

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
    return MaterialApp(
      title: "Formopus",
      theme: brightness == Brightness.light ? theme.light() : theme.dark(),
      home: const TaskScreen(title: "タスク"),
    );
  }
}
