import 'package:flutter/material.dart';
import '../models/idea_submission_ui_state.dart';
import '../services/api_service.dart';
import '../services/token_manager.dart';

class IdeaSubmissionViewModel extends ChangeNotifier {
  final ApiService _apiService;
  final TokenManager _tokenManager;
  IdeaSubmissionUiState _uiState = IdeaSubmissionUiState();

  IdeaSubmissionViewModel({ApiService? apiService, TokenManager? tokenManager})
      : _apiService = apiService ?? ApiService(),
        _tokenManager = tokenManager ?? TokenManager();

  IdeaSubmissionUiState get uiState => _uiState;

  void onTitleChange(String newTitle) {
    _uiState = _uiState.copyWith(title: newTitle, error: null);
    notifyListeners();
  }

  void onDescriptionChange(String newDescription) {
    _uiState = _uiState.copyWith(description: newDescription, error: null);
    notifyListeners();
  }

  void onTagsChange(String newTags) {
    _uiState = _uiState.copyWith(tags: newTags, error: null);
    notifyListeners();
  }

  bool _validateInput() {
    final title = _uiState.title.trim();
    final description = _uiState.description.trim();
    final tags = _uiState.tags?.trim();

    if (title.isEmpty) {
      _uiState = _uiState.copyWith(error: 'Title cannot be empty');
      notifyListeners();
      return false;
    }

    if (title.length < 3) {
      _uiState = _uiState.copyWith(error: 'Title must be at least 3 characters long');
      notifyListeners();
      return false;
    }

    if (description.isEmpty) {
      _uiState = _uiState.copyWith(error: 'Description cannot be empty');
      notifyListeners();
      return false;
    }

    if (description.length < 10) {
      _uiState = _uiState.copyWith(error: 'Description must be at least 10 characters long');
      notifyListeners();
      return false;
    }

    if (tags?.isNotEmpty == true) {
      final tagList = tags.split(',').map((e) => e.trim()).toList();
      if (tagList.any((tag) => tag.length < 2)) {
        _uiState = _uiState.copyWith(error: 'Each tag must be at least 2 characters long');
        notifyListeners();
        return false;
      }
    }

    return true;
  }

  Future<void> onSubmitIdea() async {
    final token = await _tokenManager.getToken();
    if (token == null) {
      _uiState = _uiState.copyWith(error: 'Please login to submit ideas');
      notifyListeners();
      return;
    }

    if (!_validateInput()) {
      return;
    }

    _uiState = _uiState.copyWith(isSubmitting: true, error: null);
    notifyListeners();

    try {
      final request = {
        'title': _uiState.title.trim(),
        'description': _uiState.description.trim(),
        'tags': _uiState.tags?.split(',')
            .map((e) => e.trim())
            .where((e) => e.isNotEmpty)
            .toList(),
      };

      final response = await _apiService.submitIdea('Bearer $token', request);

      if (response.statusCode == 200) {
        _uiState = _uiState.copyWith(isSubmitting: false, submissionSuccess: true);
        notifyListeners();

        // Delay navigation to show success message
        await Future.delayed(Duration(seconds: 2));
        // Navigate to ideas page
      } else {
        String errorMessage;
        switch (response.statusCode) {
          case 403:
            errorMessage = "You don't have permission to submit ideas";
            break;
          case 400:
            errorMessage = "Invalid idea data";
            break;
          default:
            errorMessage = "Failed to submit idea";
        }
        _uiState = _uiState.copyWith(error: errorMessage, isSubmitting: false);
        notifyListeners();
      }
    } catch (e) {
      String errorMessage;
      if (e is SocketTimeoutException) {
        errorMessage = "Connection timed out. Please try again.";
      } else if (e is UnknownHostException) {
        errorMessage = "No internet connection. Please check your network.";
      } else {
        errorMessage = e.toString();
      }
      _uiState = _uiState.copyWith(error: errorMessage, isSubmitting: false);
      notifyListeners();
    }
  }
} 