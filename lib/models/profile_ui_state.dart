import 'idea.dart';
import 'status.dart';

class ProfileUiState {
  final String userName;
  final String email;
  final String bio;
  final Status status;
  final List<Idea> submittedIdeas;
  final bool isFeedbackExpanded;
  final String feedback;
  final bool isDrawerOpen;
  final bool isLoading;
  final String? error;

  ProfileUiState({
    this.userName = '',
    this.email = '',
    this.bio = '',
    this.status = Status.PENDING,
    this.submittedIdeas = const [],
    this.isFeedbackExpanded = false,
    this.feedback = '',
    this.isDrawerOpen = false,
    this.isLoading = false,
    this.error,
  });

  ProfileUiState copyWith({
    String? userName,
    String? email,
    String? bio,
    Status? status,
    List<Idea>? submittedIdeas,
    bool? isFeedbackExpanded,
    String? feedback,
    bool? isDrawerOpen,
    bool? isLoading,
    String? error,
  }) {
    return ProfileUiState(
      userName: userName ?? this.userName,
      email: email ?? this.email,
      bio: bio ?? this.bio,
      status: status ?? this.status,
      submittedIdeas: submittedIdeas ?? this.submittedIdeas,
      isFeedbackExpanded: isFeedbackExpanded ?? this.isFeedbackExpanded,
      feedback: feedback ?? this.feedback,
      isDrawerOpen: isDrawerOpen ?? this.isDrawerOpen,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
} 