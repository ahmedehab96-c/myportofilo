import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Persists and broadcasts the active portfolio locale (default: English).
class LocaleController extends ChangeNotifier {
  LocaleController._();

  static const _prefKey = 'portfolio_locale';
  static LocaleController? _instance;

  static Future<LocaleController> load() async {
    if (_instance != null) return _instance!;
    final controller = LocaleController._();
    try {
      final prefs = await SharedPreferences.getInstance();
      final code = prefs.getString(_prefKey);
      controller._locale =
          code == 'ar' ? const Locale('ar') : const Locale('en');
    } catch (_) {
      controller._locale = const Locale('en');
    }
    _instance = controller;
    return controller;
  }

  Locale _locale = const Locale('en');

  Locale get locale => _locale;

  bool get isArabic => _locale.languageCode == 'ar';

  Future<void> setLocale(Locale locale) async {
    if (_locale == locale) return;
    _locale = locale;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_prefKey, locale.languageCode);
  }

  Future<void> toggle() =>
      setLocale(isArabic ? const Locale('en') : const Locale('ar'));
}
