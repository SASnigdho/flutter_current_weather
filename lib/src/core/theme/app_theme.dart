import 'package:flutter/material.dart';

class AppTheme {
  // Define the seed color for generating the color scheme
  static const _seedColor = Colors.blue;

  // Light Color Scheme
  static final _lightColorScheme = ColorScheme.fromSeed(
    seedColor: _seedColor,
    brightness: Brightness.light,
  );

  // Dark Color Scheme
  static final _darkColorScheme = ColorScheme.fromSeed(
    seedColor: _seedColor,
    brightness: Brightness.dark,
  );

  // Light Theme
  static final light = ThemeData(
    useMaterial3: true,
    colorScheme: _lightColorScheme,
    appBarTheme: AppBarTheme(
      backgroundColor: _lightColorScheme.primary,
      foregroundColor: _lightColorScheme.onPrimary,
      elevation: 0,
      centerTitle: true,
    ),
    cardTheme: CardThemeData(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    ),
  );

  // Dark Theme
  static final dark = ThemeData(
    useMaterial3: true,
    colorScheme: _darkColorScheme,
    appBarTheme: AppBarTheme(
      backgroundColor: _darkColorScheme.surface,
      foregroundColor: _darkColorScheme.onSurface,
      elevation: 0,
      centerTitle: true,
    ),
    cardTheme: CardThemeData(
      shadowColor: Colors.white24,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    ),
  );
}
