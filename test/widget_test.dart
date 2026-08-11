import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:riders_keeper/app/app.dart';

void main() {
  testWidgets('application bootstrap renders the root route', (tester) async {
    await tester.pumpWidget(const ProviderScope(child: RidersKeeperApp()));
    await tester.pumpAndSettle();

    expect(find.byType(RidersKeeperApp), findsOneWidget);
  });
}
