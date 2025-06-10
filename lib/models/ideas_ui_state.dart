import 'idea.dart';

class IdeasUiState {
  final List<Idea> ideas;
  final bool isLoading;
  final String? error;
  final bool isDeleting;
  final String? deletingIdeaId;

  IdeasUiState({
    this.ideas = const [],
    this.isLoading = false,
    this.error,
    this.isDeleting = false,
    this.deletingIdeaId,
  });

  IdeasUiState copyWith({
    List<Idea>? ideas,
    bool? isLoading,
    String? error,
    bool? isDeleting,
    String? deletingIdeaId,
  }) {
    return IdeasUiState(
      ideas: ideas ?? this.ideas,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      isDeleting: isDeleting ?? this.isDeleting,
      deletingIdeaId: deletingIdeaId ?? this.deletingIdeaId,
    );
  }
} 