import 'package:dio/dio.dart';
import '../models/idea.dart';
import '../models/user.dart';

class ApiService {
  final Dio _dio;

  ApiService(this._dio);

  Future<List<Idea>> getUserIdeas(String token) async {
    final response = await _dio.get(
      'ideas/user',
      options: Options(headers: {'Authorization': token}),
    );
    return (response.data as List)
        .map((json) => Idea.fromJson(json))
        .toList();
  }

  Future<List<Idea>> getPublicIdeas() async {
    final response = await _dio.get('ideas/public');
    return (response.data as List)
        .map((json) => Idea.fromJson(json))
        .toList();
  }

  Future<Idea> getIdeaById(String id) async {
    final response = await _dio.get('ideas/$id');
    return Idea.fromJson(response.data);
  }

  Future<Idea> createIdea(String token, Idea idea) async {
    final response = await _dio.post(
      'ideas',
      data: idea.toJson(),
      options: Options(headers: {'Authorization': token}),
    );
    return Idea.fromJson(response.data);
  }

  Future<void> deleteIdea(String token, String id) async {
    await _dio.delete(
      'ideas/$id',
      options: Options(headers: {'Authorization': token}),
    );
  }

  Future<Idea> updateIdea(String token, String id, Idea idea) async {
    final response = await _dio.patch(
      'ideas/$id',
      data: idea.toJson(),
      options: Options(headers: {'Authorization': token}),
    );
    return Idea.fromJson(response.data);
  }

  Future<User> getUserProfile(String token, String id) async {
    final response = await _dio.get(
      'users/$id',
      options: Options(headers: {'Authorization': token}),
    );
    return User.fromJson(response.data);
  }
} 