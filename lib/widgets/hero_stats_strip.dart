import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../theme/portfolio_palette.dart';
import 'section_block.dart';

/// Horizontal hero stats card with staggered entrance and hover polish.
class HeroStatsStrip extends StatelessWidget {
  const HeroStatsStrip({
    super.key,
    required this.items,
  });

  final List<({String value, String label, IconData icon})> items;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final isSmall = MediaQuery.sizeOf(context).width < 600;

    return revealItem(
      DecoratedBox(
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
          boxShadow: [
            ...p.panelShadow,
            BoxShadow(
              color: PortfolioPalette.accent.withValues(alpha: p.isDark ? 0.12 : 0.08),
              blurRadius: 28,
              offset: const Offset(0, 10),
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
                          margin: EdgeInsets.symmetric(horizontal: isSmall ? 8 : 14),
                          color: p.borderSubtle,
                        ),
                      if (isSmall)
                        Expanded(
                          child: _StatCell(
                            value: items[i].value,
                            label: items[i].label,
                            icon: items[i].icon,
                            delay: Duration(milliseconds: 90 * i),
                          ),
                        )
                      else
                        _StatCell(
                          value: items[i].value,
                          label: items[i].label,
                          icon: items[i].icon,
                          delay: Duration(milliseconds: 90 * i),
                        ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      delay: const Duration(milliseconds: 170),
    );
  }
}

class _StatCell extends StatefulWidget {
  const _StatCell({
    required this.value,
    required this.label,
    required this.icon,
    required this.delay,
  });

  final String value;
  final String label;
  final IconData icon;
  final Duration delay;

  @override
  State<_StatCell> createState() => _StatCellState();
}

class _StatCellState extends State<_StatCell> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final isSmall = MediaQuery.sizeOf(context).width < 600;

    return revealItem(
      MouseRegion(
        onEnter: (_) => setState(() => _hovering = true),
        onExit: (_) => setState(() => _hovering = false),
        child: AnimatedScale(
          scale: _hovering ? 1.04 : 1,
          duration: const Duration(milliseconds: 220),
          curve: Curves.easeOutCubic,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 220),
            curve: Curves.easeOutCubic,
            padding: EdgeInsets.symmetric(
              horizontal: isSmall ? 6 : 10,
              vertical: isSmall ? 4 : 6,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: _hovering
                  ? PortfolioPalette.accent.withValues(alpha: p.isDark ? 0.14 : 0.08)
                  : Colors.transparent,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                FaIcon(
                  widget.icon,
                  size: isSmall ? 14 : 16,
                  color: PortfolioPalette.accent.withValues(alpha: _hovering ? 1 : 0.75),
                ),
                SizedBox(height: isSmall ? 6 : 8),
                ShaderMask(
                  shaderCallback: (bounds) =>
                      PortfolioPalette.accentGradientHorizontal.createShader(bounds),
                  child: Text(
                    widget.value,
                    style: TextStyle(
                      fontSize: isSmall ? 22 : 28,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                      letterSpacing: 0.5,
                      height: 1,
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  widget.label,
                  textAlign: TextAlign.center,
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
      ),
      delay: widget.delay,
      from: 12,
    );
  }
}
