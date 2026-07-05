import 'package:flutter/foundation.dart' show kIsWeb, defaultTargetPlatform, TargetPlatform;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../theme/portfolio_palette.dart';
import '../ui_strings.dart';

/// Top navigation bar with sliding active indicator.
class PortfolioNavBar extends StatefulWidget {
  const PortfolioNavBar({
    super.key,
    required this.items,
    required this.activeIndex,
    required this.onSelected,
    required this.onOpenAi,
  });

  final List<String> items;
  final int activeIndex;
  final ValueChanged<int> onSelected;
  final VoidCallback onOpenAi;

  @override
  State<PortfolioNavBar> createState() => _PortfolioNavBarState();
}

class _PortfolioNavBarState extends State<PortfolioNavBar> {
  final _rowKey = GlobalKey();
  final _pillKeys = <GlobalKey>[];
  double _indicatorLeft = 0;
  double _indicatorWidth = 0;
  bool _indicatorReady = false;

  @override
  void initState() {
    super.initState();
    _pillKeys.addAll(List.generate(widget.items.length, (_) => GlobalKey()));
    WidgetsBinding.instance.addPostFrameCallback((_) => _syncIndicator());
  }

  @override
  void didUpdateWidget(PortfolioNavBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.activeIndex != widget.activeIndex ||
        oldWidget.items.length != widget.items.length) {
      WidgetsBinding.instance.addPostFrameCallback((_) => _syncIndicator());
    }
  }

  void _syncIndicator() {
    if (!mounted) return;
    final index = widget.activeIndex.clamp(0, _pillKeys.length - 1);
    final pillBox = _pillKeys[index].currentContext?.findRenderObject() as RenderBox?;
    final rowBox = _rowKey.currentContext?.findRenderObject() as RenderBox?;
    if (pillBox == null || rowBox == null || !pillBox.hasSize) return;

    final pillOrigin = pillBox.localToGlobal(Offset.zero);
    final rowOrigin = rowBox.localToGlobal(Offset.zero);

    setState(() {
      _indicatorLeft = pillOrigin.dx - rowOrigin.dx;
      _indicatorWidth = pillBox.size.width;
      _indicatorReady = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final p = context.palette;

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 980),
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: p.bgDeep.withValues(alpha: 0.82),
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: p.borderAccent),
              boxShadow: [
                ...p.panelShadow,
                BoxShadow(
                  color: PortfolioPalette.accent.withValues(alpha: 0.12),
                  blurRadius: 24,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(18),
              child: Stack(
                children: [
                  const Positioned(
                    left: 0,
                    right: 0,
                    top: 0,
                    height: 2,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: PortfolioPalette.accentGradient,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Stack(
                              key: _rowKey,
                              clipBehavior: Clip.none,
                              children: [
                                AnimatedPositioned(
                                  duration: const Duration(milliseconds: 380),
                                  curve: Curves.easeOutCubic,
                                  left: _indicatorLeft,
                                  width: _indicatorWidth,
                                  top: 0,
                                  bottom: 0,
                                  child: AnimatedOpacity(
                                    opacity: _indicatorReady ? 1 : 0,
                                    duration: const Duration(milliseconds: 200),
                                    child: DecoratedBox(
                                      decoration: BoxDecoration(
                                        gradient: PortfolioPalette.accentGradient,
                                        borderRadius: BorderRadius.circular(12),
                                        boxShadow: [
                                          BoxShadow(
                                            color: PortfolioPalette.accent
                                                .withValues(alpha: 0.4),
                                            blurRadius: 14,
                                            offset: const Offset(0, 4),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    for (var i = 0; i < widget.items.length; i++)
                                      NavPill(
                                        key: _pillKeys[i],
                                        label: widget.items[i],
                                        isActive: widget.activeIndex == i,
                                        onPressed: () => widget.onSelected(i),
                                      ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          width: 1,
                          height: 28,
                          color: p.borderSubtle,
                        ),
                        const SizedBox(width: 8),
                        NavAiButton(onPressed: widget.onOpenAi),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Navigation pill — label sits above the sliding indicator.
class NavPill extends StatefulWidget {
  const NavPill({
    super.key,
    required this.label,
    required this.isActive,
    required this.onPressed,
  });

  final String label;
  final bool isActive;
  final VoidCallback onPressed;

  @override
  State<NavPill> createState() => _NavPillState();
}

class _NavPillState extends State<NavPill> with SingleTickerProviderStateMixin {
  bool _hovering = false;
  late AnimationController _tapController;
  late Animation<double> _tapScale;

  @override
  void initState() {
    super.initState();
    _tapController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 140),
    );
    _tapScale = Tween<double>(begin: 1, end: 0.92).animate(
      CurvedAnimation(parent: _tapController, curve: Curves.easeOutCubic),
    );
  }

  @override
  void dispose() {
    _tapController.dispose();
    super.dispose();
  }

  Future<void> _handleTap() async {
    HapticFeedback.selectionClick();
    await _tapController.forward();
    await _tapController.reverse();
    widget.onPressed();
  }

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final highlighted = _hovering && !widget.isActive;

    final child = ScaleTransition(
      scale: _tapScale,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 260),
        curve: Curves.easeOutCubic,
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: highlighted
              ? p.surfaceRaised.withValues(alpha: 0.65)
              : Colors.transparent,
          border: Border.all(
            color: highlighted ? p.borderHover : Colors.transparent,
          ),
        ),
        child: AnimatedDefaultTextStyle(
          duration: const Duration(milliseconds: 260),
          curve: Curves.easeOutCubic,
          style: TextStyle(
            fontSize: 14,
            fontWeight: widget.isActive ? FontWeight.w700 : FontWeight.w600,
            color: widget.isActive
                ? Colors.white
                : highlighted
                    ? p.textPrimary
                    : p.textSecondary,
            letterSpacing: 0.35,
          ),
          child: Text(widget.label),
        ),
      ),
    );

    final isDesktop = kIsWeb ||
        defaultTargetPlatform == TargetPlatform.macOS ||
        defaultTargetPlatform == TargetPlatform.windows ||
        defaultTargetPlatform == TargetPlatform.linux;

    if (isDesktop) {
      return MouseRegion(
        onEnter: (_) => setState(() => _hovering = true),
        onExit: (_) => setState(() => _hovering = false),
        cursor: SystemMouseCursors.click,
        child: GestureDetector(onTap: _handleTap, child: child),
      );
    }

    return GestureDetector(onTap: _handleTap, child: child);
  }
}

/// AI assistant shortcut in the top navigation bar.
class NavAiButton extends StatefulWidget {
  const NavAiButton({super.key, required this.onPressed});

  final VoidCallback onPressed;

  @override
  State<NavAiButton> createState() => _NavAiButtonState();
}

class _NavAiButtonState extends State<NavAiButton>
    with SingleTickerProviderStateMixin {
  bool _hovering = false;
  late AnimationController _pulseController;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _pulseController,
      builder: (context, _) {
        final glow = 0.28 + _pulseController.value * 0.18;

        final child = AnimatedScale(
          scale: _hovering ? 1.05 : 1,
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOutCubic,
          child: DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              gradient: PortfolioPalette.aiGradient,
              boxShadow: [
                BoxShadow(
                  color: PortfolioPalette.violet.withValues(alpha: glow),
                  blurRadius: _hovering ? 18 : 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: TextButton.icon(
              style: TextButton.styleFrom(
                backgroundColor: Colors.transparent,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: widget.onPressed,
              icon: const FaIcon(FontAwesomeIcons.robot, size: 15),
              label: const Text(
                UiStrings.navAIShort,
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
              ),
            ),
          ),
        );

        final isDesktop = kIsWeb ||
            defaultTargetPlatform == TargetPlatform.macOS ||
            defaultTargetPlatform == TargetPlatform.windows ||
            defaultTargetPlatform == TargetPlatform.linux;

        if (isDesktop) {
          return MouseRegion(
            onEnter: (_) => setState(() => _hovering = true),
            onExit: (_) => setState(() => _hovering = false),
            cursor: SystemMouseCursors.click,
            child: child,
          );
        }
        return child;
      },
    );
  }
}
