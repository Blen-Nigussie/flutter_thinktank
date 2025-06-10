import 'package:dio/dio.dart';
import '../models/auth_response.dart';
import '../models/login_request.dart';
import '../models/register_request.dart';

class AuthApi {
  final Dio _dio;

  AuthApi(this._dio);

  Future<AuthResponse> registerUser(RegisterRequest request) async {
    final response = await _dio.post(
      'auth/register',
      data: request.toJson(),
    );
    return AuthResponse.fromJson(response.data);
  }

  Future<AuthResponse> loginUser(LoginRequest request) async {
    final response = await _dio.post(
      'auth/login',
      data: request.toJson(),
    );
    return AuthResponse.fromJson(response.data);
  }
} 