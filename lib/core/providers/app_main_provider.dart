import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../app/app_main.dart';
import 'app_provider.dart';

final appMainProvider = Provider<AppMain>((ref) {
  final app = ref.watch(appProvider);
  return AppMain(app);
}); 