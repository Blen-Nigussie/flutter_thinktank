import '../models/idea.dart';

class DashboardUiState {
  final List<Idea> approvedIdeas;
  final bool isDrawerOpen;
  final bool isLoading;
  final String? error;

  DashboardUiState({
    this.approvedIdeas = const [],
    this.isDrawerOpen = false,
    this.isLoading = false,
    this.error,
  });

  DashboardUiState copyWith({
    List<Idea>? approvedIdeas,
    bool? isDrawerOpen,
    bool? isLoading,
    String? error,
  }) {
    return DashboardUiState(
      approvedIdeas: approvedIdeas ?? this.approvedIdeas,
      isDrawerOpen: isDrawerOpen ?? this.isDrawerOpen,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
} 