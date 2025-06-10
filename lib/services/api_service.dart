import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/idea.dart';
import 'token_manager.dart';

class ApiService {
  final String baseUrl = 'https://api.example.com'; // Replace with your actual API URL
  final TokenManager _tokenManager;

  ApiService({TokenManager? tokenManager}) : _tokenManager = tokenManager ?? TokenManager();

  Future<List<Idea>> getIdeas() async {
    final token = await _tokenManager.getToken();
    final response = await http.get(
      Uri.parse('$baseUrl/ideas'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => Idea.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load ideas');
    }
  }

  Future<void> deleteIdea(String ideaId) async {
    final token = await _tokenManager.getToken();
    final response = await http.delete(
      Uri.parse('$baseUrl/ideas/$ideaId'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to delete idea');
    }
  }
} 