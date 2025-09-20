import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../viewmodel/task_view_model.dart';

class DateSwitcher extends StatefulWidget {
  const DateSwitcher({super.key});

  @override
  State<DateSwitcher> createState() => _DateSwitcherState();
}

class _DateSwitcherState extends State<DateSwitcher> {
  @override
  void initState() {
    super.initState();
  }

  void _updateSelectedDate(BuildContext context, DateTime date) =>
      Provider.of<TaskViewModel>(
        context,
        listen: false,
      ).changeSelectedDate(date);

  void _previousDay(BuildContext context) {
    final selectedDate = Provider.of<TaskViewModel>(
      context,
      listen: false,
    ).selectedDate;
    _updateSelectedDate(
      context,
      selectedDate.subtract(const Duration(days: 1)),
    );
  }

  void _nextDay(BuildContext context) {
    final selectedDate = Provider.of<TaskViewModel>(
      context,
      listen: false,
    ).selectedDate;
    _updateSelectedDate(context, selectedDate.add(const Duration(days: 1)));
  }

  @override
  Widget build(BuildContext context) {
    final DateTime currentDate = Provider.of<TaskViewModel>(
      context,
    ).selectedDate;
    final DateFormat formatter = DateFormat('yyyy/MM/dd');

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        IconButton(
          icon: const Icon(Icons.arrow_left),
          onPressed: () => _previousDay(context),
          tooltip: '前日',
        ),
        Text(
          formatter.format(currentDate),
          style: Theme.of(context).textTheme.titleLarge,
        ),
        IconButton(
          icon: const Icon(Icons.arrow_right),
          onPressed: () => _nextDay(context),
          tooltip: '翌日',
        ),
      ],
    );
  }
}
