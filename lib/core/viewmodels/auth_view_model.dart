import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/user.dart';
import '../models/idea.dart';
import '../repositories/user_repository.dart';

class AuthUiState {
  final User? user;
  final bool isLoading;
  final String? error;
  final Idea? selectedIdea;

  AuthUiState({
    this.user,
    this.isLoading = false,
    this.error,
    this.selectedIdea,
  });

  get routes => null;

  AuthUiState copyWith({
    User? user,
    bool? isLoading,
    String? error,
    Idea? selectedIdea,
  }) {
    return AuthUiState(
      user: user ?? this.user,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      selectedIdea: selectedIdea ?? this.selectedIdea,
    );
  }
}

class AuthViewModel extends StateNotifier<AuthUiState> {
  final UserRepository _userRepository;

  AuthViewModel(this._userRepository) : super(AuthUiState());

  get user => state.user
      ?? User(email: '', name: '', id: '');
  get isLoading => state.isLoading;
  get error => state.error;

  Future<void> login(String email, String password) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final user = await _userRepository.login(email, password);
      state = state.copyWith(user: user, isLoading: false);
    } catch (e) {
      state = state.copyWith(error: e.toString(), isLoading: false);
    }
  }

  Future<void> register(String name, String email, String password) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final user = await _userRepository.register(name, email, password);
      state = state.copyWith(user: user, isLoading: false);
    } catch (e) {
      state = state.copyWith(error: e.toString(), isLoading: false);
    }
  }

  Future<void> logout() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      await _userRepository.logout();
      state = state.copyWith(user: null, isLoading: false);
    } catch (e) {
      state = state.copyWith(error: e.toString(), isLoading: false);
    }
  }

  Future<void> getCurrentUser() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final user = await _userRepository.getCurrentUser();
      state = state.copyWith(user: user, isLoading: false);
    } catch (e) {
      state = state.copyWith(error: e.toString(), isLoading: false);
    }
  }

  void selectIdea(Idea idea) {
    state = state.copyWith(selectedIdea: idea);
  }
} 