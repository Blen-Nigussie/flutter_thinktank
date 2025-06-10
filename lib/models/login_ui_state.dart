class LoginUiState {
  final String email;
  final String password;
  final bool isLoading;
  final String? error;

  LoginUiState({
    this.email = '',
    this.password = '',
    this.isLoading = false,
    this.error,
  });

  LoginUiState copyWith({
    String? email,
    String? password,
    bool? isLoading,
    String? error,
  }) {
    return LoginUiState(
      email: email ?? this.email,
      password: password ?? this.password,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
} 