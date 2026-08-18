import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../animations/motion_accessibility.dart';
import '../../theme/portfolio_palette.dart';

/// Premium shimmer placeholder for cards, images, and list rows.
class PremiumShimmer extends StatelessWidget {
  const PremiumShimmer({
    super.key,
    required this.width,
    required this.height,
    this.borderRadius = 18,
  });

  final double width;
  final double height;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    if (MotionAccessibility.shouldReduceMotion(context)) {
      return Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: p.bgMid,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      );
    }

    return Shimmer.fromColors(
      baseColor: p.bgMid,
      highlightColor: p.cardSurface.withValues(alpha: 0.95),
      period: const Duration(milliseconds: 1400),
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: p.bgMid,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
    );
  }
}

/// Full-width shimmer block for loading card bodies.
class PremiumShimmerCard extends StatelessWidget {
  const PremiumShimmerCard({
    super.key,
    this.height = 180,
    this.borderRadius = 20,
  });

  final double height;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return PremiumShimmer(
          width: constraints.maxWidth,
          height: height,
          borderRadius: borderRadius,
        );
      },
    );
  }
}
