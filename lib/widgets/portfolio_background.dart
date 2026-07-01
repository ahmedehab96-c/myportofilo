import 'dart:math' as math;
import 'package:flutter/material.dart';

/// Animated portfolio backdrop: mesh gradients, grid, aurora, and particles.
class PortfolioBackground extends StatelessWidget {
  const PortfolioBackground({super.key, required this.animation});

  final Animation<double> animation;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, _) {
        return Stack(
          fit: StackFit.expand,
          children: [
            const DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFF020617),
                    Color(0xFF0B1224),
                    Color(0xFF0F172A),
                    Color(0xFF0A0E27),
                  ],
                  stops: [0.0, 0.35, 0.7, 1.0],
                ),
              ),
            ),
            CustomPaint(
              painter: MeshGlowPainter(animation: animation),
            ),
            CustomPaint(
              painter: AuroraBandsPainter(animation: animation),
            ),
            CustomPaint(
              painter: GridPatternPainter(animation: animation),
            ),
            CustomPaint(
              painter: FloatingParticlesPainter(animation: animation),
            ),
            CustomPaint(
              painter: AnimatedWavesPainter(animation: animation),
            ),
            const DecoratedBox(
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  center: Alignment(0.5, -0.2),
                  radius: 1.1,
                  colors: [
                    Colors.transparent,
                    Color(0x66020617),
                  ],
                ),
              ),
            ),
            const DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0x33000999),
                    Colors.transparent,
                    Color(0x55020617),
                  ],
                  stops: [0.0, 0.45, 1.0],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class MeshGlowPainter extends CustomPainter {
  MeshGlowPainter({required this.animation}) : super(repaint: animation);

  final Animation<double> animation;

  static const _blobs = [
    (Alignment(0.15, 0.2), Color(0xFF0099FF), 0.22),
    (Alignment(0.85, 0.15), Color(0xFF7C3AED), 0.2),
    (Alignment(0.75, 0.75), Color(0xFF00B0FF), 0.18),
    (Alignment(0.1, 0.85), Color(0xFF2DD4BF), 0.14),
  ];

  @override
  void paint(Canvas canvas, Size size) {
    final t = animation.value;

    for (var i = 0; i < _blobs.length; i++) {
      final blob = _blobs[i];
      final drift = Offset(
        math.sin(t * math.pi * 2 + i * 1.7) * size.width * 0.04,
        math.cos(t * math.pi * 2 + i * 1.3) * size.height * 0.04,
      );
      final center = Offset(
        size.width * (blob.$1.x + 1) / 2 + drift.dx,
        size.height * (blob.$1.y + 1) / 2 + drift.dy,
      );
      final baseRadius = size.shortestSide * blob.$3;
      final pulse = 1.0 + math.sin(t * math.pi * 2 + i) * 0.08;

      for (var ring = 6; ring >= 0; ring--) {
        final factor = 1.0 + ring * 0.45;
        canvas.drawCircle(
          center,
          baseRadius * factor * pulse,
          Paint()
            ..color = blob.$2.withValues(alpha: 0.045 - ring * 0.005)
            ..blendMode = BlendMode.plus,
        );
      }
    }
  }

  @override
  bool shouldRepaint(MeshGlowPainter oldDelegate) => true;
}

class AuroraBandsPainter extends CustomPainter {
  AuroraBandsPainter({required this.animation}) : super(repaint: animation);

  final Animation<double> animation;

  @override
  void paint(Canvas canvas, Size size) {
    final t = animation.value;
    final paint = Paint()..blendMode = BlendMode.plus;

    final bands = [
      (0.18, const Color(0xFF0099FF), 0.07),
      (0.42, const Color(0xFF6366F1), 0.06),
      (0.68, const Color(0xFF00B0FF), 0.05),
    ];

    for (var i = 0; i < bands.length; i++) {
      final (yFactor, color, alpha) = bands[i];
      final y = size.height * yFactor +
          math.sin(t * math.pi * 2 + i * 2.1) * size.height * 0.03;

      paint.shader = LinearGradient(
        begin: Alignment(-1.0 + t * 2, 0),
        end: Alignment(1.0 + t * 2, 0),
        colors: [
          Colors.transparent,
          color.withValues(alpha: alpha),
          color.withValues(alpha: alpha * 1.4),
          Colors.transparent,
        ],
        stops: const [0.0, 0.35, 0.65, 1.0],
      ).createShader(Rect.fromLTWH(0, y - 80, size.width, 160));

      canvas.drawRect(
        Rect.fromLTWH(0, y - 80, size.width, 160),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(AuroraBandsPainter oldDelegate) => true;
}

class GridPatternPainter extends CustomPainter {
  GridPatternPainter({required this.animation}) : super(repaint: animation);

  final Animation<double> animation;

  @override
  void paint(Canvas canvas, Size size) {
    const spacing = 48.0;
    final drift = animation.value * spacing * 0.25;

    final linePaint = Paint()
      ..color = const Color(0xFF0099FF).withValues(alpha: 0.045)
      ..strokeWidth = 0.8;

    for (var x = -spacing; x < size.width + spacing; x += spacing) {
      canvas.drawLine(
        Offset(x + drift, 0),
        Offset(x + drift, size.height),
        linePaint,
      );
    }
    for (var y = -spacing; y < size.height + spacing; y += spacing) {
      canvas.drawLine(
        Offset(0, y + drift * 0.6),
        Offset(size.width, y + drift * 0.6),
        linePaint,
      );
    }

    final dotPaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.06)
      ..style = PaintingStyle.fill;

    for (var x = 0.0; x < size.width + spacing; x += spacing) {
      for (var y = 0.0; y < size.height + spacing; y += spacing) {
        canvas.drawCircle(Offset(x + drift, y + drift * 0.6), 1.2, dotPaint);
      }
    }
  }

  @override
  bool shouldRepaint(GridPatternPainter oldDelegate) => true;
}

class FloatingParticlesPainter extends CustomPainter {
  FloatingParticlesPainter({required this.animation}) : super(repaint: animation);

  final Animation<double> animation;

  @override
  void paint(Canvas canvas, Size size) {
    final random = math.Random(42);
    final t = animation.value;

    for (var i = 0; i < 70; i++) {
      final x = random.nextDouble() * size.width;
      final y = random.nextDouble() * size.height;
      final isBright = i % 9 == 0;
      final radius = isBright ? 2.2 : 0.8 + random.nextDouble() * 1.4;
      final alpha = isBright ? 0.35 : 0.08 + random.nextDouble() * 0.18;
      final color = isBright
          ? const Color(0xFF67E8F9)
          : Colors.white.withValues(alpha: alpha);

      canvas.drawCircle(
        Offset(
          x + math.sin(t * math.pi * 2 + i * 0.4) * 24,
          y + math.cos(t * math.pi * 2 + i * 0.55) * 18,
        ),
        radius,
        Paint()
          ..color = color.withValues(alpha: isBright ? alpha : alpha)
          ..blendMode = isBright ? BlendMode.plus : BlendMode.srcOver,
      );
    }
  }

  @override
  bool shouldRepaint(FloatingParticlesPainter oldDelegate) => true;
}

class AnimatedWavesPainter extends CustomPainter {
  AnimatedWavesPainter({required this.animation}) : super(repaint: animation);

  final Animation<double> animation;

  @override
  void paint(Canvas canvas, Size size) {
    final offset = animation.value * size.width * 0.4;

    for (var layer = 0; layer < 3; layer++) {
      final path = Path();
      final baseY = size.height * (0.72 + layer * 0.06);
      final amplitude = 18.0 + layer * 8;
      final alpha = 0.06 - layer * 0.015;

      path.moveTo(0, baseY);
      for (var i = 0.0; i <= size.width; i += 4) {
        path.lineTo(
          i,
          baseY +
              math.sin((i * 0.018) - offset + layer) * amplitude +
              math.cos((i * 0.012) - offset * 0.6) * amplitude * 0.5,
        );
      }

      final paint = Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.2 + layer * 0.4
        ..shader = LinearGradient(
          colors: [
            Colors.transparent,
            const Color(0xFF0099FF).withValues(alpha: alpha),
            const Color(0xFF00B0FF).withValues(alpha: alpha * 1.2),
            Colors.transparent,
          ],
        ).createShader(Rect.fromLTWH(0, baseY - 40, size.width, 80));

      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(AnimatedWavesPainter oldDelegate) => true;
}
