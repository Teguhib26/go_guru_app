import 'package:flutter_test/flutter_test.dart';
import 'package:go_guru_app/main.dart';

void main() {
  testWidgets('GO GURU app smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const GoGuruApp());

    // Verify that the app title is displayed
    expect(find.text('GO GURU'), findsOneWidget);

    // Verify that search bar placeholder is displayed
    expect(find.text('Cari apapun di GO GURU'), findsOneWidget);

    // Verify that the banner text is displayed
    expect(find.text('Taman Bermain Musik'), findsOneWidget);

    // Verify that action buttons are displayed
    expect(find.text('Daftar Murid'), findsOneWidget);
    expect(find.text('Daftar Guru'), findsOneWidget);

    // Verify that teacher profiles are displayed
    expect(find.text('Herri Budiawan'), findsOneWidget);
    expect(find.text('George Calvin'), findsOneWidget);

    // Verify that bottom navigation items are displayed
    expect(find.text('Beranda'), findsOneWidget);
    expect(find.text('Riwayat'), findsOneWidget);
    expect(find.text('Profile'), findsOneWidget);
    expect(find.text('Pengaturan'), findsOneWidget);
  });
}
