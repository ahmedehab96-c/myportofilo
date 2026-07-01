import 'dart:async';

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_fonts/google_fonts.dart';

import 'core/locale_controller.dart';
import 'core/locale_scope.dart';
import 'package:myportofilo/gen/l10n/app_localizations.dart';
import 'portfolio_screen.dart';

Future<void> main() async {
  await runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    FlutterError.onError = (details) {
      FlutterError.presentError(details);
      if (kIsWeb) {
        // Surfaces framework errors in the browser console on web deploys.
        debugPrint(details.exceptionAsString());
      }
    };
    final localeController = await LocaleController.load();
    runApp(MyPortfolioApp(localeController: localeController));
  }, (error, stack) {
    debugPrint('Portfolio startup failed: $error\n$stack');
  });
}

class MyPortfolioApp extends StatelessWidget {
  const MyPortfolioApp({super.key, required this.localeController});

  final LocaleController localeController;

  ThemeData _themeFor(Locale locale) {
    final darkText = ThemeData.dark().textTheme;
    // Avoid runtime font CDN fetches on web (can block first paint on Netlify).
    final baseFont = kIsWeb
        ? darkText.apply(
            fontFamily: locale.languageCode == 'ar' ? 'Tahoma' : 'system-ui',
            fontFamilyFallback: locale.languageCode == 'ar'
                ? const ['Arial', 'sans-serif']
                : const ['Segoe UI', 'Roboto', 'sans-serif'],
          )
        : locale.languageCode == 'ar'
            ? GoogleFonts.cairoTextTheme(darkText)
            : GoogleFonts.poppinsTextTheme(darkText);

    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFF0099FF),
        primary: const Color(0xFF0099FF),
        secondary: const Color(0xFF7C3AED),
        tertiary: const Color(0xFF00D4FF),
        surface: const Color(0xFF020617),
        surfaceContainer: const Color(0xFF040D1A),
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: Colors.white,
        brightness: Brightness.dark,
      ),
      scaffoldBackgroundColor: const Color(0xFF020617),
      textTheme: baseFont.copyWith(
        displayLarge: baseFont.displayLarge?.copyWith(
          color: const Color(0xFF0099FF),
          fontSize: 48,
          fontWeight: FontWeight.w800,
          letterSpacing: locale.languageCode == 'ar' ? 0 : 1.5,
        ),
        bodyLarge: baseFont.bodyLarge?.copyWith(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.w400,
          height: 1.7,
        ),
        bodyMedium: baseFont.bodyMedium?.copyWith(
          color: Colors.white70,
          fontSize: 14,
          fontWeight: FontWeight.w400,
          height: 1.6,
        ),
        titleLarge: baseFont.titleLarge?.copyWith(
          color: const Color(0xFF0099FF),
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
        color: const Color(0xFF0A1929),
        surfaceTintColor: const Color(0xFF0A1929),
        shadowColor: const Color(0xFF0099FF).withValues(alpha: 0.15),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return LocaleScope(
      controller: localeController,
      child: ListenableBuilder(
        listenable: localeController,
        builder: (context, _) {
          final locale = localeController.locale;
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Ahmed\'s Portfolio',
            locale: locale,
            supportedLocales: AppLocalizations.supportedLocales,
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            theme: _themeFor(locale),
            localeResolutionCallback: (deviceLocale, supportedLocales) {
              for (final supported in supportedLocales) {
                if (supported.languageCode == locale.languageCode) {
                  return supported;
                }
              }
              return const Locale('en');
            },
            builder: (context, child) {
              return Directionality(
                textDirection: localeController.isArabic
                    ? TextDirection.rtl
                    : TextDirection.ltr,
                child: child ?? const SizedBox.shrink(),
              );
            },
            home: const PortfolioScreen(),
          );
        },
      ),
    );
  }
}
