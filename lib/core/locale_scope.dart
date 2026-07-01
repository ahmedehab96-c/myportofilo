import 'package:flutter/material.dart';

import 'locale_controller.dart';

class LocaleScope extends InheritedNotifier<LocaleController> {
  const LocaleScope({
    super.key,
    required LocaleController controller,
    required super.child,
  }) : super(notifier: controller);

  static LocaleController of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<LocaleScope>();
    assert(scope != null, 'LocaleScope not found in widget tree');
    return scope!.notifier!;
  }
}

extension LocaleContext on BuildContext {
  LocaleController get localeController => LocaleScope.of(this);

  bool get isArabic => localeController.isArabic;
}
