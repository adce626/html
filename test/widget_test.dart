import 'package:flutter_test/flutter_test.dart';
import 'package:sama_app/main.dart';

void main() {
  testWidgets('App starts', (WidgetTester tester) async {
    await tester.pumpWidget(const SamaApp());
    expect(find.text('سما'), findsOneWidget);
  });
}
