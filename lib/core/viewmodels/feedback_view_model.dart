import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/feedback.dart';
import '../repositories/feedback_repository.dart';

class FeedbackUiState {
  final List<Feedback> feedbacks;
  final Feedback? selectedFeedback;
  final bool isLoading;
  final String? error;

  FeedbackUiState({
    this.feedbacks = const [],
    this.selectedFeedback,
    this.isLoading = false,
    this.error,
  });

  FeedbackUiState copyWith({
    List<Feedback>? feedbacks,
    Feedback? selectedFeedback,
    bool? isLoading,
    String? error,
  }) {
    return FeedbackUiState(
      feedbacks: feedbacks ?? this.feedbacks,
      selectedFeedback: selectedFeedback ?? this.selectedFeedback,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}

class FeedbackViewModel extends StateNotifier<FeedbackUiState> {
  final FeedbackRepository _feedbackRepository;

  FeedbackViewModel(this._feedbackRepository) : super(FeedbackUiState());

  Future<void> loadFeedbacks() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final feedbacks = await _feedbackRepository.getFeedbacks();
      state = state.copyWith(feedbacks: feedbacks, isLoading: false);
    } catch (e) {
      state = state.copyWith(error: e.toString(), isLoading: false);
    }
  }

  Future<void> selectFeedback(String id) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final feedback = await _feedbackRepository.getFeedbackById(id);
      state = state.copyWith(selectedFeedback: feedback, isLoading: false);
    } catch (e) {
      state = state.copyWith(error: e.toString(), isLoading: false);
    }
  }

  Future<void> createFeedback(String ideaId, String comment) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final feedback = await _feedbackRepository.createFeedback(ideaId, comment);
      state = state.copyWith(
        feedbacks: [...state.feedbacks, feedback],
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(error: e.toString(), isLoading: false);
    }
  }

  Future<void> updateFeedback(String id, String comment) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final updatedFeedback = await _feedbackRepository.updateFeedback(id, comment);
      state = state.copyWith(
        feedbacks: state.feedbacks.map((feedback) => feedback.id == id ? updatedFeedback : feedback).toList(),
        selectedFeedback: state.selectedFeedback?.id == id ? updatedFeedback : state.selectedFeedback,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(error: e.toString(), isLoading: false);
    }
  }

  Future<void> deleteFeedback(String id) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      await _feedbackRepository.deleteFeedback(id);
      state = state.copyWith(
        feedbacks: state.feedbacks.where((feedback) => feedback.id != id).toList(),
        selectedFeedback: state.selectedFeedback?.id == id ? null : state.selectedFeedback,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(error: e.toString(), isLoading: false);
    }
  }
} 