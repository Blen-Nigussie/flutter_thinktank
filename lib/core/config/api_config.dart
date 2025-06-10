class ApiConfig {
  // For Android Emulator, use 10.0.2.2 to access localhost
  // For iOS Simulator, use localhost
  // For physical device, use your computer's IP address
  static const String baseUrl = 'http://10.0.2.2:3444/'; // Default for Android Emulator
  
  // API Endpoints
  static const String auth = 'auth';
  static const String ideas = 'ideas';
  static const String users = 'users';
  static const String feedback = 'feedback';
  static const String profiles = 'profiles';

  // Timeouts
  static const int connectTimeout = 30000; // 30 seconds
  static const int receiveTimeout = 30000; // 30 seconds
  static const int sendTimeout = 30000; // 30 seconds

  // Headers
  static const Map<String, String> defaultHeaders = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };
} 