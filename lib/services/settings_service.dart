import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsService {
  static const _keyPalette = 'settings_palette';
  static const _keyThemeMode = 'settings_theme_mode';
  static const _keyLocale = 'settings_locale';

  static Future<void> savePalette(String paletteId) async {
    final p = await SharedPreferences.getInstance();
    await p.setString(_keyPalette, paletteId);
  }

  static Future<String?> loadPalette() async {
    final p = await SharedPreferences.getInstance();
    return p.getString(_keyPalette);
  }

  static Future<void> saveThemeMode(ThemeMode mode) async {
    final p = await SharedPreferences.getInstance();
    await p.setString(_keyThemeMode, mode.name);
  }

  static Future<ThemeMode> loadThemeMode() async {
    final p = await SharedPreferences.getInstance();
    final name = p.getString(_keyThemeMode);
    return ThemeMode.values.firstWhere((m) => m.name == name, orElse: () => ThemeMode.system);
  }

  static Future<void> saveLocale(Locale? locale) async {
    final p = await SharedPreferences.getInstance();
    if (locale == null) {
      await p.remove(_keyLocale);
    } else {
      await p.setString(_keyLocale, locale.languageCode);
    }
  }

  static Future<Locale?> loadLocale() async {
    final p = await SharedPreferences.getInstance();
    final code = p.getString(_keyLocale);
    return code != null ? Locale(code) : null;
  }
}
