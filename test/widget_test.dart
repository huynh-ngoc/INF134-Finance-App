import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:financial_app/main.dart';

void main() {
  testWidgets('Bottom navigation bar shows all tabs', (WidgetTester tester) async {
    await tester.pumpWidget(FinancialApp());

    expect(find.text('Home'), findsOneWidget);
    expect(find.text('Wallet'), findsOneWidget);
    expect(find.text('What If'), findsOneWidget);
    expect(find.text('Invest'), findsOneWidget);
    expect(find.text('Settings'), findsOneWidget);
  });
}
