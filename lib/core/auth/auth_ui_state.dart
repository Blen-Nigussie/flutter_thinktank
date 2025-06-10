class AuthUiState {
  final String email;
  final String password;
  final String user;

  AuthUiState({this.email = '', this.password = '', this.user = ''});
  AuthUiState copyWith({String? email, String? password, String? user}) {
    return AuthUiState(
      email: email ?? this.email,
      password: password ?? this.password,
      user: user ?? this.user,
    );
  }

  @override
  String toString() {
    return 'AuthUiState(email: $email, password: $password, user: $user)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;
    final AuthUiState otherState = other as AuthUiState;
    return otherState.email == email &&
        otherState.password == password &&
        otherState.user == user;
  }

  bool get isAuthenticated {
    // Replace this logic with your actual authentication check
    // For example, if you have a user property:
    // return user != null && user.isNotEmpty;
    return user.isNotEmpty;
  }

  @override
  int get hashCode => email.hashCode ^ password.hashCode ^ user.hashCode;
}