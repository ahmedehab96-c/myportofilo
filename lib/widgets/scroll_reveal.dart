import 'package:flutter/material.dart';

import 'motion/premium_entrance.dart';

export 'motion/premium_entrance.dart';

/// Scroll-triggered entrance with safe fallback (never stuck at opacity 0).
class ScrollReveal extends PremiumEntrance {
  const ScrollReveal({
    super.key,
    required ScrollController scrollController,
    required super.child,
    super.delay = Duration.zero,
    super.useBlur = true,
  }) : super(scrollController: scrollController);
}
