import 'package:flutter/material.dart';
import 'fa_shim.dart';

import '../animations/motion_tokens.dart';
import '../theme/portfolio_palette.dart';
import '../utils/responsive_helper.dart';
import 'motion/animated_stat_value.dart';
import 'motion/premium_hover_card.dart';

/// Horizontal hero stats card with staggered entrance and hover polish.
class HeroStatsStrip extends StatelessWidget {
  const HeroStatsStrip({
    super.key,
    required this.items,
    this.scrollController,
  });

  final List<({String value, String label, FaIconData icon})> items;
  final ScrollController? scrollController;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final isSmall = ResponsiveHelper.of(context).isMobile;

    return PremiumHoverCard(
      floating: true,
      shellGlow: true,
      enableGlowPulse: true,
      scrollController: scrollController,
      entranceDelay: const Duration(milliseconds: 170),
      borderRadius: 18,
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              p.surface,
              p.cardSurface,
            ],
          ),
          border: Border.all(color: p.borderAccent, width: 1.2),
          boxShadow: p.panelShadow,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(18),
          child: Stack(
            children: [
              const Positioned(
                left: 0,
                right: 0,
                top: 0,
                height: 3,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: PortfolioPalette.accentGradient,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: isSmall ? 12 : 20,
                  vertical: isSmall ? 14 : 18,
                ),
                child: Row(
                  mainAxisSize: isSmall ? MainAxisSize.max : MainAxisSize.min,
                  children: [
                    for (var i = 0; i < items.length; i++) ...[
                      if (i > 0)
                        Container(
                          width: 1,
                          height: isSmall ? 36 : 44,
                          margin:
                              EdgeInsets.symmetric(horizontal: isSmall ? 8 : 14),
                          color: p.borderSubtle,
                        ),
                      if (isSmall)
                        Expanded(
                          child: _StatCell(
                            value: items[i].value,
                            label: items[i].label,
                            icon: items[i].icon,
                            delay: Duration(milliseconds: 90 * i),
                            scrollController: scrollController,
                          ),
                        )
                      else
                        _StatCell(
                          value: items[i].value,
                          label: items[i].label,
                          icon: items[i].icon,
                          delay: Duration(milliseconds: 90 * i),
                          scrollController: scrollController,
                        ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatCell extends StatefulWidget {
  const _StatCell({
    required this.value,
    required this.label,
    required this.icon,
    required this.delay,
    this.scrollController,
  });

  final String value;
  final String label;
  final FaIconData icon;
  final Duration delay;
  final ScrollController? scrollController;

  @override
  State<_StatCell> createState() => _StatCellState();
}

class _StatCellState extends State<_StatCell> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final isSmall = ResponsiveHelper.of(context).isMobile;

    return MouseRegion(
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      child: AnimatedScale(
          scale: _hovering ? 1.05 : 1,
          duration: MotionTokens.hoverDuration,
          curve: MotionTokens.hoverCurve,
          child: AnimatedContainer(
            duration: MotionTokens.hoverDuration,
            curve: MotionTokens.hoverCurve,
            padding: EdgeInsets.symmetric(
              horizontal: isSmall ? 6 : 10,
              vertical: isSmall ? 4 : 6,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: _hovering
                  ? PortfolioPalette.accent
                      .withValues(alpha: p.isDark ? 0.14 : 0.08)
                  : Colors.transparent,
              boxShadow: _hovering
                  ? [
                      BoxShadow(
                        color: PortfolioPalette.accent.withValues(alpha: 0.2),
                        blurRadius: 14,
                        offset: const Offset(0, 4),
                      ),
                    ]
                  : null,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AnimatedRotation(
                  turns: _hovering ? 0.02 : 0,
                  duration: MotionTokens.hoverDuration,
                  curve: MotionTokens.hoverCurve,
                  child: FaIcon(
                    widget.icon,
                    size: isSmall ? 14 : 16,
                    color: PortfolioPalette.accent
                        .withValues(alpha: _hovering ? 1 : 0.75),
                  ),
                ),
                SizedBox(height: isSmall ? 6 : 8),
                AnimatedStatValue(
                  value: widget.value,
                  style: TextStyle(
                    fontSize: isSmall ? 20 : 28,
                    fontWeight: FontWeight.w800,
                    color: PortfolioPalette.accentBright,
                    letterSpacing: 0.5,
                    height: 1,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  widget.label,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: isSmall ? 10 : 12,
                    color: p.textMuted,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.4,
                  ),
                ),
              ],
            ),
          ),
        ),
    );
  }
}
