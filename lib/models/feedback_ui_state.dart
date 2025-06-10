import 'idea.dart';

class FeedbackUiState {
  final List<Idea> ideas;
  final Idea? selectedIdea;
  final bool isLoading;
  final String? error;

  const FeedbackUiState({
    this.ideas = const [],
    this.selectedIdea,
    this.isLoading = false,
    this.error,
  });

  FeedbackUiState copyWith({
    List<Idea>? ideas,
    Idea? selectedIdea,
    bool? isLoading,
    String? error,
  }) {
    return FeedbackUiState(
      ideas: ideas ?? this.ideas,
      selectedIdea: selectedIdea ?? this.selectedIdea,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
} 