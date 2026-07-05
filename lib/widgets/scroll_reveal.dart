import 'package:flutter/material.dart';

/// Fades and slides content in when it enters the viewport while scrolling.
class ScrollReveal extends StatefulWidget {
  const ScrollReveal({
    super.key,
    required this.scrollController,
    required this.child,
    this.delay = Duration.zero,
    this.fromY = 0.05,
  });

  final ScrollController scrollController;
  final Widget child;
  final Duration delay;
  final double fromY;

  @override
  State<ScrollReveal> createState() => _ScrollRevealState();
}

class _ScrollRevealState extends State<ScrollReveal>
    with SingleTickerProviderStateMixin {
  final _key = GlobalKey();
  late AnimationController _controller;
  late Animation<double> _fade;
  late Animation<Offset> _slide;
  bool _revealed = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 620),
    );
    final curve = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutCubic,
    );
    _fade = Tween<double>(begin: 0, end: 1).animate(curve);
    _slide = Tween<Offset>(
      begin: Offset(0, widget.fromY),
      end: Offset.zero,
    ).animate(curve);

    widget.scrollController.addListener(_checkVisibility);
    WidgetsBinding.instance.addPostFrameCallback((_) => _checkVisibility());
  }

  @override
  void dispose() {
    widget.scrollController.removeListener(_checkVisibility);
    _controller.dispose();
    super.dispose();
  }

  void _checkVisibility() {
    if (_revealed || !mounted) return;

    final ctx = _key.currentContext;
    if (ctx == null) return;
    final box = ctx.findRenderObject();
    if (box is! RenderBox || !box.hasSize) return;

    final top = box.localToGlobal(Offset.zero).dy;
    final viewport = MediaQuery.sizeOf(context).height;
    if (top < viewport * 0.9) {
      _revealed = true;
      if (widget.delay == Duration.zero) {
        _controller.forward();
      } else {
        Future.delayed(widget.delay, () {
          if (mounted) _controller.forward();
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fade,
      child: SlideTransition(
        position: _slide,
        child: KeyedSubtree(key: _key, child: widget.child),
      ),
    );
  }
}
