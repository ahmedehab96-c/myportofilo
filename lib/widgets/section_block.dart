import 'package:flutter/material.dart';

import '../theme/portfolio_palette.dart';
import 'motion/premium_entrance.dart';

/// Professional section header with accent bar and divider.
class SectionHeader extends StatelessWidget {
  const SectionHeader({
    super.key,
    required this.title,
    this.subtitle,
  });

  final String title;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final isSmall = MediaQuery.sizeOf(context).width < 600;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 4,
              height: isSmall ? 26 : 32,
              decoration: p.sectionAccentBar,
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: isSmall ? 22 : 28,
                  fontWeight: FontWeight.w800,
                  color: p.textPrimary,
                  letterSpacing: 0.2,
                  height: 1.15,
                ),
              ),
            ),
          ],
        ),
        if (subtitle != null) ...[
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(left: 18),
            child: Text(
              subtitle!,
              style: TextStyle(
                fontSize: isSmall ? 14 : 16,
                color: p.textSecondary,
                height: 1.55,
              ),
            ),
          ),
        ],
        const SizedBox(height: 14),
        Padding(
          padding: const EdgeInsets.only(left: 18),
          child: Container(
            height: 1,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  PortfolioPalette.accent.withValues(alpha: 0.45),
                  PortfolioPalette.violet.withValues(alpha: 0.2),
                  Colors.transparent,
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

/// Wraps a portfolio section with a subtle 3D scroll entrance.
class SectionBlock extends StatelessWidget {
  const SectionBlock({
    super.key,
    required this.child,
    this.sectionKey,
    this.scrollController,
    this.delay = Duration.zero,
    this.padding,
  });

  final Widget child;
  final Key? sectionKey;
  final ScrollController? scrollController;
  final Duration delay;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    final isSmall = MediaQuery.sizeOf(context).width < 600;
    final pad = padding ??
        EdgeInsets.fromLTRB(
          isSmall ? 16 : 28,
          20,
          isSmall ? 16 : 28,
          12,
        );

    return PremiumEntrance(
      delay: delay,
      scrollController: scrollController,
      useBlur: false,
      child: Container(
        key: sectionKey,
        padding: pad,
        child: child,
      ),
    );
  }
}

/// Entrance helper with stagger support and scroll visibility.
Widget revealItem(
  Widget child, {
  Duration delay = Duration.zero,
  double from = 28,
  ScrollController? scrollController,
}) {
  return PremiumEntrance(
    delay: delay,
    scrollController: scrollController,
    child: child,
  );
}
