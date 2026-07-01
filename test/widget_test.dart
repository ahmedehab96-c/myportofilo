import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:myportofilo/core/locale_controller.dart';
import 'package:myportofilo/main.dart';

void main() {
  testWidgets('Portfolio app smoke test', (WidgetTester tester) async {
    final localeController = await LocaleController.load();
    await tester.pumpWidget(MyPortfolioApp(localeController: localeController));

    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
