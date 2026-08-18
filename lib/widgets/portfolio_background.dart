import 'package:flutter/material.dart';

import '../theme/portfolio_palette.dart';

/// Professional static backdrop — soft navy gradient with gentle accent glows.
class PortfolioBackground extends StatelessWidget {
  const PortfolioBackground({
    super.key,
    required this.animation,
    required this.palette,
    this.animate = false,
    this.lite = false,
  });

  final Animation<double> animation;
  final PortfolioPalette palette;
  final bool animate;
  final bool lite;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        DecoratedBox(decoration: BoxDecoration(gradient: palette.backgroundGradient)),
        // Soft violet glow — upper-left, AI-inspired.
        DecoratedBox(
          decoration: BoxDecoration(
            gradient: RadialGradient(
              center: const Alignment(-0.65, -0.75),
              radius: 1.15,
              colors: [
                PortfolioPalette.violet.withValues(alpha: 0.16),
                Colors.transparent,
              ],
            ),
          ),
        ),
        // Soft cyan glow — upper-right, developer/technology-inspired.
        DecoratedBox(
          decoration: BoxDecoration(
            gradient: RadialGradient(
              center: const Alignment(0.85, -0.15),
              radius: 0.9,
              colors: [
                PortfolioPalette.accent.withValues(alpha: 0.13),
                Colors.transparent,
              ],
            ),
          ),
        ),
        // Faint vignette for depth and smooth section transitions.
        DecoratedBox(
          decoration: BoxDecoration(
            gradient: RadialGradient(
              center: const Alignment(0.1, 1.05),
              radius: 1.1,
              colors: [
                palette.bgDeep.withValues(alpha: 0.5),
                Colors.transparent,
              ],
            ),
          ),
        ),
        DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                palette.bgElevated.withValues(alpha: 0.35),
                Colors.transparent,
                palette.bgDeep.withValues(alpha: 0.45),
              ],
              stops: const [0.0, 0.5, 1.0],
            ),
          ),
        ),
        if (!lite)
          CustomPaint(painter: _SoftGridPainter(palette: palette)),
      ],
    );
  }
}

class _SoftGridPainter extends CustomPainter {
  _SoftGridPainter({required this.palette});

  final PortfolioPalette palette;

  @override
  void paint(Canvas canvas, Size size) {
    const spacing = 56.0;
    final paint = Paint()
      ..color = PortfolioPalette.accent.withValues(alpha: 0.022)
      ..strokeWidth = 0.5;

    for (var x = 0.0; x < size.width; x += spacing) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (var y = 0.0; y < size.height; y += spacing) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(_SoftGridPainter oldDelegate) => false;
}
