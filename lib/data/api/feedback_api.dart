import 'package:dio/dio.dart';
import '../models/feedback.dart';
import '../models/create_feedback_request.dart';
import '../models/update_feedback_request.dart';

class FeedbackApi {
  final Dio _dio;

  FeedbackApi(this._dio);

  Future<Feedback> createFeedback(String token, CreateFeedbackRequest request) async {
    final response = await _dio.post(
      'feedback/admin',
      data: request.toJson(),
      options: Options(
        headers: {
          'Authorization': token,
          'Content-Type': 'application/json',
        },
      ),
    );
    return Feedback.fromJson(response.data);
  }

  Future<List<Feedback>> getFeedbackByIdeaId(String token, int ideaId) async {
    final response = await _dio.get(
      'feedback/$ideaId',
      options: Options(
        headers: {
          'Authorization': token,
          'Content-Type': 'application/json',
        },
      ),
    );
    return (response.data as List)
        .map((json) => Feedback.fromJson(json))
        .toList();
  }

  Future<List<Feedback>> getAllFeedback(String token) async {
    final response = await _dio.get(
      'feedback/admin/all',
      options: Options(
        headers: {
          'Authorization': token,
          'Content-Type': 'application/json',
        },
      ),
    );
    return (response.data as List)
        .map((json) => Feedback.fromJson(json))
        .toList();
  }

  Future<Feedback> getFeedbackById(String token, int id) async {
    final response = await _dio.get(
      'feedback/admin/$id',
      options: Options(
        headers: {
          'Authorization': token,
          'Content-Type': 'application/json',
        },
      ),
    );
    return Feedback.fromJson(response.data);
  }

  Future<Feedback> updateFeedback(
    String token,
    int id,
    UpdateFeedbackRequest request,
  ) async {
    final response = await _dio.patch(
      'feedback/admin/$id',
      data: request.toJson(),
      options: Options(
        headers: {
          'Authorization': token,
          'Content-Type': 'application/json',
        },
      ),
    );
    return Feedback.fromJson(response.data);
  }

  Future<void> deleteFeedback(String token, int id) async {
    await _dio.delete(
      'feedback/admin/$id',
      options: Options(
        headers: {
          'Authorization': token,
          'Content-Type': 'application/json',
        },
      ),
    );
  }

  Future<List<Feedback>> getFeedbackForIdea(String token, int ideaId) async {
    final response = await _dio.get(
      'feedback/idea/$ideaId',
      options: Options(
        headers: {
          'Authorization': token,
          'Content-Type': 'application/json',
        },
      ),
    );
    return (response.data as List)
        .map((json) => Feedback.fromJson(json))
        .toList();
  }
} 