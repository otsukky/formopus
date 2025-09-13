// 日別のタスク合計数を母数とし、うち何件消化したかを視覚的に表示するウィジェット
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DailySummary extends StatelessWidget {
  final DateTime date;
  final int total;
  final int completed;

  const DailySummary({
    super.key,
    required this.date,
    required this.total,
    required this.completed,
  });

  @override
  Widget build(BuildContext context) {
    final formattedDate = DateFormat.yMd().format(date);
    final double progress = total > 0 ? completed / total : 0.0;
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min, // 必要最小限の高さ
        crossAxisAlignment: CrossAxisAlignment.start, // 子ウィジェット左寄せ
        children: [
          Text(formattedDate, style: theme.textTheme.titleMedium),
          const SizedBox(height: 8), // 日付とプログレスバーの間のスペース
          if (total > 0) // タスクが1件以上ある場合のみプログレスバーと進捗テキストを表示
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                LinearProgressIndicator(
                  value: progress,
                  minHeight: 10,
                  backgroundColor: theme.colorScheme.surfaceContainerHighest,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    theme.colorScheme.primary,
                  ),
                  borderRadius: BorderRadius.circular(5),
                ),
                const SizedBox(height: 4), // プログレスバーとテキストの間のスペース
                Text(
                  '$completed / $total 件完了',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            )
          else
            Text(
              '本日のタスクはありません', // タスクがない場合の表示
              style: theme.textTheme.bodyMedium,
            ),
        ],
      ),
    );
  }
}
