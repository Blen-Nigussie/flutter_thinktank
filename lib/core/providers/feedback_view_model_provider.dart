import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../viewmodels/feedback_view_model.dart';
import 'feedback_repository_provider.dart';

final feedbackViewModelProvider = StateNotifierProvider<FeedbackViewModel, FeedbackUiState>((ref) {
  final feedbackRepository = ref.watch(feedbackRepositoryProvider);
  return FeedbackViewModel(feedbackRepository);
}); 