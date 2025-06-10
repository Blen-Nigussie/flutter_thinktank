import 'package:dio/dio.dart';
import '../models/idea.dart';
import '../models/idea_submission_request.dart';
import '../models/idea_update_request.dart';

class IdeaApi {
  final Dio _dio;

  IdeaApi(this._dio);

  Future<List<Idea>> getUserIdeas(String token) async {
    final response = await _dio.get(
      'ideas/user',
      options: Options(
        headers: {
          'Authorization': token,
          'Content-Type': 'application/json',
        },
      ),
    );
    return (response.data as List)
        .map((json) => Idea.fromJson(json))
        .toList();
  }

  Future<List<Idea>> getAllIdeas(String token) async {
    final response = await _dio.get(
      'ideas/admin/all',
      options: Options(
        headers: {
          'Authorization': token,
          'Content-Type': 'application/json',
        },
      ),
    );
    return (response.data as List)
        .map((json) => Idea.fromJson(json))
        .toList();
  }

  Future<List<Idea>> getPublicIdeas() async {
    final response = await _dio.get(
      'ideas/public',
      options: Options(headers: {'Content-Type': 'application/json'}),
    );
    return (response.data as List)
        .map((json) => Idea.fromJson(json))
        .toList();
  }

  Future<void> submitIdea(String token, IdeaSubmissionRequest request) async {
    await _dio.post(
      'ideas',
      data: request.toJson(),
      options: Options(
        headers: {
          'Authorization': token,
          'Content-Type': 'application/json',
        },
      ),
    );
  }

  Future<void> updateIdea(
    String token,
    String id,
    IdeaUpdateRequest request,
  ) async {
    await _dio.patch(
      'ideas/$id',
      data: request.toJson(),
      options: Options(
        headers: {
          'Authorization': token,
          'Content-Type': 'application/json',
        },
      ),
    );
  }

  Future<void> deleteIdea(String token, String id) async {
    await _dio.delete(
      'ideas/$id',
      options: Options(
        headers: {
          'Authorization': token,
          'Content-Type': 'application/json',
        },
      ),
    );
  }

  Future<Idea> updateIdeaStatus(String token, int id, String status) async {
    final response = await _dio.patch(
      'ideas/$id/status',
      data: status,
      options: Options(
        headers: {
          'Authorization': token,
          'Content-Type': 'application/json',
        },
      ),
    );
    return Idea.fromJson(response.data);
  }
} 