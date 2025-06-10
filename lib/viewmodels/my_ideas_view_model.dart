import 'package:flutter/material.dart';
import '../models/idea.dart';
import '../models/my_ideas_ui_state.dart';
import '../services/api_service.dart';
import '../services/token_manager.dart';

class MyIdeasViewModel extends ChangeNotifier {
  final ApiService _apiService;
  final TokenManager _tokenManager;
  MyIdeasUiState _uiState = MyIdeasUiState();

  MyIdeasViewModel({ApiService? apiService, TokenManager? tokenManager})
      : _apiService = apiService ?? ApiService(),
        _tokenManager = tokenManager ?? TokenManager();

  MyIdeasUiState get uiState => _uiState;

  Future<void> loadIdeas() async {
    _uiState = _uiState.copyWith(isLoading: true, error: null);
    notifyListeners();

    try {
      final ideas = await _apiService.getIdeas();
      _uiState = _uiState.copyWith(ideas: ideas, isLoading: false);
    } catch (e) {
      _uiState = _uiState.copyWith(error: e.toString(), isLoading: false);
    }
    notifyListeners();
  }

  Future<void> deleteIdea(String ideaId) async {
    _uiState = _uiState.copyWith(isLoading: true, error: null);
    notifyListeners();

    try {
      await _apiService.deleteIdea(ideaId);
      _uiState = _uiState.copyWith(
        ideas: _uiState.ideas.where((idea) => idea.id != ideaId).toList(),
        isLoading: false,
      );
    } catch (e) {
      _uiState = _uiState.copyWith(error: e.toString(), isLoading: false);
    }
    notifyListeners();
  }

  void onEditIdea(Idea idea) {
    // Navigate to edit idea screen
  }
} 