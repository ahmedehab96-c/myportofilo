import 'package:flutter/material.dart';

import '../../animations/motion_accessibility.dart';
import '../../animations/motion_tokens.dart';

/// Parses values like `3+`, `95%`, `12,540` and animates the numeric portion.
class AnimatedStatValue extends StatelessWidget {
  const AnimatedStatValue({
    super.key,
    required this.value,
    required this.style,
    this.duration = const Duration(milliseconds: 900),
    this.curve = MotionTokens.entranceCurve,
  });

  final String value;
  final TextStyle style;
  final Duration duration;
  final Curve curve;

  static _ParsedStat _parse(String raw) {
    final trimmed = raw.trim();
    final match = RegExp(r'^([\d,]+(?:\.\d+)?)(.*)$').firstMatch(trimmed);
    if (match == null) {
      return _ParsedStat(text: trimmed);
    }
    final numberPart = match.group(1)!.replaceAll(',', '');
    final suffix = match.group(2) ?? '';
    final target = double.tryParse(numberPart);
    if (target == null) {
      return _ParsedStat(text: trimmed);
    }
    return _ParsedStat(target: target, suffix: suffix, hasCommas: raw.contains(','));
  }

  static String _format(double n, {required bool hasCommas, required String suffix}) {
    final rounded = n.round();
    final body = hasCommas
        ? _withCommas(rounded)
        : (suffix.contains('.') ? n.toStringAsFixed(1) : '$rounded');
    return '$body$suffix';
  }

  static String _withCommas(int n) {
    final s = n.toString();
    final buf = StringBuffer();
    for (var i = 0; i < s.length; i++) {
      final fromEnd = s.length - i;
      buf.write(s[i]);
      if (fromEnd > 1 && fromEnd % 3 == 1) buf.write(',');
    }
    return buf.toString();
  }

  @override
  Widget build(BuildContext context) {
    final parsed = _parse(value);
    if (parsed.target == null || MotionAccessibility.shouldReduceMotion(context)) {
      return Text(value, style: style);
    }

    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: parsed.target),
      duration: duration,
      curve: curve,
      builder: (context, n, _) {
        return Text(
          _format(n, hasCommas: parsed.hasCommas, suffix: parsed.suffix),
          style: style,
        );
      },
    );
  }
}

class _ParsedStat {
  const _ParsedStat({
    this.target,
    this.suffix = '',
    this.hasCommas = false,
    this.text,
  });

  final double? target;
  final String suffix;
  final bool hasCommas;
  final String? text;
}
