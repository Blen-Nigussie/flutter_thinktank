import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../theme/app_theme.dart';
import 'theme_controller_provider.dart';

final appThemeProvider = Provider<AppTheme>((ref) {
  final isDarkMode = ref.watch(themeControllerProvider);
  return AppTheme(isDarkMode);
}); 