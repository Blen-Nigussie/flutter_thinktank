import 'package:flutter_riverpod/flutter_riverpod.dart';

class ThemeController extends StateNotifier<bool> {
  ThemeController() : super(false);

  void toggleTheme() {
    state = !state;
  }
} 