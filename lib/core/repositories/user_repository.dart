import '../services/api_service.dart';
import '../network/network_info.dart';
import '../models/user.dart';

class UserRepository {
  final ApiService _apiService;
  final NetworkInfo _networkInfo;

  UserRepository(this._apiService, this._networkInfo);

  Future<User> login(String email, String password) async {
    if (await _networkInfo.isConnected) {
      return await _apiService.login(email, password);
    } else {
      throw Exception('No internet connection');
    }
  }

  Future<User> register(String name, String email, String password) async {
    if (await _networkInfo.isConnected) {
      return await _apiService.register(name, email, password);
    } else {
      throw Exception('No internet connection');
    }
  }

  Future<void> logout() async {
    if (await _networkInfo.isConnected) {
      await _apiService.logout();
    } else {
      throw Exception('No internet connection');
    }
  }

  Future<User> getCurrentUser() async {
    if (await _networkInfo.isConnected) {
      return await _apiService.getCurrentUser();
    } else {
      throw Exception('No internet connection');
    }
  }
} 