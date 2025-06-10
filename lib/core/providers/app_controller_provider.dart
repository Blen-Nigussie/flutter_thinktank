import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../app/app_controller.dart';
import 'auth_view_model_provider.dart';
import 'theme_controller_provider.dart';
import 'language_controller_provider.dart';

final appControllerProvider = Provider<AppController>((ref) {
  final authViewModel = ref.watch(authViewModelProvider.notifier);
  final themeController = ref.watch(themeControllerProvider.notifier);
  final languageController = ref.watch(languageControllerProvider.notifier);
  return AppController(authViewModel, themeController, languageController);
}); 