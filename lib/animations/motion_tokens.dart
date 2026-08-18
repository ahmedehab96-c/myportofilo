import 'package:flutter/material.dart';

/// Shared motion constants for premium portfolio animations.
abstract final class MotionTokens {
  static const Duration entranceDuration = Duration(milliseconds: 650);
  static const Duration entranceStagger = Duration(milliseconds: 85);
  static const Duration hoverDuration = Duration(milliseconds: 280);
  static const Duration tapDuration = Duration(milliseconds: 140);
  static const Duration floatDuration = Duration(milliseconds: 6200);
  static const Duration glowPulseDuration = Duration(milliseconds: 4200);
  static const Duration maxRevealWait = Duration(milliseconds: 2400);

  static const Curve entranceCurve = Curves.easeOutCubic;
  static const Curve hoverCurve = Curves.easeOutQuart;
  static const Curve tapCurve = Curves.fastOutSlowIn;

  static const double entranceScaleBegin = 0.94;
  static const double entranceOffsetY = 25;
  static const double entranceBlurSigma = 6;

  static const double hoverLift = 8;
  static const double hoverScale = 1.02;
  static const double tapScale = 0.97;
  static const double floatAmplitude = 8;

  static const double cardRadius = 20;
  static const double cardRadiusLarge = 22;
}
