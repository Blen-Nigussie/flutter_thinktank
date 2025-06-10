import 'package:dio/dio.dart';
import '../models/user.dart';
import '../models/idea.dart';
import '../models/feedback.dart';
import '../auth/token_manager.dart';

class ApiService {
  final Dio _dio;
  final TokenManager _tokenManager;

  ApiService(this._dio, this._tokenManager);

  // User API calls
  Future<User> login(String email, String password) async {
    final response = await _dio.post('/auth/login', data: {
      'email': email,
      'password': password,
    });
    final token = response.data['token'];
    await _tokenManager.saveToken(token);
    return User.fromJson(response.data['user']);
  }

  Future<User> register(String name, String email, String password) async {
    final response = await _dio.post('/auth/register', data: {
      'name': name,
      'email': email,
      'password': password,
    });
    final token = response.data['token'];
    await _tokenManager.saveToken(token);
    return User.fromJson(response.data['user']);
  }

  Future<void> logout() async {
    await _dio.post('/auth/logout');
    await _tokenManager.deleteToken();
  }

  Future<User> getCurrentUser() async {
    final response = await _dio.get('/auth/me');
    return User.fromJson(response.data);
  }

  // Idea API calls
  Future<List<Idea>> getIdeas() async {
    final response = await _dio.get('/ideas');
    return (response.data as List).map((json) => Idea.fromJson(json)).toList();
  }

  Future<Idea> getIdeaById(String id) async {
    final response = await _dio.get('/ideas/$id');
    return Idea.fromJson(response.data);
  }

  Future<Idea> createIdea(String title, String description) async {
    final response = await _dio.post('/ideas', data: {
      'title': title,
      'description': description,
    });
    return Idea.fromJson(response.data);
  }

  Future<Idea> updateIdea(String id, String title, String description) async {
    final response = await _dio.put('/ideas/$id', data: {
      'title': title,
      'description': description,
    });
    return Idea.fromJson(response.data);
  }

  Future<void> deleteIdea(String id) async {
    await _dio.delete('/ideas/$id');
  }

  // Feedback API calls
  Future<List<Feedback>> getFeedbacks() async {
    final response = await _dio.get('/feedbacks');
    return (response.data as List).map((json) => Feedback.fromJson(json)).toList();
  }

  Future<Feedback> getFeedbackById(String id) async {
    final response = await _dio.get('/feedbacks/$id');
    return Feedback.fromJson(response.data);
  }

  Future<Feedback> createFeedback(String ideaId, String comment) async {
    final response = await _dio.post('/feedbacks', data: {
      'ideaId': ideaId,
      'comment': comment,
    });
    return Feedback.fromJson(response.data);
  }

  Future<Feedback> updateFeedback(String id, String comment) async {
    final response = await _dio.put('/feedbacks/$id', data: {
      'comment': comment,
    });
    return Feedback.fromJson(response.data);
  }

  Future<void> deleteFeedback(String id) async {
    await _dio.delete('/feedbacks/$id');
  }
} 