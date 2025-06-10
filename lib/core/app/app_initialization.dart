import '../auth/auth_ui_state.dart';

// Define AppTheme if it does not exist
class AppTheme {
  // Placeholder for theme properties
  // You can add properties like primaryColor, accentColor, etc.
  final String primaryColor;

  AppTheme({required this.primaryColor});
}

// Define AppLocalization if it does not exist
class AppLocalization {
  // Placeholder for localization properties
  // You can add properties like supportedLanguages, currentLanguage, etc.
  final List<String> supportedLanguages;
  final String currentLanguage;

  AppLocalization({
    required this.supportedLanguages,
    required this.currentLanguage,
  });
}

// Define AppNavigation if it does not exist
class AppNavigation {
  // Placeholder for navigation properties
  // You can add properties like routes, initialRoute, etc.
  final String initialRoute;

  AppNavigation({required this.initialRoute});
}

class AppInitialization {
  final AppTheme theme;
  final AppLocalization localization;
  final AppNavigation navigation;
  final AuthUiState auth;

  AppInitialization({
    required this.theme,
    required this.localization,
    required this.navigation,
    required this.auth,
  });
} 