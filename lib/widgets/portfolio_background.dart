import 'dart:math' as math;

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';

import '../theme/portfolio_palette.dart';

/// Animated portfolio backdrop — optimized for smooth 60fps on web.
class PortfolioBackground extends StatelessWidget {
  const PortfolioBackground({
    super.key,
    required this.animation,
    required this.palette,
    this.animate = true,
  });

  final Animation<double> animation;
  final PortfolioPalette palette;
  final bool animate;

  @override
  Widget build(BuildContext context) {
    final gradient = BoxDecoration(gradient: palette.backgroundGradient);

    if (kIsWeb && !animate) {
      return DecoratedBox(decoration: gradient);
    }

    return RepaintBoundary(
      child: AnimatedBuilder(
        animation: animation,
        builder: (context, _) {
          return Stack(
            fit: StackFit.expand,
            children: [
              DecoratedBox(decoration: gradient),
              CustomPaint(
                painter: MeshGlowPainter(
                  animation: animation,
                  palette: palette,
                  lite: kIsWeb,
                ),
              ),
              CustomPaint(
                painter: AuroraBandsPainter(
                  animation: animation,
                  palette: palette,
                ),
              ),
              if (!kIsWeb)
                CustomPaint(
                  painter: GridPatternPainter(
                    animation: animation,
                    palette: palette,
                  ),
                ),
              CustomPaint(
                painter: FloatingParticlesPainter(
                  animation: animation,
                  palette: palette,
                  count: kIsWeb ? 28 : 48,
                ),
              ),
              CustomPaint(
                painter: AnimatedWavesPainter(
                  animation: animation,
                  palette: palette,
                ),
              ),
              DecoratedBox(
                decoration: BoxDecoration(
                  gradient: RadialGradient(
                    center: const Alignment(0.5, -0.3),
                    radius: 1.1,
                    colors: [
                      PortfolioPalette.accent.withValues(
                        alpha: palette.isDark ? 0.1 : 0.08,
                      ),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class MeshGlowPainter extends CustomPainter {
  MeshGlowPainter({
    required this.animation,
    required this.palette,
    this.lite = false,
  }) : super(repaint: animation);

  final Animation<double> animation;
  final PortfolioPalette palette;
  final bool lite;

  @override
  void paint(Canvas canvas, Size size) {
    final t = animation.value;
    final rings = lite ? 3 : 5;
    final blobs = [
      (const Alignment(0.12, 0.18), PortfolioPalette.accent),
      (const Alignment(0.88, 0.12), PortfolioPalette.violet),
      (const Alignment(0.78, 0.78), PortfolioPalette.sky),
      (const Alignment(0.08, 0.82), PortfolioPalette.teal),
    ];
    final alpha = palette.meshBlobAlpha;

    for (var i = 0; i < blobs.length; i++) {
      final blob = blobs[i];
      final drift = Offset(
        math.sin(t * math.pi * 2 + i * 1.7) * size.width * 0.035,
        math.cos(t * math.pi * 2 + i * 1.3) * size.height * 0.035,
      );
      final center = Offset(
        size.width * (blob.$1.x + 1) / 2 + drift.dx,
        size.height * (blob.$1.y + 1) / 2 + drift.dy,
      );
      final baseRadius = size.shortestSide * 0.2;
      final pulse = 1.0 + math.sin(t * math.pi * 2 + i) * 0.06;

      for (var ring = rings; ring >= 0; ring--) {
        canvas.drawCircle(
          center,
          baseRadius * (1.0 + ring * 0.42) * pulse,
          Paint()
            ..color = blob.$2.withValues(alpha: alpha - ring * 0.004)
            ..blendMode = BlendMode.plus,
        );
      }
    }
  }

  @override
  bool shouldRepaint(MeshGlowPainter oldDelegate) =>
      oldDelegate.palette != palette;
}

class AuroraBandsPainter extends CustomPainter {
  AuroraBandsPainter({required this.animation, required this.palette})
      : super(repaint: animation);

  final Animation<double> animation;
  final PortfolioPalette palette;

  @override
  void paint(Canvas canvas, Size size) {
    final t = animation.value;
    final paint = Paint()..blendMode = BlendMode.plus;
    final bands = [
      (0.2, PortfolioPalette.accent, palette.isDark ? 0.06 : 0.04),
      (0.5, PortfolioPalette.violet, palette.isDark ? 0.05 : 0.03),
      (0.72, PortfolioPalette.sky, palette.isDark ? 0.04 : 0.025),
    ];

    for (var i = 0; i < bands.length; i++) {
      final (yFactor, color, alpha) = bands[i];
      final y = size.height * yFactor +
          math.sin(t * math.pi * 2 + i * 2.1) * size.height * 0.025;

      paint.shader = LinearGradient(
        begin: Alignment(-1.0 + t * 1.6, 0),
        end: Alignment(1.0 + t * 1.6, 0),
        colors: [
          Colors.transparent,
          color.withValues(alpha: alpha),
          color.withValues(alpha: alpha * 1.3),
          Colors.transparent,
        ],
        stops: const [0.0, 0.38, 0.62, 1.0],
      ).createShader(Rect.fromLTWH(0, y - 70, size.width, 140));

      canvas.drawRect(Rect.fromLTWH(0, y - 70, size.width, 140), paint);
    }
  }

  @override
  bool shouldRepaint(AuroraBandsPainter oldDelegate) =>
      oldDelegate.palette != palette;
}

class GridPatternPainter extends CustomPainter {
  GridPatternPainter({required this.animation, required this.palette})
      : super(repaint: animation);

  final Animation<double> animation;
  final PortfolioPalette palette;

  @override
  void paint(Canvas canvas, Size size) {
    const spacing = 56.0;
    final drift = animation.value * spacing * 0.2;

    final linePaint = Paint()
      ..color = PortfolioPalette.accent.withValues(
        alpha: palette.isDark ? 0.04 : 0.06,
      )
      ..strokeWidth = 0.7;

    for (var x = -spacing; x < size.width + spacing; x += spacing) {
      canvas.drawLine(
        Offset(x + drift, 0),
        Offset(x + drift, size.height),
        linePaint,
      );
    }
    for (var y = -spacing; y < size.height + spacing; y += spacing) {
      canvas.drawLine(
        Offset(0, y + drift * 0.5),
        Offset(size.width, y + drift * 0.5),
        linePaint,
      );
    }
  }

  @override
  bool shouldRepaint(GridPatternPainter oldDelegate) =>
      oldDelegate.palette != palette;
}

class FloatingParticlesPainter extends CustomPainter {
  FloatingParticlesPainter({
    required this.animation,
    required this.palette,
    this.count = 40,
  }) : super(repaint: animation);

  final Animation<double> animation;
  final PortfolioPalette palette;
  final int count;

  @override
  void paint(Canvas canvas, Size size) {
    final random = math.Random(42);
    final t = animation.value;

    for (var i = 0; i < count; i++) {
      final x = random.nextDouble() * size.width;
      final y = random.nextDouble() * size.height;
      final isBright = i % 11 == 0;
      final radius = isBright ? 2.0 : 0.7 + random.nextDouble() * 1.2;

      canvas.drawCircle(
        Offset(
          x + math.sin(t * math.pi * 2 + i * 0.45) * 20,
          y + math.cos(t * math.pi * 2 + i * 0.5) * 16,
        ),
        radius,
        Paint()
          ..color = (isBright ? PortfolioPalette.accent : palette.textMuted)
              .withValues(alpha: isBright ? 0.22 : 0.1)
          ..blendMode = isBright ? BlendMode.plus : BlendMode.srcOver,
      );
    }
  }

  @override
  bool shouldRepaint(FloatingParticlesPainter oldDelegate) =>
      oldDelegate.count != count || oldDelegate.palette != palette;
}

class AnimatedWavesPainter extends CustomPainter {
  AnimatedWavesPainter({required this.animation, required this.palette})
      : super(repaint: animation);

  final Animation<double> animation;
  final PortfolioPalette palette;

  @override
  void paint(Canvas canvas, Size size) {
    final offset = animation.value * size.width * 0.35;

    for (var layer = 0; layer < 2; layer++) {
      final path = Path();
      final baseY = size.height * (0.74 + layer * 0.07);
      final amplitude = 14.0 + layer * 6;
      final alpha = palette.isDark ? 0.055 - layer * 0.015 : 0.04 - layer * 0.01;

      path.moveTo(0, baseY);
      for (var i = 0.0; i <= size.width; i += 6) {
        path.lineTo(
          i,
          baseY +
              math.sin((i * 0.016) - offset + layer) * amplitude +
              math.cos((i * 0.01) - offset * 0.5) * amplitude * 0.45,
        );
      }

      canvas.drawPath(
        path,
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.1 + layer * 0.3
          ..shader = LinearGradient(
            colors: [
              Colors.transparent,
              PortfolioPalette.accent.withValues(alpha: alpha),
              PortfolioPalette.sky.withValues(alpha: alpha * 1.1),
              Colors.transparent,
            ],
          ).createShader(Rect.fromLTWH(0, baseY - 36, size.width, 72)),
      );
    }
  }

  @override
  bool shouldRepaint(AnimatedWavesPainter oldDelegate) =>
      oldDelegate.palette != palette;
}
