import 'package:flutter/material.dart';

import 'optimized_asset_image.dart';

/// Asset image — shimmer while loading, then optimized decode.
class DeferredAssetImage extends StatelessWidget {
  const DeferredAssetImage({
    super.key,
    required this.asset,
    this.fit = BoxFit.cover,
    this.width,
    this.height,
    this.alignment = Alignment.center,
    this.errorBuilder,
    this.placeholderColor,
    this.borderRadius,
    this.useShimmer = true,
  });

  final String asset;
  final BoxFit fit;
  final double? width;
  final double? height;
  final Alignment alignment;
  final ImageErrorWidgetBuilder? errorBuilder;
  final Color? placeholderColor;
  final BorderRadius? borderRadius;
  final bool useShimmer;

  @override
  Widget build(BuildContext context) {
    final image = OptimizedAssetImage(
      asset: asset,
      fit: fit,
      width: width,
      height: height,
      alignment: alignment,
      shimmerRadius: borderRadius?.topLeft.x ?? 12,
      useShimmer: useShimmer,
      placeholderColor: placeholderColor,
      errorBuilder: errorBuilder ??
          (context, error, stackTrace) => ColoredBox(
                color: placeholderColor ?? const Color(0xFF0E1628),
                child: const Center(
                  child: Icon(Icons.broken_image_outlined, color: Colors.white38),
                ),
              ),
    );

    if (borderRadius == null) return image;

    return ClipRRect(
      borderRadius: borderRadius!,
      child: image,
    );
  }
}
