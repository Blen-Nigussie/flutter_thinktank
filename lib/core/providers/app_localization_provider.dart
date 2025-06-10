import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../localization/app_localization.dart';
import 'language_controller_provider.dart';

final appLocalizationProvider = Provider<AppLocalization>((ref) {
  final currentLanguage = ref.watch(languageControllerProvider);
  return AppLocalization(currentLanguage);
}); 