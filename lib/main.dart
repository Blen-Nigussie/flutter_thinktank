import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/providers/app_main_provider.dart';

void main() {
  runApp(
    ProviderScope(
      child: Consumer(
        builder: (context, ref, child) {
          final appMain = ref.watch(appMainProvider);
          return appMain;
        },
      ),
    ),
  );
}
