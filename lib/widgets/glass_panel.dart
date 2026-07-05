import 'package:flutter/material.dart';

import '../theme/portfolio_palette.dart';

/// Frosted glass container used across portfolio sections.
class GlassPanel extends StatelessWidget {
  const GlassPanel({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(24),
    this.borderRadius = 20,
    this.borderColor,
    this.accentTop = true,
  });

  final Widget child;
  final EdgeInsets padding;
  final double borderRadius;
  final Color? borderColor;
  final bool accentTop;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final border = borderColor ?? p.borderSubtle;

    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        color: p.surface,
        border: Border.all(color: border, width: 1),
        boxShadow: p.panelShadow,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: Stack(
          children: [
            if (accentTop)
              const Positioned(
                left: 0,
                right: 0,
                top: 0,
                height: 3,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: PortfolioPalette.accentGradient,
                  ),
                ),
              ),
            Padding(padding: padding, child: child),
          ],
        ),
      ),
    );
  }
}
