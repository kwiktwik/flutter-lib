import 'package:flutter/material.dart';
import 'colors/colors.dart';
import 'typography/typography.dart';

class KwikTheme {
  static ThemeData getTheme(ThemeVariant variant, Brightness brightness) {
    final tokens = KwikColorTokens.getColors(variant, brightness);
    return ThemeData(
      brightness: brightness,
      primaryColor: tokens.primary,
      scaffoldBackgroundColor: tokens.background,
      cardColor: tokens.surface,
      colorScheme: ColorScheme.fromSeed(
        seedColor: tokens.primary,
        brightness: brightness,
      ),
      textTheme: TextTheme(
        headlineMedium: KwikTypography.heading(brightness),
        bodyMedium: KwikTypography.body(brightness),
        bodySmall: KwikTypography.caption(brightness),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: tokens.primary,
          foregroundColor: brightness == Brightness.light ? Colors.white : Colors.black,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: tokens.surface,
        border: OutlineInputBorder(
          borderSide: BorderSide(color: tokens.primary),
        ),
      ),
    );
  }
}