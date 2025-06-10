import 'package:flutter/material.dart';

class AppLocalization {
  final String currentLanguage;

  AppLocalization(this.currentLanguage);

  Locale get locale {
    return Locale(currentLanguage);
  }

  static const Map<String, Map<String, String>> _localizedValues = {
    'en': {
      'login': 'Login',
      'register': 'Register',
      'ideas': 'Ideas',
      'feedback': 'Feedback',
      'profile': 'Profile',
    },
    'es': {
      'login': 'Iniciar Sesión',
      'register': 'Registrarse',
      'ideas': 'Ideas',
      'feedback': 'Comentarios',
      'profile': 'Perfil',
    },
    'fr': {
      'login': 'Connexion',
      'register': 'S’inscrire',
      'ideas': 'Idées',
      'feedback': 'Retour d’information',
      'profile': 'Profil',
    },
    // Add more languages here
    'de': {
      'login': 'Anmelden',
      'register': 'Registrieren',
      'ideas': 'Ideen',
      'feedback': 'Feedback',
      'profile': 'Profil',
    },
  };

  String get(String key) {
    return _localizedValues[currentLanguage]?[key] ?? key;
  }
} 