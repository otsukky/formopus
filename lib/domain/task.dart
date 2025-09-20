import 'package:formopus/domain/status.dart';

class Task {
  Task({
    required this.id,
    required this.title,
    required this.memo,
    required this.deadline,
    required this.status,
  });

  final String id;
  final String title;
  final String memo;
  final DateTime deadline;
  Status status;
}
