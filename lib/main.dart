import 'package:dart_tutor/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'core/app_lang.dart';
import 'screens/home_screen.dart';
import 'services/settings_service.dart';
import 'theme/app_palette.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(const DartTutorApp());
}

class DartTutorApp extends StatefulWidget {
  const DartTutorApp({super.key});

  @override
  State<DartTutorApp> createState() => _DartTutorAppState();
}

class _DartTutorAppState extends State<DartTutorApp> {
  ThemeMode _themeMode = ThemeMode.system;
  Locale? _locale;
  AppPalette _palette = kPalettes.first;
  bool _loaded = false;

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final themeMode = await SettingsService.loadThemeMode();
    final locale = await SettingsService.loadLocale();
    final paletteId = await SettingsService.loadPalette();
    setState(() {
      _themeMode = themeMode;
      _locale = locale;
      _palette = paletteId != null ? paletteById(paletteId) : kPalettes.first;
      _loaded = true;
    });
  }

  void _setThemeMode(ThemeMode mode) {
    setState(() => _themeMode = mode);
    SettingsService.saveThemeMode(mode);
  }

  void _setLocale(Locale? locale) {
    setState(() => _locale = locale);
    SettingsService.saveLocale(locale);
  }

  void _setPalette(AppPalette palette) {
    setState(() => _palette = palette);
    SettingsService.savePalette(palette.id);
  }

  @override
  Widget build(BuildContext context) {
    if (!_loaded) return const SizedBox.shrink();

    return MaterialApp(
      title: 'Dart Tutor',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(seed: _palette.seed),
      darkTheme: AppTheme.dark(seed: _palette.seed),
      themeMode: _themeMode,
      locale: _locale,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('en'), Locale('es')],
      builder: (context, child) {
        AppLang.init(context);
        return child!;
      },
      home: HomeScreen(
        themeMode: _themeMode,
        locale: _locale,
        palette: _palette,
        onSetThemeMode: _setThemeMode,
        onSetLocale: _setLocale,
        onSetPalette: _setPalette,
      ),
    );
  }
}
