import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../auth/token_manager.dart';
import '../services/api_service.dart';
import '../repositories/user_repository.dart';
import 'network_info_provider.dart';

final apiServiceProvider = Provider<ApiService?>((ref) {
  return ApiService(
    Dio(
      BaseOptions(
        baseUrl: 'https://api.example.com',
        connectTimeout: Duration(seconds: 30),
        receiveTimeout: Duration(seconds: 30),
      ),
    ),
    TokenManager( 
      ref.watch(networkInfoProvider),
    ),
  );
});

final userRepositoryProvider = Provider<UserRepository>((ref) {
  final apiService = ref.watch(apiServiceProvider);
  if (apiService == null) {
    throw Exception('API Service is not available');
  }
  final networkInfo = ref.watch(networkInfoProvider);
  return UserRepository(apiService, networkInfo);
});

