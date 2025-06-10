import 'package:dio/dio.dart';
import '../models/idea.dart';
import '../models/user.dart';
import '../models/profile.dart';
import '../models/create_profile_request.dart';
import '../models/update_profile_request.dart';
import '../models/update_user_request.dart';
import 'package:thinktank/pages/profile/status.dart';

class ApiService {
  final Dio _dio;

  ApiService(this._dio);

  Future<User> getUserProfile(String token, int id) async {
    final response = await _dio.get(
      'users/$id',
      options: Options(headers: {'Authorization': token}),
    );
    return User.fromJson(response.data);
  }

  Future<List<Idea>> getUserIdeas(String token) async {
    final response = await _dio.get(
      'ideas/user',
      options: Options(headers: {'Authorization': token}),
    );
    return (response.data as List)
        .map((json) => Idea.fromJson(json))
        .toList();
  }

  Future<void> deleteIdea(String token, String ideaId) async {
    await _dio.delete(
      'ideas/$ideaId',
      options: Options(headers: {'Authorization': token}),
    );
  }

  Future<void> updateUserStatus(String token, Status status) async {
    await _dio.put(
      'users/status',
      data: status.toString(),
      options: Options(headers: {'Authorization': token}),
    );
  }

  Future<Profile> getProfile(String token, int id) async {
    final response = await _dio.get(
      'profiles/$id',
      options: Options(headers: {'Authorization': token}),
    );
    return Profile.fromJson(response.data);
  }

  Future<Profile> createProfile(String token, CreateProfileRequest request) async {
    final response = await _dio.post(
      'profiles',
      data: request.toJson(),
      options: Options(headers: {'Authorization': token}),
    );
    return Profile.fromJson(response.data);
  }

  Future<Profile> updateProfile(
    String token,
    int id,
    UpdateProfileRequest request,
  ) async {
    final response = await _dio.patch(
      'profiles/$id',
      data: request.toJson(),
      options: Options(headers: {'Authorization': token}),
    );
    return Profile.fromJson(response.data);
  }

  Future<void> deleteProfile(String token, int id) async {
    await _dio.delete(
      'profiles/$id',
      options: Options(headers: {'Authorization': token}),
    );
  }

  Future<String> uploadProfilePicture(String token, FormData formData) async {
    final response = await _dio.post(
      'profiles/upload',
      data: formData,
      options: Options(
        headers: {'Authorization': token},
        contentType: 'multipart/form-data',
      ),
    );
    return response.data;
  }

  Future<User> updateUser(
    String token,
    int id,
    UpdateUserRequest request,
  ) async {
    final response = await _dio.put(
      'users/$id',
      data: request.toJson(),
      options: Options(headers: {'Authorization': token}),
    );
    return User.fromJson(response.data);
  }
} 