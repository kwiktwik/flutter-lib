import 'package:flutter/material.dart';

class KwikTypography {
  // Tokens for light/dark text visibility
  static TextStyle heading(Brightness brightness) => TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: brightness == Brightness.light ? Colors.black : Colors.white,
      );

  static TextStyle body(Brightness brightness) => TextStyle(
        fontSize: 16,
        color: brightness == Brightness.light ? Colors.black87 : Colors.white70,
      );

  static TextStyle caption(Brightness brightness) => TextStyle(
        fontSize: 14,
        color: brightness == Brightness.light ? Colors.grey : Colors.grey[400],
      );
}