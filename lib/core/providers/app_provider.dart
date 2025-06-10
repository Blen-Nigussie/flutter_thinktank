import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../app/app.dart';
import '../app/app_initialization.dart';
import 'app_theme_provider.dart';
import 'app_localization_provider.dart';
import 'app_navigation_provider.dart';
import 'auth_view_model_provider.dart';

final appProvider = Provider<App>((ref) {
  final theme = ref.watch(appThemeProvider);
  final localization = ref.watch(appLocalizationProvider);
  final navigation = ref.watch(appNavigationProvider);
  final auth = ref.watch(authViewModelProvider);

  final initialization = AppInitialization(
    theme: theme,
    localization: localization,
    navigation: navigation,
    auth: auth,
  );

  return App(initialization);
}); 