// Smoke test cho Dopamine Diary — verify app khởi động không crash.

import 'package:dopamine_diary/main.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('App khởi động và render placeholder', (tester) async {
    await tester.pumpWidget(const DopamineDiaryApp());
    expect(find.text('Dopamine Diary'), findsOneWidget);
  });
}
