import 'package:flutter/material.dart';

import 'fa_shim.dart';

/// Brand logos for GitHub and LinkedIn — CanvasKit-safe (no flutter_svg).
class BrandContactIcon extends StatelessWidget {
  const BrandContactIcon({
    super.key,
    this.brand,
    this.icon,
    required this.size,
    this.color,
  });

  final String? brand;
  final FaIconData? icon;
  final double size;
  final Color? color;

  static const _githubWhite = Color(0xFFFFFFFF);
  static const _linkedinBlue = Color(0xFF0A66C2);

  @override
  Widget build(BuildContext context) {
    final tint = color ?? Theme.of(context).colorScheme.primary;

    switch (brand) {
      case 'github':
        return BrandMarkIcon(brand: 'github', size: size, color: _githubWhite);
      case 'linkedin':
        return BrandMarkIcon(brand: 'linkedin', size: size, color: _linkedinBlue);
      default:
        return FaIcon(
          icon ?? FontAwesomeIcons.circle,
          size: size,
          color: tint,
        );
    }
  }
}
