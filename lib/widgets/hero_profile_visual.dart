import 'package:flutter/material.dart';

import '../theme/portfolio_palette.dart';
import 'deferred_asset_image.dart';

/// Hero profile banner — blends with the page gradient.
class HeroProfileVisual extends StatelessWidget {
  const HeroProfileVisual({
    super.key,
    required this.width,
    required this.palette,
    this.bleedRight = false,
    this.alignment = Alignment.center,
  });

  final double width;
  final PortfolioPalette palette;
  final bool bleedRight;
  final Alignment alignment;

  static const _asset = 'assets/images/ahmed_profile.png';

  @override
  Widget build(BuildContext context) {
    const aspectRatio = 1.05;
    final height = width / aspectRatio;

    return SizedBox(
      width: width,
      height: height,
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(22),
          border: Border.all(
            color: palette.borderAccent,
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: palette.cardShadowColor,
              blurRadius: 32,
              offset: const Offset(0, 14),
            ),
            BoxShadow(
              color: PortfolioPalette.accent.withValues(alpha: 0.1),
              blurRadius: 48,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(21),
          child: Stack(
            fit: StackFit.expand,
            children: [
              DecoratedBox(
                decoration: BoxDecoration(gradient: palette.backgroundGradient),
              ),
              DeferredAssetImage(
                asset: _asset,
                fit: BoxFit.cover,
                width: width,
                height: height,
                alignment: alignment,
                placeholderColor: palette.imagePlaceholder,
                useShimmer: false,
                errorBuilder: (_, __, ___) => Icon(
                  Icons.person_outline,
                  size: width * 0.22,
                  color: palette.textMuted,
                ),
              ),
              DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [
                      palette.bgDeep.withValues(alpha: 0.08),
                      Colors.transparent,
                      Colors.transparent,
                      palette.bgDeep.withValues(alpha: 0.06),
                    ],
                    stops: const [0.0, 0.12, 0.88, 1.0],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
