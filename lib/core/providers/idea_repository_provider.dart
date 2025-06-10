import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../repositories/idea_repository.dart';
import 'api_service_provider.dart';
import 'network_info_provider.dart';

final ideaRepositoryProvider = Provider<IdeaRepository>((ref) {
  final apiService = ref.watch(apiServiceProvider);
  final networkInfo = ref.watch(networkInfoProvider);
  return IdeaRepository(apiService, networkInfo);
}); 