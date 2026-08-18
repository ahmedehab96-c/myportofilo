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

  // Brand accents (shared across modes) — Midnight Navy + Electric Cyan + AI Violet
  static const accent = Color(0xFF22D3EE);
  static const accentBright = Color(0xFF67E8F9);
  static const accentDeep = Color(0xFF0E7490);
  static const violet = Color(0xFF8B5CF6);
  static const violetDeep = Color(0xFF6D28D9);
  static const sky = Color(0xFF38BDF8);
  static const teal = Color(0xFF14B8A6);
  static const gold = Color(0xFFB45309);

  /// Dark navy text for use on bright cyan-filled surfaces (primary buttons).
  static const onAccent = Color(0xFF0B1120);

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
    colors: [accent, accentBright],
  );

  static const aiGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [violet, violetDeep],
  );

  static const photoRingGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [accent, violet, sky],
  );

  static const projectCardRadius = 16.0;
  static const projectImageRadius = 12.0;
  static const projectImagePadding = 10.0;

  /// Beryllium light — soft slate glass on airy white-blue base.
  static const light = PortfolioPalette(
    bgDeep: Color(0xFFF8FAFC),
    bgMid: Color(0xFFF1F5F9),
    bgElevated: Color(0xFFE2E8F0),
    surface: Color(0xCCFFFFFF),
    surfaceRaised: Color(0xE6FFFFFF),
    cardSurface: Color(0xF2FFFFFF),
    imagePlaceholder: Color(0xFFE2E8F0),
    textPrimary: Color(0xFF0F172A),
    textSecondary: Color(0xFF475569),
    textMuted: Color(0xFF64748B),
    borderSubtle: Color(0x1A2563EB),
    borderAccent: Color(0x402563EB),
    borderHover: Color(0x662563EB),
    backgroundGradient: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        Color(0xFFF8FAFC),
        Color(0xFFEFF6FF),
        Color(0xFFF1F5F9),
        Color(0xFFEDE9FE),
        Color(0xFFF8FAFC),
      ],
      stops: [0.0, 0.28, 0.55, 0.78, 1.0],
    ),
    panelShadow: [
      BoxShadow(
        color: Color(0x142563EB),
        blurRadius: 24,
        offset: Offset(0, 8),
      ),
    ],
    cardShadowColor: Color(0x142563EB),
    cardShadowHoverColor: Color(0x332563EB),
    meshBlobAlpha: 0.06,
    isDark: false,
  );

  /// Midnight Navy — premium dark base with electric cyan + AI violet accents.
  static const dark = PortfolioPalette(
    bgDeep: Color(0xFF0B1120),
    bgMid: Color(0xFF111827),
    bgElevated: Color(0xFF141B2E),
    surface: Color(0xCC0F172A),
    surfaceRaised: Color(0xE6172239),
    cardSurface: Color(0xFF0F172A),
    imagePlaceholder: Color(0xFF0C1220),
    textPrimary: Color(0xFFF8FAFC),
    textSecondary: Color(0xFF94A3B8),
    textMuted: Color(0xFF64748B),
    borderSubtle: Color(0xFF1E293B),
    borderAccent: Color(0x5522D3EE),
    borderHover: Color(0xCC22D3EE),
    backgroundGradient: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        Color(0xFF121B2E),
        Color(0xFF0E1524),
        Color(0xFF0B1120),
        Color(0xFF0A0F1C),
        Color(0xFF080C15),
      ],
      stops: [0.0, 0.28, 0.55, 0.78, 1.0],
    ),
    panelShadow: [
      BoxShadow(
        color: Color(0x40000000),
        blurRadius: 20,
        offset: Offset(0, 6),
      ),
    ],
    cardShadowColor: Color(0x59000000),
    cardShadowHoverColor: Color(0x4022D3EE),
    meshBlobAlpha: 0.07,
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
