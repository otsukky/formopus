import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:formopus/ui/screens/task_screen.dart';
import 'package:formopus/ui/widgets/daily_summary.dart';
import 'package:formopus/ui/widgets/formopus_app_bar.dart';
import 'package:formopus/ui/widgets/today_task_list.dart'; // TodayTaskList ではなく TodayList かもしれません。ファイル名に合わせてください

void main() {
  // テストケースをグループ化
  group('TaskScreen Widget Tests', () {
    // Helper function to pump TaskScreen with necessary MaterialApp wrapper
    Future<void> pumpTaskScreen(WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          // TaskScreen が Theme や Navigator などの依存関係を持つ可能性があるため MaterialApp でラップ
          home: TaskScreen(title: 'Test Tasks'),
        ),
      );
    }

    testWidgets('renders all essential UI elements', (
      WidgetTester tester,
    ) async {
      // TaskScreen をビルドしてフレームをトリガー
      await pumpTaskScreen(tester);

      // FormopusAppBar が表示されていることを確認
      expect(find.byType(FormopusAppBar), findsOneWidget);
      expect(find.text('Test Tasks'), findsOneWidget); // AppBar のタイトルを確認

      // DailySummary が表示されていることを確認
      expect(find.byType(DailySummary), findsOneWidget);
      // DailySummary に渡される具体的なデータも検証可能 (もし固定なら)
      // 例: expect(find.textContaining('10 total, 2 completed'), findsOneWidget);
      // (DailySummary の実装に依存します)

      // TodayTaskList (または TodayList) が表示されていることを確認
      // TodayTaskList が TodayList の間違いであれば修正してください
      expect(find.byType(TodayTaskList), findsOneWidget);
      // TodayTaskList が表示するタスクの数や内容も検証可能
      // 例: expect(find.byType(ListTile), findsNWidgets(5)); // TaskScreen で初期化されるタスクの数

      // FloatingActionButton が表示されていることを確認
      expect(find.byType(FloatingActionButton), findsOneWidget);
      expect(find.byIcon(Icons.add), findsOneWidget); // FAB のアイコンを確認
    });

    testWidgets(
      'FloatingActionButton tap triggers something (placeholder test)',
      (WidgetTester tester) async {
        await pumpTaskScreen(tester);

        // TODO: _createTask メソッドが実際に何かをするようになったら、
        //       その動作を検証するテストに置き換えます。
        //       例えば、ダイアログが表示される、ナビゲーションが発生する、
        //       特定のメソッドが呼び出される (Mockito を使用) など。

        // 現状は _createTask が空なので、タップできることだけを確認
        final fab = find.byType(FloatingActionButton);
        expect(fab, findsOneWidget);

        // タップイベントをシミュレート
        await tester.tap(fab);
        await tester.pump(); // フレームを再描画 (setState などによるUI変更を反映)

        // ここで、タップ後の状態変化を検証します。
        // 例: ダイアログが表示されたか？
        // expect(find.byType(AlertDialog), findsOneWidget);
        //
        // 例: 特定のテキストが表示されたか？
        // expect(find.text('New task created!'), findsOneWidget);

        // 今は _createTask が何もしないので、エラーが出ないことの確認程度になります。
        // 実際には、モックを使って _createTask 内のメソッド呼び出しを検証したり、
        // UIの変更を期待するテストを書きます。
        expect(find.byType(TaskScreen), findsOneWidget); // 単に画面がクラッシュしないかの確認
      },
    );

    // DailySummary に表示される日付やタスク数が正しいかテストする例
    testWidgets('DailySummary shows correct data based on props', (
      WidgetTester tester,
    ) async {
      // TaskScreen が DailySummary にデータを渡す部分をテスト
      // TaskScreen の実装では DailySummary に固定値を渡しているので、それに合わせる
      await pumpTaskScreen(tester);

      final dailySummaryFinder = find.byWidgetPredicate(
        (Widget widget) =>
            widget is DailySummary &&
            widget.date == DateTime(2025, 1, 1) &&
            widget.total == 10 &&
            widget.completed == 2,
      );
      expect(dailySummaryFinder, findsOneWidget);
    });

    // TodayTaskList に初期タスクが表示されるかテストする例
    testWidgets('TodayTaskList shows initial tasks', (
      WidgetTester tester,
    ) async {
      await pumpTaskScreen(tester);

      // TaskScreen の実装では TodayTaskList に5つの初期タスクを渡している
      // TodayTaskList の実装に依存しますが、例えば ListTile の数で確認
      // TodayTaskList の内部で Task オブジェクトから ListTile を生成していると仮定
      expect(find.byType(ListTile), findsNWidgets(5));

      // 特定のタスクのタイトルが表示されているか確認
      expect(find.text("メールに返信"), findsOneWidget);
      expect(find.text("ジムに行く"), findsOneWidget);
      // ... 他のタスクも同様に確認可能
    });
  });
}
