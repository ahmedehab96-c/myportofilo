import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

/// Official brand logos for GitHub and LinkedIn; Font Awesome for other contacts.
class BrandContactIcon extends StatelessWidget {
  const BrandContactIcon({
    super.key,
    this.brand,
    this.icon,
    required this.size,
    this.color,
  });

  final String? brand;
  final IconData? icon;
  final double size;
  final Color? color;

  static const _githubWhite = Color(0xFFFFFFFF);
  static const _linkedinBlue = Color(0xFF0A66C2);

  @override
  Widget build(BuildContext context) {
    final tint = color ?? Theme.of(context).colorScheme.primary;

    switch (brand) {
      case 'github':
        return SvgPicture.asset(
          'assets/icons/github.svg',
          width: size,
          height: size,
          colorFilter: const ColorFilter.mode(_githubWhite, BlendMode.srcIn),
        );
      case 'linkedin':
        return SvgPicture.asset(
          'assets/icons/linkedin.svg',
          width: size,
          height: size,
          colorFilter: const ColorFilter.mode(_linkedinBlue, BlendMode.srcIn),
        );
      default:
        return FaIcon(
          icon ?? FontAwesomeIcons.circle,
          size: size,
          color: tint,
        );
    }
  }
}
