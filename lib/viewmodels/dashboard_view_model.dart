import 'package:flutter/material.dart';
import 'dart:convert';
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

      final formattedToken = token.startsWith("Bearer ") ? token : "Bearer $token";
      print("\n=== Loading Ideas for Dashboard ===");
      print("Token format check: ${token.startsWith("Bearer ") ? "Already has Bearer" : "Adding Bearer"}");

      // Try admin endpoint first
      print("Trying admin endpoint first");
      final feedbackResponse = await _apiService.getAllFeedback(formattedToken);
      print("Feedback API Response code: ${feedbackResponse.statusCode}");

      if (feedbackResponse.statusCode == 200 && feedbackResponse.body != null) {
        // Admin flow
        print("Admin flow: Processing feedback");
        final allFeedback = json.decode(feedbackResponse.body);
        print("Total feedback received: ${allFeedback.length}");

        // Filter for approved feedback
        final approvedFeedback = allFeedback.where((feedback) =>
            feedback['status'] == 'Approved' && feedback['idea'] != null).toList();
        print("Approved feedback: ${approvedFeedback.length}");

        // Get unique idea IDs from approved feedback
        final approvedIdeaIds = approvedFeedback
            .map((feedback) => feedback['idea']?['id'])
            .where((id) => id != null)
            .toSet()
            .toList();
        print("Unique approved idea IDs: ${approvedIdeaIds.length}");

        // Get all ideas and filter for approved ones
        final ideasResponse = await _apiService.getAllIdeas(formattedToken);
        if (ideasResponse.statusCode == 200 && ideasResponse.body != null) {
          final allIdeas = json.decode(ideasResponse.body);
          final approvedIdeas = allIdeas.where((idea) =>
              approvedIdeaIds.contains(idea['id'])).toList();

          print("Admin: Approved ideas loaded: ${approvedIdeas.length}");
          approvedIdeas.forEach((idea) {
            print("Admin: Approved idea: ${idea['id']} - ${idea['title']}");
          });

          _updateState(
            approvedIdeas: approvedIdeas.map((idea) => Idea.fromJson(idea)).toList(),
            isLoading: false,
          );
        } else {
          final errorBody = ideasResponse.body;
          print("Admin: Failed to load ideas: ${ideasResponse.statusCode} - $errorBody");
          _updateState(
            error: "Failed to load ideas: ${errorBody ?? "Unknown error"}",
            isLoading: false,
          );
        }
      } else {
        // Regular user flow - use public ideas endpoint
        print("Regular user flow: Getting public ideas");
        try {
          final publicResponse = await _apiService.getPublicIdeas();
          print("Public ideas API Response code: ${publicResponse.statusCode}");
          print("Public ideas API Response body: ${publicResponse.body}");

          if (publicResponse.statusCode == 200 && publicResponse.body != null) {
            final publicIdeas = json.decode(publicResponse.body);
            print("Public ideas loaded: ${publicIdeas.length}");
            publicIdeas.forEach((idea) {
              print("Public idea: ${idea['id']} - ${idea['title']}");
            });

            _updateState(
              approvedIdeas: publicIdeas.map((idea) => Idea.fromJson(idea)).toList(),
              isLoading: false,
            );
          } else {
            final errorBody = publicResponse.body;
            print("Failed to load public ideas: ${publicResponse.statusCode} - $errorBody");
            _updateState(
              error: "Failed to load ideas: ${errorBody ?? "Unknown error"}",
              isLoading: false,
            );
          }
        } catch (e) {
          print("Error in public ideas flow: $e");
          _updateState(
            error: "Error loading ideas: $e",
            isLoading: false,
          );
        }
      }
    } catch (e) {
      print("Error loading ideas: $e");
      _updateState(
        error: e.toString(),
        isLoading: false,
      );
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
} 