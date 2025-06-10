import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../viewmodels/auth_view_model.dart';
import '../theme/theme_controller.dart';
import '../localization/language_controller.dart';

class AppController {
  final AuthViewModel _authViewModel;
  final ThemeController _themeController;
  final LanguageController _languageController;

  AppController(this._authViewModel, this._themeController, this._languageController);

  Future<void> initialize() async {
    await _authViewModel.getCurrentUser();
  }

  void toggleTheme() {
    _themeController.toggleTheme();
  }

  void setLanguage(String languageCode) {
    _languageController.setLanguage(languageCode);
  }
} 