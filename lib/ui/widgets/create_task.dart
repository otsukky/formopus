import 'package:flutter/material.dart';

class CreateTaskDialog extends StatefulWidget {
  const CreateTaskDialog({super.key});

  @override
  CreateTaskDialogState createState() => CreateTaskDialogState();
}

class CreateTaskDialogState extends State<CreateTaskDialog> {
  late TextEditingController _titleController;
  late TextEditingController _memoController;
  DateTime? _selectedDeadline;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _memoController = TextEditingController();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _memoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("タスクを追加"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        spacing: 16,
        children: <Widget>[
          TextField(
            controller: _titleController,
            decoration: const InputDecoration(labelText: "タイトル"),
            autofocus: true,
          ),
          TextField(
            controller: _memoController,
            decoration: const InputDecoration(labelText: "メモ (任意)"),
            maxLines: 1,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                _selectedDeadline == null
                    ? "期限: 未選択"
                    : "期限: ${_selectedDeadline!.year}/${_selectedDeadline!.month}/${_selectedDeadline!.day}",
              ),
              TextButton(
                child: const Text("選択"),
                onPressed: () async {
                  final DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: _selectedDeadline ?? DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2101),
                  );
                  if (picked != null && picked != _selectedDeadline) {
                    setState(() => _selectedDeadline = picked);
                  }
                },
              ),
            ],
          ),
        ],
      ),
      actions: <Widget>[
        TextButton(
          child: const Text("キャンセル"),
          onPressed: () => Navigator.of(context).pop(),
        ),
        FilledButton(
          child: const Text("追加"),
          onPressed: () {
            if (_titleController.text.isNotEmpty && _selectedDeadline != null) {
              Navigator.of(context).pop({
                "title": _titleController.text,
                "memo": _memoController.text,
                "deadline": _selectedDeadline,
              });
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("タイトルと期限を入力してください。"),
                  duration: Duration(seconds: 2),
                ),
              );
            }
          },
        ),
      ],
    );
  }
}
