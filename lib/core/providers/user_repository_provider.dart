import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../repositories/user_repository.dart';
import 'api_service_provider.dart';
import 'network_info_provider.dart';

final userRepositoryProvider = Provider<UserRepository>((ref) {
  final apiService = ref.watch(apiServiceProvider);
  final networkInfo = ref.watch(networkInfoProvider);
  return UserRepository(apiService, networkInfo);
}); 