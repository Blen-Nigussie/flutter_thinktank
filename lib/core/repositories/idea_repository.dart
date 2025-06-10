import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/api_service.dart';
import '../network/network_info.dart';
import '../models/idea.dart';

class IdeaRepository {
  final ApiService _apiService;
  final NetworkInfo _networkInfo;

  IdeaRepository(this._apiService, this._networkInfo);

  Future<List<Idea>> getIdeas() async {
    if (await _networkInfo.isConnected) {
      return await _apiService.getIdeas();
    } else {
      throw Exception('No internet connection');
    }
  }

  Future<Idea> getIdeaById(String id) async {
    if (await _networkInfo.isConnected) {
      return await _apiService.getIdeaById(id);
    } else {
      throw Exception('No internet connection');
    }
  }

  Future<Idea> createIdea(String title, String description) async {
    if (await _networkInfo.isConnected) {
      return await _apiService.createIdea(title, description);
    } else {
      throw Exception('No internet connection');
    }
  }

  Future<Idea> updateIdea(String id, String title, String description) async {
    if (await _networkInfo.isConnected) {
      return await _apiService.updateIdea(id, title, description);
    } else {
      throw Exception('No internet connection');
    }
  }

  Future<void> deleteIdea(String id) async {
    if (await _networkInfo.isConnected) {
      await _apiService.deleteIdea(id);
    } else {
      throw Exception('No internet connection');
    }
  }
} 