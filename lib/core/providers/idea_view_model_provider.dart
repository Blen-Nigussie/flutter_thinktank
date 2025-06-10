import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../viewmodels/idea_view_model.dart';
import 'idea_repository_provider.dart';

final ideaViewModelProvider = StateNotifierProvider<IdeaViewModel, IdeaUiState>((ref) {
  final ideaRepository = ref.watch(ideaRepositoryProvider);
  return IdeaViewModel(ideaRepository);
}); 