import 'dart:async';

import 'package:flutter/material.dart';

import '../../animations/motion_accessibility.dart';
import '../../animations/motion_tokens.dart';
import '../fa_shim.dart';

/// Icon badge with soft entrance, hover scale, and optional glow.
class AnimatedIconBadge extends StatefulWidget {
  const AnimatedIconBadge({
    super.key,
    required this.icon,
    required this.color,
    this.size = 28,
    this.boxSize = 56,
    this.semanticLabel,
    this.flutterBrand = false,
  });

  final FaIconData icon;
  final Color color;
  final double size;
  final double boxSize;
  final String? semanticLabel;
  final bool flutterBrand;

  @override
  State<AnimatedIconBadge> createState() => _AnimatedIconBadgeState();
}

class _AnimatedIconBadgeState extends State<AnimatedIconBadge>
    with SingleTickerProviderStateMixin {
  bool _hovered = false;
  late final AnimationController _enterController;
  late final Animation<double> _enterScale;
  late final Animation<double> _enterRotate;

  @override
  void initState() {
    super.initState();
    _enterController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 520),
    );
    final curve = CurvedAnimation(
      parent: _enterController,
      curve: MotionTokens.entranceCurve,
    );
    _enterScale = Tween<double>(begin: 0.82, end: 1).animate(curve);
    _enterRotate = Tween<double>(begin: -0.08, end: 0).animate(curve);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      if (MotionAccessibility.shouldReduceMotion(context)) {
        _enterController.value = 1;
      } else {
        unawaited(_enterController.forward());
      }
    });
  }

  @override
  void dispose() {
    _enterController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final hoverScale = _hovered && !MotionAccessibility.shouldReduceMotion(context)
        ? 1.08
        : 1.0;

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedBuilder(
        animation: _enterController,
        builder: (context, child) {
          return Transform.rotate(
            angle: _enterRotate.value,
            child: Transform.scale(
              scale: _enterScale.value * hoverScale,
              child: child,
            ),
          );
        },
        child: Container(
          width: widget.boxSize,
          height: widget.boxSize,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            color: widget.color.withValues(alpha: 0.08),
            border: Border.all(
              color: widget.color.withValues(alpha: _hovered ? 0.65 : 0.35),
              width: 2,
            ),
            boxShadow: [
              BoxShadow(
                color: widget.color.withValues(alpha: _hovered ? 0.35 : 0.18),
                blurRadius: _hovered ? 16 : 10,
                spreadRadius: _hovered ? 1 : 0,
              ),
            ],
          ),
          child: Center(
            child: widget.flutterBrand
                ? FaIcon(
                    FontAwesomeIcons.flutter,
                    size: widget.size + 2,
                    semanticLabel: widget.semanticLabel,
                  )
                : FaIcon(
                    widget.icon,
                    color: widget.color,
                    size: widget.size,
                    semanticLabel: widget.semanticLabel,
                  ),
          ),
        ),
      ),
    );
  }
}
