import 'package:flutter/material.dart';
import '../models/ideas_ui_state.dart';
import '../models/idea.dart';
import '../services/api_service.dart';
import '../services/token_manager.dart';

class IdeasViewModel extends ChangeNotifier {
  final ApiService _apiService;
  final TokenManager _tokenManager;
  IdeasUiState _uiState = IdeasUiState();

  IdeasViewModel({ApiService? apiService, TokenManager? tokenManager})
      : _apiService = apiService ?? ApiService(),
        _tokenManager = tokenManager ?? TokenManager();

  IdeasUiState get uiState => _uiState;

  Future<void> loadIdeas() async {
    final token = await _tokenManager.getToken();
    if (token == null) {
      _uiState = _uiState.copyWith(error: 'Please login to view ideas');
      notifyListeners();
      return;
    }

    _uiState = _uiState.copyWith(isLoading: true, error: null);
    notifyListeners();

    try {
      final response = await _apiService.getUserIdeas('Bearer $token');

      if (response.statusCode == 200) {
        final ideas = (response.data as List)
            .map((json) => Idea.fromJson(json))
            .toList();
        _uiState = _uiState.copyWith(ideas: ideas, isLoading: false);
      } else {
        _uiState = _uiState.copyWith(
          error: response.data['message'] ?? 'Failed to load ideas',
          isLoading: false,
        );
      }
    } catch (e) {
      _uiState = _uiState.copyWith(
        error: 'Error loading ideas: ${e.toString()}',
        isLoading: false,
      );
    }
    notifyListeners();
  }

  Future<void> deleteIdea(String ideaId) async {
    final token = await _tokenManager.getToken();
    if (token == null) {
      _uiState = _uiState.copyWith(error: 'Please login to delete ideas');
      notifyListeners();
      return;
    }

    _uiState = _uiState.copyWith(isDeleting: true, deletingIdeaId: ideaId);
    notifyListeners();

    try {
      final response = await _apiService.deleteIdea('Bearer $token', ideaId);

      if (response.statusCode == 200) {
        _uiState = _uiState.copyWith(
          ideas: _uiState.ideas.where((idea) => idea.id != ideaId).toList(),
          isDeleting: false,
          deletingIdeaId: null,
        );
      } else {
        _uiState = _uiState.copyWith(
          error: response.data['message'] ?? 'Failed to delete idea',
          isDeleting: false,
          deletingIdeaId: null,
        );
      }
    } catch (e) {
      _uiState = _uiState.copyWith(
        error: 'Error deleting idea: ${e.toString()}',
        isDeleting: false,
        deletingIdeaId: null,
      );
    }
    notifyListeners();
  }
} 