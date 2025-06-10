import 'package:flutter/material.dart';
import '../models/idea.dart';
import '../models/status.dart';
import '../models/profile_ui_state.dart';
import '../services/api_service.dart';
import '../services/token_manager.dart';

class ProfileViewModel extends ChangeNotifier {
  final ApiService _apiService;
  final TokenManager _tokenManager;
  ProfileUiState _uiState = ProfileUiState();

  ProfileViewModel({ApiService? apiService, TokenManager? tokenManager})
      : _apiService = apiService ?? ApiService(),
        _tokenManager = tokenManager ?? TokenManager();

  ProfileUiState get uiState => _uiState;

  void toggleFeedbackExpanded() {
    _uiState = _uiState.copyWith(isFeedbackExpanded: !_uiState.isFeedbackExpanded);
    notifyListeners();
  }

  Future<void> logout() async {
    await _tokenManager.clearToken();
    _uiState = ProfileUiState();
    notifyListeners();
  }

  Future<void> loadProfile() async {
    _uiState = _uiState.copyWith(isLoading: true);
    notifyListeners();

    try {
      final token = await _tokenManager.getToken();
      if (token != null) {
        final user = await _apiService.getUserProfile(token);
        _uiState = _uiState.copyWith(
          userName: '${user.firstName} ${user.lastName}',
          email: user.email,
          bio: user.profile?.bio ?? '',
          isLoading: false,
        );
        await loadIdeas();
      } else {
        _uiState = _uiState.copyWith(
          error: 'No authentication token found',
          isLoading: false,
        );
      }
    } catch (e) {
      _uiState = _uiState.copyWith(
        error: 'Failed to load profile: ${e.toString()}',
        isLoading: false,
      );
    }
    notifyListeners();
  }

  Future<void> loadIdeas() async {
    try {
      final token = await _tokenManager.getToken();
      if (token != null) {
        final ideas = await _apiService.getUserIdeas(token);
        _uiState = _uiState.copyWith(submittedIdeas: ideas);
      }
    } catch (e) {
      _uiState = _uiState.copyWith(error: 'Failed to load ideas: ${e.toString()}');
    }
    notifyListeners();
  }

  Future<void> deleteIdea(String ideaId) async {
    try {
      final token = await _tokenManager.getToken();
      if (token != null) {
        await _apiService.deleteIdea(token, ideaId);
        _uiState = _uiState.copyWith(
          submittedIdeas: _uiState.submittedIdeas.where((idea) => idea.id != ideaId).toList(),
        );
      }
    } catch (e) {
      _uiState = _uiState.copyWith(error: 'Failed to delete idea: ${e.toString()}');
    }
    notifyListeners();
  }

  Future<void> updateStatus(Status status) async {
    try {
      final token = await _tokenManager.getToken();
      if (token != null) {
        await _apiService.updateUserStatus(token, status);
        _uiState = _uiState.copyWith(status: status);
      }
    } catch (e) {
      _uiState = _uiState.copyWith(error: 'Failed to update status: ${e.toString()}');
    }
    notifyListeners();
  }

  void clearError() {
    _uiState = _uiState.copyWith(error: null);
    notifyListeners();
  }
} 