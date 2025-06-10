class EditProfileUiState {
  final String firstName;
  final String lastName;
  final String email;
  final String? profilePicture;
  final bool isLoading;
  final String? error;
  final bool saveSuccess;

  EditProfileUiState({
    this.firstName = '',
    this.lastName = '',
    this.email = '',
    this.profilePicture,
    this.isLoading = false,
    this.error,
    this.saveSuccess = false,
  });

  EditProfileUiState copyWith({
    String? firstName,
    String? lastName,
    String? email,
    String? profilePicture,
    bool? isLoading,
    String? error,
    bool? saveSuccess,
  }) {
    return EditProfileUiState(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      profilePicture: profilePicture ?? this.profilePicture,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      saveSuccess: saveSuccess ?? this.saveSuccess,
    );
  }
} 