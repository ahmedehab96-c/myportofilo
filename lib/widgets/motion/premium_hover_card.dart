import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../animations/motion_accessibility.dart';
import '../../animations/motion_tokens.dart';
import '../../theme/portfolio_palette.dart';
import 'premium_entrance.dart';

/// Hover / tap / float / glow card shell for portfolio surfaces.
class PremiumHoverCard extends StatefulWidget {
  const PremiumHoverCard({
    super.key,
    this.child,
    this.builder,
    this.entranceDelay = Duration.zero,
    this.scrollController,
    this.glowColor = PortfolioPalette.accent,
    this.borderRadius = MotionTokens.cardRadius,
    this.floating = false,
    this.enableHover = true,
    this.enableTilt3d = true,
    this.enableGlowPulse = false,
    this.shellGlow = false,
    this.onTap,
    this.onHoverChanged,
  }) : assert(child != null || builder != null);

  final Widget? child;
  final Widget Function(BuildContext context, PremiumHoverState state)? builder;
  final Duration entranceDelay;
  final ScrollController? scrollController;
  final Color glowColor;
  final double borderRadius;
  final bool floating;
  final bool enableHover;
  final bool enableTilt3d;
  final bool enableGlowPulse;
  final bool shellGlow;
  final VoidCallback? onTap;
  final ValueChanged<bool>? onHoverChanged;

  @override
  State<PremiumHoverCard> createState() => _PremiumHoverCardState();
}

class PremiumHoverState {
  const PremiumHoverState({
    required this.hovered,
    required this.pressed,
  });

  final bool hovered;
  final bool pressed;
}

class _PremiumHoverCardState extends State<PremiumHoverCard>
    with TickerProviderStateMixin {
  bool _hovered = false;
  bool _pressed = false;
  Offset _tilt = Offset.zero;

  AnimationController? _floatController;
  AnimationController? _glowController;
  AnimationController? _idleTiltController;
  bool _motionInitialized = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_motionInitialized) return;
    _motionInitialized = true;
    final reduce = MotionAccessibility.shouldReduceMotion(context);
    if (widget.floating && !reduce) {
      _floatController = AnimationController(
        vsync: this,
        duration: MotionTokens.floatDuration,
      )..repeat(reverse: true);
    }
    if (widget.enableGlowPulse && !reduce) {
      _glowController = AnimationController(
        vsync: this,
        duration: MotionTokens.glowPulseDuration,
      )..repeat(reverse: true);
    }
    if (widget.enableTilt3d && !reduce) {
      _idleTiltController = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 5200),
      )..repeat(reverse: true);
    }
  }

  @override
  void dispose() {
    _floatController?.dispose();
    _glowController?.dispose();
    _idleTiltController?.dispose();
    super.dispose();
  }

  void _updateTiltFromPosition(PointerHoverEvent event) {
    final box = context.findRenderObject() as RenderBox?;
    if (box == null || !box.hasSize) return;
    final local = box.globalToLocal(event.position);
    setState(() {
      _tilt = Offset(
        (local.dx / box.size.width - 0.5) * 2,
        (local.dy / box.size.height - 0.5) * 2,
      );
    });
  }

  void _resetTilt() {
    if (_tilt == Offset.zero) return;
    setState(() => _tilt = Offset.zero);
  }

  Matrix4 _tiltTransform(bool reduceMotion, bool hoverActive) {
    if (reduceMotion || !widget.enableTilt3d) {
      return Matrix4.identity();
    }

    var rotateX = 0.0;
    var rotateY = 0.0;

    if (hoverActive && _tilt != Offset.zero) {
      rotateX = -_tilt.dy * 0.08;
      rotateY = _tilt.dx * 0.08;
    } else if (_idleTiltController != null) {
      final idle = _idleTiltController!.value * math.pi * 2;
      rotateX = math.sin(idle) * 0.018;
      rotateY = math.cos(idle * 0.85) * 0.022;
    }

    return Matrix4.identity()
      ..setEntry(3, 2, 0.0012)
      ..rotateX(rotateX)
      ..rotateY(rotateY);
  }

  void _setHovered(bool value) {
    if (_hovered == value) return;
    setState(() => _hovered = value);
    widget.onHoverChanged?.call(value);
  }

  void _setPressed(bool value) {
    if (_pressed == value) return;
    setState(() => _pressed = value);
  }

  void _handleTap() {
    if (!MotionAccessibility.shouldReduceMotion(context) && !kIsWeb) {
      unawaited(HapticFeedback.lightImpact());
    }
    widget.onTap?.call();
  }

  @override
  Widget build(BuildContext context) {
    final reduceMotion = MotionAccessibility.shouldReduceMotion(context);
    final state = PremiumHoverState(hovered: _hovered, pressed: _pressed);
    final content = widget.builder?.call(context, state) ?? widget.child!;

    Widget surface = content;

    if (widget.onTap != null) {
      surface = Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: _handleTap,
          onHighlightChanged: _setPressed,
          borderRadius: BorderRadius.circular(widget.borderRadius),
          splashColor: widget.glowColor.withValues(alpha: 0.12),
          highlightColor: widget.glowColor.withValues(alpha: 0.06),
          child: content,
        ),
      );
    }

    Widget card = AnimatedBuilder(
      animation: Listenable.merge([
        if (_floatController != null) _floatController!,
        if (_glowController != null) _glowController!,
        if (_idleTiltController != null) _idleTiltController!,
      ]),
      builder: (context, child) {
        final hoverActive = widget.enableHover && _hovered && !_pressed;
        final lift = reduceMotion ? 0.0 : (hoverActive ? MotionTokens.hoverLift : 0);
        final scale = reduceMotion
            ? 1.0
            : _pressed
                ? MotionTokens.tapScale
                : hoverActive
                    ? MotionTokens.hoverScale
                    : 1.0;

        double floatY = 0;
        if (_floatController != null && !reduceMotion) {
          floatY = (_floatController!.value * 2 - 1) * MotionTokens.floatAmplitude;
        }

        final glowPulse = _glowController?.value ?? 0;
        final glowAlpha = reduceMotion
            ? 0.0
            : (hoverActive ? 0.42 : 0.16 + glowPulse * 0.12);

        return Transform(
          alignment: Alignment.center,
          transform: _tiltTransform(reduceMotion, hoverActive),
          child: Transform.translate(
            offset: Offset(0, -lift + floatY),
            child: Transform.scale(
              scale: scale,
              alignment: Alignment.center,
              child: widget.shellGlow
                  ? DecoratedBox(
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(widget.borderRadius),
                        boxShadow: [
                          BoxShadow(
                            color: widget.glowColor.withValues(alpha: glowAlpha),
                            blurRadius: hoverActive ? 32 : 18,
                            spreadRadius: hoverActive ? 2 : 0,
                            offset: Offset(0, hoverActive ? 16 : 8),
                          ),
                          BoxShadow(
                            color: Colors.black
                                .withValues(alpha: hoverActive ? 0.16 : 0.08),
                            blurRadius: hoverActive ? 28 : 14,
                            offset: Offset(0, hoverActive ? 14 : 6),
                          ),
                        ],
                        border: Border.all(
                          color: widget.glowColor.withValues(
                            alpha: hoverActive
                                ? 0.5
                                : 0.14 + glowPulse * 0.1,
                          ),
                          width: hoverActive ? 1.5 : 1,
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius:
                            BorderRadius.circular(widget.borderRadius),
                        child: child,
                      ),
                    )
                  : child,
            ),
          ),
        );
      },
      child: surface,
    );

    if (widget.enableHover) {
      card = MouseRegion(
        onEnter: (_) => _setHovered(true),
        onExit: (_) {
          _setHovered(false);
          _resetTilt();
        },
        onHover: widget.enableTilt3d ? _updateTiltFromPosition : null,
        cursor: widget.onTap != null
            ? SystemMouseCursors.click
            : SystemMouseCursors.basic,
        child: card,
      );
    }

    return PremiumEntrance(
      delay: widget.entranceDelay,
      scrollController: widget.scrollController,
      child: card,
    );
  }
}

/// Backward-compatible alias used across the portfolio.
class GlowCard extends PremiumHoverCard {
  const GlowCard({
    super.key,
    super.child,
    super.builder,
    super.entranceDelay = Duration.zero,
    super.scrollController,
    super.glowColor,
    super.borderRadius,
    super.floating = false,
    super.enableHover = true,
    super.onTap,
    super.onHoverChanged,
  }) : super(enableGlowPulse: true);
}

/// Alias for documentation parity with the motion spec.
typedef AnimatedCard = PremiumHoverCard;
typedef HoverCard = PremiumHoverCard;
