import 'package:shared_preferences/shared_preferences.dart';
import 'package:thinktank/core/network/network_info.dart';

class TokenManager {
  static const String _tokenKey = 'auth_token';

  TokenManager(NetworkInfo watch);

  Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, token);
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey);
  }

  Future<void> deleteToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
  }
} 