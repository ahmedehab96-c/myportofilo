import 'package:flutter/material.dart';

/// Semantic colors + decorations for one brightness mode.
@immutable
class PortfolioPalette extends ThemeExtension<PortfolioPalette> {
  const PortfolioPalette({
    required this.bgDeep,
    required this.bgMid,
    required this.bgElevated,
    required this.surface,
    required this.surfaceRaised,
    required this.cardSurface,
    required this.imagePlaceholder,
    required this.textPrimary,
    required this.textSecondary,
    required this.textMuted,
    required this.borderSubtle,
    required this.borderAccent,
    required this.borderHover,
    required this.backgroundGradient,
    required this.panelShadow,
    required this.cardShadowColor,
    required this.cardShadowHoverColor,
    required this.meshBlobAlpha,
    required this.isDark,
  });

  final Color bgDeep;
  final Color bgMid;
  final Color bgElevated;
  final Color surface;
  final Color surfaceRaised;
  final Color cardSurface;
  final Color imagePlaceholder;
  final Color textPrimary;
  final Color textSecondary;
  final Color textMuted;
  final Color borderSubtle;
  final Color borderAccent;
  final Color borderHover;
  final LinearGradient backgroundGradient;
  final List<BoxShadow> panelShadow;
  final Color cardShadowColor;
  final Color cardShadowHoverColor;
  final double meshBlobAlpha;
  final bool isDark;

  // Brand accents (shared across modes)
  static const accent = Color(0xFF2563EB);
  static const accentBright = Color(0xFF3B82F6);
  static const accentDeep = Color(0xFF1D4ED8);
  static const violet = Color(0xFF6366F1);
  static const violetDeep = Color(0xFF4F46E5);
  static const sky = Color(0xFF0EA5E9);
  static const teal = Color(0xFF14B8A6);
  static const gold = Color(0xFFB45309);

  static const accentGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [accent, violet],
  );

  static const accentGradientHorizontal = LinearGradient(
    colors: [accent, sky],
  );

  static const ctaGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [accent, accentDeep],
  );

  static const aiGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [violet, violetDeep, accent],
  );

  static const photoRingGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [accent, violet, sky],
  );

  static const projectCardRadius = 16.0;
  static const projectImageRadius = 12.0;
  static const projectImagePadding = 10.0;

  /// Soft blue-gray light — calm, not harsh white.
  static const light = PortfolioPalette(
    bgDeep: Color(0xFFE4E9F2),
    bgMid: Color(0xFFDCE3EE),
    bgElevated: Color(0xFFD4DCE9),
    surface: Color(0xFFEEF2F8),
    surfaceRaised: Color(0xFFE8EDF5),
    cardSurface: Color(0xFFF0F4FA),
    imagePlaceholder: Color(0xFFD8E0EC),
    textPrimary: Color(0xFF1E293B),
    textSecondary: Color(0xFF475569),
    textMuted: Color(0xFF64748B),
    borderSubtle: Color(0xFFC5D0E0),
    borderAccent: Color(0x592563EB),
    borderHover: Color(0x8C2563EB),
    backgroundGradient: LinearGradient(
      begin: Alignment(-0.15, -1),
      end: Alignment(0.85, 1.15),
      colors: [
        Color(0xFFE4E9F2),
        Color(0xFFDCE3EE),
        Color(0xFFD6E0EF),
        Color(0xFFE2E8F0),
      ],
      stops: [0.0, 0.35, 0.7, 1.0],
    ),
    panelShadow: [
      BoxShadow(
        color: Color(0x0F0F172A),
        blurRadius: 18,
        offset: Offset(0, 5),
      ),
    ],
    cardShadowColor: Color(0x0F0F172A),
    cardShadowHoverColor: Color(0x242563EB),
    meshBlobAlpha: 0.04,
    isDark: false,
  );

  static const dark = PortfolioPalette(
    bgDeep: Color(0xFF060B14),
    bgMid: Color(0xFF0A1120),
    bgElevated: Color(0xFF0F172A),
    surface: Color(0xFF131C2E),
    surfaceRaised: Color(0xFF1A2540),
    cardSurface: Color(0xFF182338),
    imagePlaceholder: Color(0xFF0E1628),
    textPrimary: Color(0xFFF1F5F9),
    textSecondary: Color(0xFF94A3B8),
    textMuted: Color(0xFF64748B),
    borderSubtle: Color(0x12FFFFFF),
    borderAccent: Color(0x474F8CFF),
    borderHover: Color(0x734F8CFF),
    backgroundGradient: LinearGradient(
      begin: Alignment(-0.15, -1),
      end: Alignment(0.85, 1.15),
      colors: [
        Color(0xFF060B14),
        Color(0xFF0A1120),
        Color(0xFF0D1528),
        Color(0xFF080E1C),
      ],
      stops: [0.0, 0.38, 0.72, 1.0],
    ),
    panelShadow: [
      BoxShadow(
        color: Color(0x40000000),
        blurRadius: 20,
        offset: Offset(0, 6),
      ),
    ],
    cardShadowColor: Color(0x59000000),
    cardShadowHoverColor: Color(0x294F8CFF),
    meshBlobAlpha: 0.05,
    isDark: true,
  );

  List<BoxShadow> accentGlow({double alpha = 0.22, double blur = 20}) => [
        BoxShadow(
          color: accent.withValues(alpha: alpha),
          blurRadius: blur,
          offset: const Offset(0, 6),
        ),
      ];

  List<BoxShadow> cardShadow({bool hovered = false}) => [
        BoxShadow(
          color: hovered ? cardShadowHoverColor : cardShadowColor,
          blurRadius: hovered ? 22 : 12,
          offset: Offset(0, hovered ? 8 : 4),
        ),
      ];

  BoxDecoration projectCard({bool hovered = false, bool featured = false}) =>
      BoxDecoration(
        color: cardSurface,
        borderRadius: BorderRadius.circular(projectCardRadius),
        border: Border.all(
          color: hovered
              ? borderHover
              : featured
                  ? gold.withValues(alpha: 0.4)
                  : borderSubtle,
          width: featured ? 1.5 : 1,
        ),
        boxShadow: cardShadow(hovered: hovered),
      );

  BoxDecoration get sectionAccentBar => const BoxDecoration(
        gradient: accentGradient,
        borderRadius: BorderRadius.all(Radius.circular(2)),
      );

  @override
  PortfolioPalette copyWith({
    Color? bgDeep,
    Color? bgMid,
    bool? isDark,
  }) {
    return isDark == true ? dark : (isDark == false ? light : this);
  }

  @override
  PortfolioPalette lerp(ThemeExtension<PortfolioPalette>? other, double t) {
    if (other is! PortfolioPalette) return this;
    if (t < 0.5) return this;
    return other;
  }
}

extension PortfolioContext on BuildContext {
  PortfolioPalette get palette =>
      Theme.of(this).extension<PortfolioPalette>() ?? PortfolioPalette.dark;
}
