import 'dart:async' show runZonedGuarded;

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'theme/portfolio_palette.dart';
import 'portfolio_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (kIsWeb) {
    runApp(const MyPortfolioApp());
    return;
  }

  await runZonedGuarded(() async {
    FlutterError.onError = (details) {
      FlutterError.presentError(details);
    };
    runApp(const MyPortfolioApp());
  }, (error, stack) {
    debugPrint('Portfolio startup failed: $error\n$stack');
  });
}

class MyPortfolioApp extends StatelessWidget {
  const MyPortfolioApp({super.key});

  ThemeData _buildTheme() {
    const palette = PortfolioPalette.dark;
    final baseText = ThemeData.dark().textTheme;
    final baseFont = kIsWeb
        ? baseText.apply(
            fontFamily: 'system-ui',
            fontFamilyFallback: const ['Segoe UI', 'Roboto', 'sans-serif'],
          )
        : GoogleFonts.poppinsTextTheme(baseText);

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: ColorScheme.fromSeed(
        seedColor: PortfolioPalette.accent,
        primary: PortfolioPalette.accent,
        secondary: PortfolioPalette.violet,
        tertiary: PortfolioPalette.sky,
        surface: palette.surface,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: palette.textPrimary,
        brightness: Brightness.dark,
      ),
      scaffoldBackgroundColor: palette.bgDeep,
      extensions: const [PortfolioPalette.dark],
      textTheme: baseFont.copyWith(
        displayLarge: baseFont.displayLarge?.copyWith(
          color: PortfolioPalette.accent,
          fontSize: 48,
          fontWeight: FontWeight.w800,
          letterSpacing: 1.5,
        ),
        bodyLarge: baseFont.bodyLarge?.copyWith(
          color: palette.textPrimary,
          fontSize: 16,
          fontWeight: FontWeight.w400,
          height: 1.7,
        ),
        bodyMedium: baseFont.bodyMedium?.copyWith(
          color: palette.textSecondary,
          fontSize: 14,
          fontWeight: FontWeight.w400,
          height: 1.6,
        ),
        titleLarge: baseFont.titleLarge?.copyWith(
          color: PortfolioPalette.accent,
          fontSize: 22,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.3,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
      ),
      cardTheme: CardThemeData(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        color: palette.surface,
        surfaceTintColor: Colors.transparent,
        shadowColor: PortfolioPalette.accent.withValues(alpha: 0.08),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Ahmed's Portfolio",
      themeMode: ThemeMode.dark,
      theme: _buildTheme(),
      darkTheme: _buildTheme(),
      scrollBehavior: const MaterialScrollBehavior().copyWith(
        physics: const BouncingScrollPhysics(),
      ),
      home: const PortfolioScreen(),
    );
  }
}
