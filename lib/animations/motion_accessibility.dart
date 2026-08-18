import 'package:flutter/material.dart';

/// Respects system reduce-motion / disable-animation preferences.
abstract final class MotionAccessibility {
  static bool shouldReduceMotion(BuildContext context) {
    final media = MediaQuery.maybeOf(context);
    if (media == null) return false;
    return media.disableAnimations || media.accessibleNavigation;
  }
}
