import 'package:flutter/material.dart';

enum Status implements Comparable<Status> {
  incomplete(name: "未完了", color: Colors.grey),
  complete(name: "完了", color: Colors.green),
  expired(name: "期限切れ", color: Colors.red);

  @override
  int compareTo(Status other) => name.compareTo(other.name);

  bool isComplete() => this == Status.complete;

  const Status({required this.name, required this.color});

  final String name;
  final Color color;
}
