import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';

import 'optimized_asset_image.dart';

/// Defers image decode until after the first frame on web for faster startup.
class DeferredAssetImage extends StatefulWidget {
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
  });

  final String asset;
  final BoxFit fit;
  final double? width;
  final double? height;
  final Alignment alignment;
  final ImageErrorWidgetBuilder? errorBuilder;
  final Color? placeholderColor;
  final BorderRadius? borderRadius;

  @override
  State<DeferredAssetImage> createState() => _DeferredAssetImageState();
}

class _DeferredAssetImageState extends State<DeferredAssetImage> {
  bool _ready = !kIsWeb;

  @override
  void initState() {
    super.initState();
    if (kIsWeb) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) setState(() => _ready = true);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_ready) {
      return ClipRRect(
        borderRadius: widget.borderRadius ?? BorderRadius.zero,
        child: SizedBox(
          width: widget.width,
          height: widget.height,
          child: ColoredBox(
            color: widget.placeholderColor ?? const Color(0xFF0E1628),
          ),
        ),
      );
    }

    final image = OptimizedAssetImage(
      asset: widget.asset,
      fit: widget.fit,
      width: widget.width,
      height: widget.height,
      alignment: widget.alignment,
      errorBuilder: widget.errorBuilder,
    );

    if (widget.borderRadius == null) return image;

    return ClipRRect(
      borderRadius: widget.borderRadius!,
      child: image,
    );
  }
}
