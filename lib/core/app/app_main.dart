import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:thinktank/core/app/app.dart';
import 'package:thinktank/core/app/app_initialization.dart';
import 'package:thinktank/core/providers/api_config_provider.dart';
import '../services/api_service.dart';

class AppMain {
  final ApiService apiService;
  AppMain(App app, {
    required this.apiService,
  });

  final appMainProvider = Provider<AppMain>((ref) {
    return AppMain(
      App(
        ref.read(apiConfigProvider).apiService as AppInitialization,
      ),
      apiService: ref.read(apiConfigProvider).apiService as ApiService,
    );
  });
}