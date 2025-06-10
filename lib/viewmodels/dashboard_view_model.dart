import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:developer' as developer;
import '../models/dashboard_ui_state.dart';
import '../models/idea.dart';
import '../services/api_service.dart';
import '../services/token_manager.dart';

class DashboardViewModel extends ChangeNotifier {
  final ApiService _apiService;
  final TokenManager _tokenManager;
  DashboardUiState _uiState = DashboardUiState();

  DashboardUiState get uiState => _uiState;

  DashboardViewModel({
    ApiService? apiService,
    TokenManager? tokenManager,
  })  : _apiService = apiService ?? ApiService(),
        _tokenManager = tokenManager ?? TokenManager();

  Future<void> loadApprovedIdeas() async {
    try {
      _updateState(isLoading: true, error: null);
      final token = await _tokenManager.getToken();
      if (token == null) {
        _updateState(error: "Not authenticated", isLoading: false);
        return;
      }

      developer.log("=== Loading Ideas for Dashboard ===", name: 'DashboardViewModel');
      developer.log("Token format check: ${token.startsWith("Bearer ") ? "Already has Bearer" : "Adding Bearer"}", name: 'DashboardViewModel');

      // Try admin endpoint first
      developer.log("Trying admin endpoint first", name: 'DashboardViewModel');
      final feedbackResponse = await _apiService.getAllFeedback(formattedToken);
      developer.log("Feedback API Response code: ${feedbackResponse.statusCode}", name: 'DashboardViewModel');

      if (feedbackResponse.statusCode == 200 && feedbackResponse.body != null) {
        // Admin flow
        developer.log("Admin flow: Processing feedback", name: 'DashboardViewModel');
        final allFeedback = json.decode(feedbackResponse.body);
        developer.log("Total feedback received: ${allFeedback.length}", name: 'DashboardViewModel');

        // Filter for approved feedback
        final approvedFeedback = allFeedback.where((feedback) =>
            feedback['status'] == 'Approved' && feedback['idea'] != null).toList();
        developer.log("Approved feedback: ${approvedFeedback.length}", name: 'DashboardViewModel');

        // Get unique idea IDs from approved feedback
        final approvedIdeaIds = approvedFeedback
            .map((feedback) => feedback['idea']?['id'])
            .where((id) => id != null)
            .toSet()
            .toList();
        developer.log("Unique approved idea IDs: ${approvedIdeaIds.length}", name: 'DashboardViewModel');

        // Get all ideas and filter for approved ones
        final ideasResponse = await _apiService.getAllIdeas(formattedToken);
        if (ideasResponse.statusCode == 200 && ideasResponse.body != null) {
          final allIdeas = json.decode(ideasResponse.body);
          final approvedIdeas = allIdeas.where((idea) =>
              approvedIdeaIds.contains(idea['id'])).toList();

          developer.log("Admin: Approved ideas loaded: ${approvedIdeas.length}", name: 'DashboardViewModel');
          approvedIdeas.forEach((idea) {
            developer.log("Admin: Approved idea: ${idea['id']} - ${idea['title']}", name: 'DashboardViewModel');
          });

          _updateState(
            approvedIdeas: approvedIdeas.map((idea) => Idea.fromJson(idea)).toList(),
            isLoading: false,
          );
        } else {
          final errorBody = ideasResponse.body;
          developer.log("Admin: Failed to load ideas: ${ideasResponse.statusCode} - $errorBody", name: 'DashboardViewModel');
          _updateState(
            error: "Failed to load ideas: ${errorBody ?? "Unknown error"}",
            isLoading: false,
          );
        }
      } else {
        // Regular user flow - use public ideas endpoint
        developer.log("Regular user flow: Getting public ideas", name: 'DashboardViewModel');
        try {
          final publicResponse = await _apiService.getPublicIdeas();
          developer.log("Public ideas API Response code: ${publicResponse.statusCode}", name: 'DashboardViewModel');
          developer.log("Public ideas API Response body: ${publicResponse.body}", name: 'DashboardViewModel');

          if (publicResponse.statusCode == 200 && publicResponse.body != null) {
            final publicIdeas = json.decode(publicResponse.body);
            developer.log("Public ideas loaded: ${publicIdeas.length}", name: 'DashboardViewModel');
            publicIdeas.forEach((idea) {
              developer.log("Public idea: ${idea['id']} - ${idea['title']}", name: 'DashboardViewModel');
            });

            _updateState(
              approvedIdeas: publicIdeas.map((idea) => Idea.fromJson(idea)).toList(),
              isLoading: false,
            );
          } else {
            final errorBody = publicResponse.body;
            developer.log("Failed to load public ideas: ${publicResponse.statusCode} - $errorBody", name: 'DashboardViewModel');
            _updateState(
              error: "Failed to load ideas: ${errorBody ?? "Unknown error"}",
              isLoading: false,
            );
          }
        } catch (e) {
          developer.log("Error in public ideas flow: $e", name: 'DashboardViewModel', error: e);
          _updateState(
            error: "Error loading ideas: $e",
            isLoading: false,
          );
        }
      }
    } catch (e) {
      developer.log("Error loading ideas: $e", name: 'DashboardViewModel', error: e);
      _updateState(
        error: e.toString(),
        isLoading: false,
      );
    }
  }
  }

  void onDrawerOpen() {
    _updateState(isDrawerOpen: true);
  }

  void onDrawerClose() {
    _updateState(isDrawerOpen: false);
  }

  void _updateState({
    List<Idea>? approvedIdeas,
    bool? isDrawerOpen,
    bool? isLoading,
    String? error,
  }) {
    _uiState = _uiState.copyWith(
      approvedIdeas: approvedIdeas,
      isDrawerOpen: isDrawerOpen,
      isLoading: isLoading,
      error: error,
    );
    notifyListeners();
  }