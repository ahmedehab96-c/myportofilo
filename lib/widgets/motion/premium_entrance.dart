import 'dart:async';
import 'dart:ui';

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';

import '../../animations/motion_accessibility.dart';
import '../../animations/motion_tokens.dart';

/// Safe scroll/mount entrance: fade + 3D tilt + Y slide (+ optional blur on native).
/// Never sticks hidden — forces visible after [MotionTokens.maxRevealWait].
class PremiumEntrance extends StatefulWidget {
  const PremiumEntrance({
    super.key,
    required this.child,
    this.delay = Duration.zero,
    this.scrollController,
    this.useBlur = true,
  });

  final Widget child;
  final Duration delay;
  final ScrollController? scrollController;
  final bool useBlur;

  @override
  State<PremiumEntrance> createState() => _PremiumEntranceState();
}

class _PremiumEntranceState extends State<PremiumEntrance>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fade;
  late final Animation<double> _scale;
  late final Animation<double> _offsetY;
  late final Animation<double> _tiltX;
  late final Animation<double> _blur;

  Timer? _delayTimer;
  Timer? _fallbackTimer;
  bool _started = false;
  bool _revealed = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: MotionTokens.entranceDuration,
    );
    final curve = CurvedAnimation(
      parent: _controller,
      curve: MotionTokens.entranceCurve,
    );
    _fade = Tween<double>(begin: 0, end: 1).animate(curve);
    _scale = Tween<double>(
      begin: MotionTokens.entranceScaleBegin,
      end: 1,
    ).animate(curve);
    _offsetY = Tween<double>(
      begin: MotionTokens.entranceOffsetY,
      end: 0,
    ).animate(curve);
    _tiltX = Tween<double>(begin: 0.14, end: 0).animate(curve);
    _blur = Tween<double>(
      begin: MotionTokens.entranceBlurSigma,
      end: 0,
    ).animate(curve);

    widget.scrollController?.addListener(_checkVisibility);

    _fallbackTimer = Timer(MotionTokens.maxRevealWait, _forceReveal);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkVisibility();
      if (widget.scrollController == null) {
        _scheduleStart();
        return;
      }
      Future<void>.delayed(const Duration(milliseconds: 48), () {
        if (!mounted || _started || _revealed) return;
        _checkVisibility();
        if (!_started) _scheduleStart();
      });
    });
  }

  @override
  void didUpdateWidget(covariant PremiumEntrance oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.scrollController != widget.scrollController) {
      oldWidget.scrollController?.removeListener(_checkVisibility);
      widget.scrollController?.addListener(_checkVisibility);
    }
  }

  void _scheduleStart() {
    if (_started || _revealed) return;
    _started = true;
    _delayTimer?.cancel();
    _delayTimer = Timer(widget.delay, _startAnimation);
  }

  void _checkVisibility() {
    if (_started || _revealed || !mounted) return;

    final box = context.findRenderObject();
    if (box is! RenderBox || !box.hasSize) return;

    final top = box.localToGlobal(Offset.zero).dy;
    final screenH = MediaQuery.sizeOf(context).height;
    if (top < screenH * 0.94) {
      _scheduleStart();
    }
  }

  void _forceReveal() {
    if (!mounted || _revealed) return;
    _revealed = true;
    _delayTimer?.cancel();
    _controller.value = 1;
  }

  void _startAnimation() {
    if (!mounted || _revealed) return;
    if (MotionAccessibility.shouldReduceMotion(context)) {
      _forceReveal();
      return;
    }
    _revealed = true;
    final compact = MediaQuery.sizeOf(context).shortestSide < 600;
    if (compact && _controller.duration != const Duration(milliseconds: 420)) {
      _controller.duration = const Duration(milliseconds: 420);
    }
    unawaited(_controller.forward());
  }

  @override
  void dispose() {
    _delayTimer?.cancel();
    _fallbackTimer?.cancel();
    widget.scrollController?.removeListener(_checkVisibility);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (MotionAccessibility.shouldReduceMotion(context)) {
      return widget.child;
    }

    final compact = MediaQuery.sizeOf(context).shortestSide < 600;
    final useBlur = widget.useBlur && !compact && !kIsWeb;

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final blurSigma = useBlur ? _blur.value : 0.0;
        Widget result = Transform(
          alignment: Alignment.center,
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0.001)
            ..rotateX(_tiltX.value),
          child: Transform.translate(
            offset: Offset(0, _offsetY.value),
            child: Transform.scale(
              scale: _scale.value,
              alignment: Alignment.center,
              child: Opacity(
                opacity: _fade.value.clamp(0, 1),
                child: child,
              ),
            ),
          ),
        );

        if (blurSigma > 0.05) {
          result = ImageFiltered(
            imageFilter: ImageFilter.blur(
              sigmaX: blurSigma,
              sigmaY: blurSigma,
            ),
            child: result,
          );
        }

        return result;
      },
      child: widget.child,
    );
  }
}
