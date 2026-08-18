import 'package:flutter/foundation.dart' show kIsWeb, defaultTargetPlatform, TargetPlatform;
import 'package:flutter/material.dart';

import 'portfolio_palette.dart';

abstract final class PortfolioAppTheme {
  static TextTheme baseTextTheme(TextTheme base) {
    if (kIsWeb) {
      return base.apply(
        fontFamily: 'system-ui',
        fontFamilyFallback: const ['Segoe UI', 'Roboto', 'sans-serif'],
      );
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
        return base.apply(
          fontFamily: '.AppleSystemUIFont',
          fontFamilyFallback: const ['SF Pro Display', 'Helvetica Neue', 'sans-serif'],
        );
      case TargetPlatform.android:
        return base.apply(
          fontFamily: 'Roboto',
          fontFamilyFallback: const ['sans-serif'],
        );
      default:
        return base;
    }
  }

  static ThemeData fromPalette(PortfolioPalette palette) {
    final brightness = palette.isDark ? Brightness.dark : Brightness.light;
    final baseText = brightness == Brightness.dark
        ? ThemeData.dark().textTheme
        : ThemeData.light().textTheme;
    final baseFont = baseTextTheme(baseText);

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: ColorScheme.fromSeed(
        seedColor: PortfolioPalette.accent,
        primary: PortfolioPalette.accent,
        secondary: PortfolioPalette.violet,
        tertiary: PortfolioPalette.sky,
        surface: palette.surface,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: palette.textPrimary,
        brightness: brightness,
      ),
      scaffoldBackgroundColor: palette.bgDeep,
      extensions: [palette],
      textTheme: baseFont.copyWith(
        displayLarge: baseFont.displayLarge?.copyWith(
          color: palette.isDark ? PortfolioPalette.accentBright : PortfolioPalette.accentDeep,
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
          color: palette.isDark ? PortfolioPalette.accentBright : PortfolioPalette.accentDeep,
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
        shadowColor: palette.cardShadowColor,
      ),
    );
  }
}
