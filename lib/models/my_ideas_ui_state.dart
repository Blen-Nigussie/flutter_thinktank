import 'idea.dart';

class MyIdeasUiState {
  final List<Idea> ideas;
  final bool isLoading;
  final String? error;

  MyIdeasUiState({
    this.ideas = const [],
    this.isLoading = false,
    this.error,
  });

  MyIdeasUiState copyWith({
    List<Idea>? ideas,
    bool? isLoading,
    String? error,
  }) {
    return MyIdeasUiState(
      ideas: ideas ?? this.ideas,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
} 