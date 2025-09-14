import 'package:formopus/domain/status.dart';

class Task {
  Task({
    required this.title,
    required this.memo,
    required this.deadline,
    required this.status,
  });

  final String title;
  final String memo;
  final DateTime deadline;
  Status status;
}
