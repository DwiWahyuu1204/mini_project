import 'package:flutter_test/flutter_test.dart';

import 'package:mini_project/view/daftar_tugas_screen.dart';

void main() {
  testWidgets('Test Daftar Tugas', (WidgetTester tester) async {
    await tester.pumpWidget(const DaftarTugasScreen());

    expect(find.text('My Task'), findsOneWidget);
  });
}
