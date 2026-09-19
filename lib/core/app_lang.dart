import 'package:dart_tutor/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class AppLang {
  static AppLocalizations? _instance;
  static Locale? _locale;

  static void init(BuildContext context) {
    _instance = AppLocalizations.of(context);
    _locale = Localizations.localeOf(context);
  }

  static AppLocalizations get l10n => _instance!;

  static Locale get locale => _locale ?? const Locale('es');

  static String get code => _locale?.languageCode ?? 'es';
}
