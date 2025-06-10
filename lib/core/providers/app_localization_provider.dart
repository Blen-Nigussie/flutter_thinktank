import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'language_controller_provider.dart';

final appLocalizationProvider = Provider<AppLocalization>((ref) {
  final currentLanguage = ref.watch(languageControllerProvider);
  // Assuming currentLanguage is a language code like 'en' or 'en_US'
  Locale? locale;
  if (currentLanguage.contains('_')) {
    final parts = currentLanguage.split('_');
    locale = Locale(parts[0], parts[1]);
  } else if (currentLanguage.isNotEmpty) {
    locale = Locale(currentLanguage);
  } else {
    locale = null;
  }
  return AppLocalization(locale);
});

class AppLocalization extends ChangeNotifier {
  Locale? _locale;

  AppLocalization(this._locale);

  Locale? get locale => _locale;

  set locale(Locale? locale) {
    _locale = locale;
    notifyListeners();
  }
  List<LocalizationsDelegate<dynamic>> get delegates => [
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    AppLocalization(_locale), // Custom delegate for your app
    
    ];

  List<Locale> get supportedLocales => [
    Locale('en', ''), // English
    Locale('es', ''), // Spanish
    Locale('fr', ''), // French
    Locale('de', ''), // German
    // Add other supported locales here
  ];
  Locale? localeListResolutionCallback(
      List<Locale>? locales, Iterable<Locale> supportedLocales) {
    if (locales == null || locales.isEmpty) return null;
    for (var locale in locales) {
      if (supportedLocales.contains(locale)) return locale;
    }
    return supportedLocales.first;
  }
}