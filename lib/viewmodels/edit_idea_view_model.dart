import 'dart:async';
import 'package:flutter/material.dart';
import 'dart:convert';
import '../models/edit_idea_ui_state.dart';
import '../services/api_service.dart';
import '../services/token_manager.dart';

class EditIdeaViewModel extends ChangeNotifier {
  final ApiService _apiService;
  final TokenManager _tokenManager;
  EditIdeaUiState _uiState = EditIdeaUiState();
  Timer? _successTimer;

  EditIdeaUiState get uiState => _uiState;

  EditIdeaViewModel({
    ApiService? apiService,
    TokenManager? tokenManager,
  })  : _apiService = apiService ?? ApiService(),
        _tokenManager = tokenManager ?? TokenManager();

  @override
  void dispose() {
    _successTimer?.cancel();
    super.dispose();
  }

  Future<void> loadIdea(String ideaId) async {
    try {
      _updateState(isLoading: true, error: null);
      final token = await _tokenManager.getToken();
      if (token == null) {
        _updateState(error: "Not authenticated", isLoading: false);
        return;
      }

      final response = await _apiService.getUserIdeas(token);
      if (response.statusCode == 200) {
        final List<dynamic> ideas = json.decode(response.body);
        final idea = ideas.firstWhere(
          (idea) => idea['id'] == ideaId,
          orElse: () => null,
        );

        if (idea != null) {
          _updateState(
            ideaId: idea['id'],
            title: idea['title'],
            description: idea['description'],
            tags: idea['tags']?.join(','),
            isLoading: false,
          );
        } else {
          _updateState(error: "Idea not found", isLoading: false);
        }
      } else {
        _updateState(error: "Failed to load idea", isLoading: false);
      }
    } catch (e) {
      _updateState(error: e.toString(), isLoading: false);
    }
  }

  void onTitleChange(String newTitle) {
    _updateState(title: newTitle, error: null);
  }

  void onDescriptionChange(String newDescription) {
    _updateState(description: newDescription, error: null);
  }

  void onTagsChange(String newTags) {
    _updateState(tags: newTags, error: null);
  }

  Future<void> onUpdateIdea() async {
    if (!_validateInput()) return;

    try {
      final token = await _tokenManager.getToken();
      if (token == null) {
        _updateState(error: "Not authenticated");
        return;
      }

      _updateState(isUpdating: true, error: null);

      final request = {
        'title': _uiState.title,
        'description': _uiState.description,
        'tags': _uiState.tags?.split(',')
            .map((tag) => tag.trim())
            .where((tag) => tag.isNotEmpty)
            .toList(),
      };

      final response = await _apiService.updateIdea(
        token,
        _uiState.ideaId,
        request,
      );

      if (response.statusCode == 200) {
        _updateState(isUpdating: false, updateSuccess: true);
        // Delay navigation to show success message
        _successTimer = Timer(Duration(seconds: 2), () {
          Navigator.pop(navigatorKey.currentContext!);
        });
      } else {
        String errorMessage;
        switch (response.statusCode) {
          case 403:
            errorMessage = "You don't have permission to edit this idea";
            break;
          case 404:
            errorMessage = "Idea not found";
            break;
          default:
            errorMessage = "Failed to update idea";
        }
        _updateState(error: errorMessage, isUpdating: false);
      }
    } catch (e) {
      _updateState(error: e.toString(), isUpdating: false);
    }
  }

  bool _validateInput() {
    final title = _uiState.title.trim();
    final description = _uiState.description.trim();
    final tags = _uiState.tags?.trim();

    if (title.isEmpty) {
      _updateState(error: "Title cannot be empty");
      return false;
    }
    if (title.length < 3) {
      _updateState(error: "Title must be at least 3 characters long");
      return false;
    }
    if (description.isEmpty) {
      _updateState(error: "Description cannot be empty");
      return false;
    }
    if (description.length < 10) {
      _updateState(error: "Description must be at least 10 characters long");
      return false;
    }
    if (tags?.isNotEmpty == true &&
        tags!.split(',').any((tag) => tag.trim().length < 2)) {
      _updateState(error: "Each tag must be at least 2 characters long");
      return false;
    }
    return true;
  }

  void _updateState({
    String? ideaId,
    String? title,
    String? description,
    String? tags,
    bool? isLoading,
    bool? isUpdating,
    bool? updateSuccess,
    String? error,
  }) {
    _uiState = _uiState.copyWith(
      ideaId: ideaId,
      title: title,
      description: description,
      tags: tags,
      isLoading: isLoading,
      isUpdating: isUpdating,
      updateSuccess: updateSuccess,
      error: error,
    );
    notifyListeners();
  }
} 