import 'package:flutter/material.dart';
import 'package:path_drawing/path_drawing.dart';

import 'fa_icon_paths.dart';

/// Stable handle for portfolio icons.
@immutable
class FaIconData {
  const FaIconData(this.codePoint);
  final int codePoint;

  @override
  bool operator ==(Object other) =>
      other is FaIconData && other.codePoint == codePoint;

  @override
  int get hashCode => codePoint.hashCode;
}

/// Same names as font_awesome_flutter.
class FontAwesomeIcons {
  FontAwesomeIcons._();

  static const FaIconData phone = FaIconData(0xf095);
  static const FaIconData envelope = FaIconData(0xf0e0);
  static const FaIconData robot = FaIconData(0xf544);
  static const FaIconData flutter = FaIconData(0xe694);
  static const FaIconData briefcase = FaIconData(0xf0b1);
  static const FaIconData folderOpen = FaIconData(0xf07c);
  static const FaIconData code = FaIconData(0xf121);
  static const FaIconData graduationCap = FaIconData(0xf19d);
  static const FaIconData brain = FaIconData(0xf5dc);
  static const FaIconData database = FaIconData(0xf1c0);
  static const FaIconData laravel = FaIconData(0xf3bd);
  static const FaIconData lock = FaIconData(0xf023);
  static const FaIconData screwdriverWrench = FaIconData(0xf7d9);
  static const FaIconData palette = FaIconData(0xf53f);
  static const FaIconData lightbulb = FaIconData(0xf0eb);
  static const FaIconData filePdf = FaIconData(0xf1c1);
  static const FaIconData github = FaIconData(0xf09b);
  static const FaIconData android = FaIconData(0xf17b);
  static const FaIconData circle = FaIconData(0xf111);
}

/// Draws FA SVG paths via CustomPaint — reliable on web (no font / broken PNG).
/// Flutter brand uses the official logo asset.
class FaIcon extends StatelessWidget {
  const FaIcon(
    this.icon, {
    super.key,
    this.size,
    this.color,
    this.semanticLabel,
  });

  final FaIconData? icon;
  final double? size;
  final Color? color;
  final String? semanticLabel;

  static const flutterLogoAsset = 'assets/images/flutterlogo.jpeg';

  @override
  Widget build(BuildContext context) {
    final s = size ?? IconTheme.of(context).size ?? 24;
    final c = color ?? IconTheme.of(context).color ?? Colors.white;
    final cp = icon?.codePoint;

    if (cp == 0xe694) {
      return Semantics(
        label: semanticLabel ?? 'Flutter',
        child: ClipRRect(
          borderRadius: BorderRadius.circular(s * 0.22),
          child: Image.asset(
            flutterLogoAsset,
            width: s,
            height: s,
            fit: BoxFit.cover,
            filterQuality: FilterQuality.high,
            errorBuilder: (_, __, ___) => Icon(
              Icons.flutter_dash,
              size: s,
              color: c,
            ),
          ),
        ),
      );
    }

    final path = cp != null ? kFaIconPaths[cp] : null;
    if (path != null) {
      return Semantics(
        label: semanticLabel,
        child: SizedBox(
          width: s,
          height: s,
          child: CustomPaint(
            painter: _FaSvgPainter(path, c),
          ),
        ),
      );
    }

    // Fallback brands / unknown.
    if (cp == 0xf09b) {
      return BrandMarkIcon(brand: 'github', size: s, color: c);
    }

    return Icon(Icons.circle, size: s, color: c, semanticLabel: semanticLabel);
  }
}

class _FaSvgPainter extends CustomPainter {
  _FaSvgPainter(this.path, this.color);

  final FaIconPath path;
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final parsed = parseSvgPathData(path.d);
    final scale = (size.width / path.viewBoxW < size.height / path.viewBoxH)
        ? size.width / path.viewBoxW
        : size.height / path.viewBoxH;
    final dx = (size.width - path.viewBoxW * scale) / 2;
    final dy = (size.height - path.viewBoxH * scale) / 2;
    canvas.save();
    canvas.translate(dx, dy);
    canvas.scale(scale);
    canvas.drawPath(
      parsed,
      Paint()
        ..color = color
        ..style = PaintingStyle.fill
        ..isAntiAlias = true,
    );
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant _FaSvgPainter oldDelegate) =>
      oldDelegate.path != path || oldDelegate.color != color;
}

enum _BrandKind { github, linkedin, circle }

/// Official GitHub mark path from Simple Icons / github.svg (viewBox 0 0 24 24).
const _githubOctocatPath =
    'M12 .297c-6.63 0-12 5.373-12 12 0 5.303 3.438 9.8 8.205 11.385.6.113.82-.258.82-.577 0-.285-.01-1.04-.015-2.04-3.338.724-4.042-1.61-4.042-1.61C4.422 18.07 3.633 17.7 3.633 17.7c-1.087-.744.084-.729.084-.729 1.205.084 1.838 1.236 1.838 1.236 1.07 1.835 2.809 1.305 3.495.998.108-.776.417-1.305.76-1.605-2.665-.3-5.466-1.332-5.466-5.93 0-1.31.465-2.38 1.235-3.22-.135-.303-.54-1.523.105-3.176 0 0 1.005-.322 3.3 1.23.96-.267 1.98-.399 3-.405 1.02.006 2.04.138 3 .405 2.28-1.552 3.285-1.23 3.285-1.23.645 1.653.24 2.873.12 3.176.765.84 1.23 1.91 1.23 3.22 0 4.61-2.805 5.625-5.475 5.92.42.36.81 1.096.81 2.22 0 1.606-.015 2.896-.015 3.286 0 .315.21.69.825.57C20.565 22.092 24 17.592 24 12.297c0-6.627-5.373-12-12-12';

class BrandMarkIcon extends StatelessWidget {
  const BrandMarkIcon({
    super.key,
    required this.brand,
    required this.size,
    required this.color,
  });

  final String brand;
  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final kind = switch (brand) {
      'github' => _BrandKind.github,
      'linkedin' => _BrandKind.linkedin,
      _ => _BrandKind.circle,
    };
    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(painter: _BrandPainter(kind, color)),
    );
  }
}

class _BrandPainter extends CustomPainter {
  const _BrandPainter(this.kind, this.color);

  final _BrandKind kind;
  final Color color;

  static final Path _githubPath = parseSvgPathData(_githubOctocatPath);

  @override
  void paint(Canvas canvas, Size size) {
    final fill = Paint()
      ..color = color
      ..style = PaintingStyle.fill
      ..isAntiAlias = true;
    final w = size.width;
    final h = size.height;

    switch (kind) {
      case _BrandKind.github:
        canvas.save();
        final scale = size.shortestSide / 24;
        canvas.translate(
          (size.width - 24 * scale) / 2,
          (size.height - 24 * scale) / 2,
        );
        canvas.scale(scale);
        canvas.drawPath(_githubPath, fill);
        canvas.restore();
      case _BrandKind.linkedin:
        canvas.drawRRect(
          RRect.fromRectAndRadius(
            Rect.fromLTWH(w * 0.06, h * 0.06, w * 0.88, h * 0.88),
            Radius.circular(w * 0.12),
          ),
          fill,
        );
        final ink = Paint()..color = Colors.white;
        canvas.drawCircle(Offset(w * 0.28, h * 0.3), w * 0.08, ink);
        canvas.drawRect(Rect.fromLTWH(w * 0.2, h * 0.42, w * 0.16, h * 0.38), ink);
        canvas.drawRect(Rect.fromLTWH(w * 0.44, h * 0.42, w * 0.16, h * 0.38), ink);
        canvas.drawRRect(
          RRect.fromRectAndRadius(
            Rect.fromLTWH(w * 0.62, h * 0.42, w * 0.18, h * 0.38),
            Radius.circular(w * 0.04),
          ),
          ink,
        );
      case _BrandKind.circle:
        canvas.drawCircle(Offset(w * 0.5, h * 0.5), w * 0.28, fill);
    }
  }

  @override
  bool shouldRepaint(covariant _BrandPainter oldDelegate) =>
      oldDelegate.kind != kind || oldDelegate.color != color;
}
