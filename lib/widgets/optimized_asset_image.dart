import 'package:flutter/material.dart';

import 'motion/premium_shimmer.dart';

/// Decodes image assets at display resolution on web for faster first paint.
class OptimizedAssetImage extends StatelessWidget {
  const OptimizedAssetImage({
    super.key,
    required this.asset,
    this.fit = BoxFit.cover,
    this.width,
    this.height,
    this.alignment = Alignment.center,
    this.errorBuilder,
    this.shimmerRadius = 12,
    this.useShimmer = true,
    this.placeholderColor,
  });

  final String asset;
  final BoxFit fit;
  final double? width;
  final double? height;
  final Alignment alignment;
  final ImageErrorWidgetBuilder? errorBuilder;
  final double shimmerRadius;
  final bool useShimmer;
  final Color? placeholderColor;

  int? _cacheWidth(BuildContext context) {
    if (width == null || !width!.isFinite) return null;
    final dpr = MediaQuery.devicePixelRatioOf(context).clamp(1.0, 2.0);
    return (width! * dpr).round();
  }

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      asset,
      fit: fit,
      width: width,
      height: height,
      alignment: alignment,
      cacheWidth: _cacheWidth(context),
      filterQuality: FilterQuality.medium,
      gaplessPlayback: true,
      errorBuilder: errorBuilder,
      frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
        if (wasSynchronouslyLoaded || frame != null) return child;
        if (!useShimmer) {
          final color = placeholderColor ?? const Color(0xFF0E1628);
          if (color.a == 0) {
            return SizedBox(width: width, height: height);
          }
          return ColoredBox(
            color: color,
            child: SizedBox(width: width, height: height),
          );
        }
        final w = width ?? 280.0;
        final h = height ?? 180.0;
        return PremiumShimmer(
          width: w,
          height: h,
          borderRadius: shimmerRadius,
        );
      },
    );
  }
}
