import 'package:shared_preferences.dart';

class TokenManager {
  static const String _prefsName = 'ThinkTankPrefs';
  static const String _keyToken = 'auth_token';
  
  final SharedPreferences _prefs;

  TokenManager(this._prefs);

  Future<void> saveToken(String token) async {
    await _prefs.setString(_keyToken, token);
  }

  String? getToken() {
    return _prefs.getString(_keyToken);
  }

  Future<void> clearToken() async {
    await _prefs.remove(_keyToken);
  }

  // Factory constructor to create a TokenManager instance
  static Future<TokenManager> create() async {
    final prefs = await SharedPreferences.getInstance();
    return TokenManager(prefs);
  }
} 