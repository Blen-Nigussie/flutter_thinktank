import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../localization/language_controller.dart';

final languageControllerProvider = StateNotifierProvider<LanguageController, String>((ref) {
  return LanguageController();
}); 