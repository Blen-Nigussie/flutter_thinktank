import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../theme/theme_controller.dart';

final themeControllerProvider = StateNotifierProvider<ThemeController, bool>((ref) {
  return ThemeController();
}); 