import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../viewmodels/auth_view_model.dart';
import 'user_repository_provider.dart';

final authViewModelProvider = StateNotifierProvider<AuthViewModel, AuthUiState>((ref) {
  final userRepository = ref.watch(userRepositoryProvider);
  return AuthViewModel(userRepository);
}); 