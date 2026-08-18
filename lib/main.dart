import 'package:flutter/material.dart';

import 'portfolio_screen.dart';
import 'theme/portfolio_app_theme.dart';
import 'theme/portfolio_palette.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  FlutterError.onError = (details) {
    FlutterError.presentError(details);
    debugPrint('FlutterError: ${details.exceptionAsString()}');
  };

  runApp(const MyPortfolioApp());
}

class MyPortfolioApp extends StatelessWidget {
  const MyPortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Ahmed's Portfolio",
      theme: PortfolioAppTheme.fromPalette(PortfolioPalette.dark),
      scrollBehavior: const MaterialScrollBehavior().copyWith(
        physics: const BouncingScrollPhysics(),
      ),
      home: const PortfolioScreen(),
    );
  }
}
