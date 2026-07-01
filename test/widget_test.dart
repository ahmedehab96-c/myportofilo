import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:myportofilo/main.dart';

void main() {
  testWidgets('Portfolio app smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const MyPortfolioApp());
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
