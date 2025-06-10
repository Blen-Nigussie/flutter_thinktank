import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/idea.dart';
import '../repositories/idea_repository.dart';

class IdeaUiState {
  final List<Idea> ideas;
  final Idea? selectedIdea;
  final bool isLoading;
  final String? error;

  IdeaUiState({
    this.ideas = const [],
    this.selectedIdea,
    this.isLoading = false,
    this.error,
  });

  IdeaUiState copyWith({
    List<Idea>? ideas,
    Idea? selectedIdea,
    bool? isLoading,
    String? error,
  }) {
    return IdeaUiState(
      ideas: ideas ?? this.ideas,
      selectedIdea: selectedIdea ?? this.selectedIdea,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}

class IdeaViewModel extends StateNotifier<IdeaUiState> {
  final IdeaRepository _ideaRepository;

  IdeaViewModel(this._ideaRepository) : super(IdeaUiState());

  Future<void> loadIdeas() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final ideas = await _ideaRepository.getIdeas();
      state = state.copyWith(ideas: ideas, isLoading: false);
    } catch (e) {
      state = state.copyWith(error: e.toString(), isLoading: false);
    }
  }

  Future<void> selectIdea(String id) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final idea = await _ideaRepository.getIdeaById(id);
      state = state.copyWith(selectedIdea: idea, isLoading: false);
    } catch (e) {
      state = state.copyWith(error: e.toString(), isLoading: false);
    }
  }

  Future<void> createIdea(String title, String description) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final idea = await _ideaRepository.createIdea(title, description);
      state = state.copyWith(
        ideas: [...state.ideas, idea],
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(error: e.toString(), isLoading: false);
    }
  }

  Future<void> updateIdea(String id, String title, String description) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final updatedIdea = await _ideaRepository.updateIdea(id, title, description);
      state = state.copyWith(
        ideas: state.ideas.map((idea) => idea.id == id ? updatedIdea : idea).toList(),
        selectedIdea: state.selectedIdea?.id == id ? updatedIdea : state.selectedIdea,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(error: e.toString(), isLoading: false);
    }
  }

  Future<void> deleteIdea(String id) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      await _ideaRepository.deleteIdea(id);
      state = state.copyWith(
        ideas: state.ideas.where((idea) => idea.id != id).toList(),
        selectedIdea: state.selectedIdea?.id == id ? null : state.selectedIdea,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(error: e.toString(), isLoading: false);
    }
  }
} 