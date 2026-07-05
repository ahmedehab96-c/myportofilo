import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';

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
  });

  final String asset;
  final BoxFit fit;
  final double? width;
  final double? height;
  final Alignment alignment;
  final ImageErrorWidgetBuilder? errorBuilder;

  int? _cacheWidth(BuildContext context) {
    if (!kIsWeb || width == null || !width!.isFinite) return null;
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
    );
  }
}
