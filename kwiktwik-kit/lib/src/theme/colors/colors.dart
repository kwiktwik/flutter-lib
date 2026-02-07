import 'package:flutter/material.dart';

enum ThemeVariant {
  blue,
  green,
  red,
  purple,
  orange,
  teal,
  pink,
}

class KwikColorTokens {
  // Base tokens per variant (light)
  static Map<ThemeVariant, Color> getPrimaryLight(ThemeVariant variant) => {
        ThemeVariant.blue: const Color(0xFF2196F3),
        ThemeVariant.green: const Color(0xFF4CAF50),
        ThemeVariant.red: const Color(0xFFF44336),
        ThemeVariant.purple: const Color(0xFF9C27B0),
        ThemeVariant.orange: const Color(0xFFFF9800),
        ThemeVariant.teal: const Color(0xFF009688),
        ThemeVariant.pink: const Color(0xFFE91E63),
      };

  static Map<ThemeVariant, Color> getSecondaryLight(ThemeVariant variant) => {
        ThemeVariant.blue: const Color(0xFF03A9F4),
        ThemeVariant.green: const Color(0xFF8BC34A),
        ThemeVariant.red: const Color(0xFFEF5350),
        ThemeVariant.purple: const Color(0xFFBA68C8),
        ThemeVariant.orange: const Color(0xFFFFB74D),
        ThemeVariant.teal: const Color(0xFF4DB6AC),
        ThemeVariant.pink: const Color(0xFFF06292),
      };

  // Dark variants derived from light
  // ignore: deprecated_member_use
  static Color getPrimaryDark(ThemeVariant variant) => getPrimaryLight(variant)[variant]!.withOpacity(0.8);
  // ignore: deprecated_member_use
  static Color getSecondaryDark(ThemeVariant variant) => getSecondaryLight(variant)[variant]!.withOpacity(0.8);

  static const Color backgroundLight = Colors.white;
  static const Color surfaceLight = Color(0xFFF5F5F5);
  static const Color textPrimaryLight = Colors.black;
  static const Color textSecondaryLight = Colors.grey;

  static const Color backgroundDark = Color(0xFF121212);
  static const Color surfaceDark = Color(0xFF1E1E1E);
  static const Color textPrimaryDark = Colors.white;
  static const Color textSecondaryDark = Colors.grey;

  // Get tokens based on variant and brightness (7+ themes supported)
  static KwikColors getColors(ThemeVariant variant, Brightness brightness) {
    final primary = brightness == Brightness.light
        ? getPrimaryLight(variant)[variant]!
        : getPrimaryDark(variant);
    final secondary = brightness == Brightness.light
        ? getSecondaryLight(variant)[variant]!
        : getSecondaryDark(variant);
    return brightness == Brightness.light
        ? KwikColors(
            primary: primary,
            secondary: secondary,
            background: backgroundLight,
            surface: surfaceLight,
            textPrimary: textPrimaryLight,
            textSecondary: textSecondaryLight,
          )
        : KwikColors(
            primary: primary,
            secondary: secondary,
            background: backgroundDark,
            surface: surfaceDark,
            textPrimary: textPrimaryDark,
            textSecondary: textSecondaryDark,
          );
  }
}

class KwikColors {
  final Color primary;
  final Color secondary;
  final Color background;
  final Color surface;
  final Color textPrimary;
  final Color textSecondary;

  const KwikColors({
    required this.primary,
    required this.secondary,
    required this.background,
    required this.surface,
    required this.textPrimary,
    required this.textSecondary,
  });
}