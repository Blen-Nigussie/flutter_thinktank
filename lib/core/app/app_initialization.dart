import 'package:flutter/material.dart';
import '../providers/app_theme_provider.dart';
import '../providers/app_localization_provider.dart';
import '../providers/app_navigation_provider.dart';
import '../providers/auth_view_model_provider.dart';

class AppInitialization {
  final AppTheme theme;
  final AppLocalization localization;
  final AppNavigation navigation;
  final AuthState auth;

  AppInitialization({
    required this.theme,
    required this.localization,
    required this.navigation,
    required this.auth,
  });
} 