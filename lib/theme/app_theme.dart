import 'package:flutter/material.dart';
import '../models/topic.dart';
import 'app_palette.dart';

class AppTheme {
  static ThemeData light({required AppPalette palette}) {
    final scheme = palette.scheme(Brightness.light);
    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      appBarTheme: const AppBarTheme(
        centerTitle: false,
        scrolledUnderElevation: 2,
      ),
      cardTheme: CardThemeData(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: scheme.outlineVariant.withValues(alpha: 0.5)),
        ),
      ),
      chipTheme: ChipThemeData(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  static ThemeData dark({required AppPalette palette}) {
    final scheme = palette.scheme(Brightness.dark);
    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      appBarTheme: const AppBarTheme(
        centerTitle: false,
        scrolledUnderElevation: 2,
      ),
      cardTheme: CardThemeData(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: scheme.outlineVariant.withValues(alpha: 0.4)),
        ),
      ),
      chipTheme: ChipThemeData(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  // Difficulty colours (fixed, palette-independent)
  static Color difficultyColor(DifficultyLevel? difficulty, BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return switch (difficulty.toString().split('.').last) {
      'beginner'     => isDark ? const Color(0xFF4CAF50) : const Color(0xFF2E7D32),
      'intermediate' => isDark ? const Color(0xFFFF9800) : const Color(0xFFE65100),
      'advanced'     => isDark ? const Color(0xFFEF5350) : const Color(0xFFB71C1C),
      _              => Colors.grey,
    };
  }

  // Code block colours (fixed, palette-independent)
  static Color get codeBackground => const Color(0xFF1E1E2E);
  static Color get codeForeground => const Color(0xFFCDD6F4);
  static Color get codeComment    => const Color(0xFF6C7086);
  static Color get codeKeyword    => const Color(0xFF89DCEB);
  static Color get codeString     => const Color(0xFFA6E3A1);
  static Color get codeNumber     => const Color(0xFFFAB387);
}
