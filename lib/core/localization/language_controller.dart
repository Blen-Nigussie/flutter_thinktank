import 'package:flutter_riverpod/flutter_riverpod.dart';

class LanguageController extends StateNotifier<String> {
  LanguageController() : super('en');

  void setLanguage(String languageCode) {
    state = languageCode;
  }
} 