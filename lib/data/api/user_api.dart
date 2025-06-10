import 'package:dio/dio.dart';
import '../models/profile.dart';
import '../models/update_user_request.dart';

class UserApi {
  final Dio _dio;

  UserApi(this._dio);

  Future<Profile> getProfile(String token) async {
    final response = await _dio.get(
      'users/profile',
      options: Options(headers: {'Authorization': token}),
    );
    return Profile.fromJson(response.data);
  }

  Future<Profile> updateProfile(String token, UpdateUserRequest request) async {
    final response = await _dio.patch(
      'users/profile',
      data: request.toJson(),
      options: Options(headers: {'Authorization': token}),
    );
    return Profile.fromJson(response.data);
  }
} 