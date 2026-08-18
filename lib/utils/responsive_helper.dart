import 'package:flutter/material.dart';

/// Shared breakpoints and adaptive sizing for the portfolio.
///
/// Mobile &lt; 600 · Tablet 600–1024 · Desktop &gt; 1024
class ResponsiveHelper {
  ResponsiveHelper._(this.width, this.height);

  factory ResponsiveHelper.of(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return ResponsiveHelper._(size.width, size.height);
  }

  factory ResponsiveHelper.fromWidth(double width, [double height = 800]) {
    return ResponsiveHelper._(width, height);
  }

  final double width;
  final double height;

  static const double mobileMax = 600;
  static const double tabletMax = 1024;

  bool get isMobile => width < mobileMax;
  bool get isTablet => width >= mobileMax && width <= tabletMax;
  bool get isDesktop => width > tabletMax;

  /// Compact phone / SE-class widths.
  bool get isCompact => width < 400;

  /// Landscape-ish when width exceeds height.
  bool get isLandscape => width > height;

  double get screenWidth => width;
  double get screenHeight => height;

  /// Page / section horizontal padding.
  double get adaptivePadding {
    if (isMobile) return isCompact ? 12 : 16;
    if (isTablet) return 20;
    return 28;
  }

  /// Vertical gap between major blocks.
  double get adaptiveSpacing {
    if (isMobile) return 12;
    if (isTablet) return 16;
    return 24;
  }

  /// Scale a base font size for the current breakpoint.
  double adaptiveFont(double base) {
    if (isCompact) return base * 0.9;
    if (isMobile) return base;
    if (isTablet) return base * 1.05;
    return base * 1.1;
  }

  /// Max cross-axis extent for responsive grids (prefer over fixed column count).
  double get adaptiveGridMaxExtent {
    if (isMobile) return 360;
    if (isTablet) return 320;
    return 300;
  }

  int get gridColumns {
    if (width < 520) return 1;
    if (width < 900) return 2;
    if (width < 1280) return 3;
    return 4;
  }

  /// Content max width for readable sections on ultra-wide screens.
  double get contentMaxWidth {
    if (isMobile) return width;
    if (isTablet) return 900;
    return 1100;
  }

  /// Use drawer / compact top nav instead of sticky desktop nav.
  bool get useDrawerNav => width < tabletMax;

  /// Two-column detail layouts (project details, contact, etc.).
  bool get isWideLayout => width >= 960;
}
