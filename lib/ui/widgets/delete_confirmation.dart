import 'package:flutter/material.dart';

class DeleteConfirmation extends StatelessWidget {
  const DeleteConfirmation({
    super.key,
    required this.taskTitle,
    required this.theme,
    required this.bottomSheetContext,
  });

  final String taskTitle;
  final ThemeData theme;
  final BuildContext bottomSheetContext;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      // コンテンツの高さに合わせてサイズ調整
      child: Wrap(
        children: <Widget>[
          Center(
            child: Text(
              '「$taskTitle」を本当に削除しますか？',
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
                  backgroundColor: theme.colorScheme.surfaceContainerHighest,
                  foregroundColor: theme.colorScheme.onSurface,
                ),
                child: const Text('キャンセル'),
                onPressed: () {
                  Navigator.of(bottomSheetContext).pop(false);
                },
              ),
              FilledButton.tonal(
                style: FilledButton.styleFrom(
                  backgroundColor: theme.colorScheme.errorContainer,
                  foregroundColor: theme.colorScheme.onErrorContainer,
                ),
                child: const Text('削除'),
                onPressed: () {
                  Navigator.of(bottomSheetContext).pop(true);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
