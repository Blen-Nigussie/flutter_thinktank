class IdeaSubmissionUiState {
  final String title;
  final String description;
  final String? tags;
  final bool isSubmitting;
  final bool submissionSuccess;
  final String? error;

  IdeaSubmissionUiState({
    this.title = '',
    this.description = '',
    this.tags,
    this.isSubmitting = false,
    this.submissionSuccess = false,
    this.error,
  });

  IdeaSubmissionUiState copyWith({
    String? title,
    String? description,
    String? tags,
    bool? isSubmitting,
    bool? submissionSuccess,
    String? error,
  }) {
    return IdeaSubmissionUiState(
      title: title ?? this.title,
      description: description ?? this.description,
      tags: tags ?? this.tags,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      submissionSuccess: submissionSuccess ?? this.submissionSuccess,
      error: error ?? this.error,
    );
  }
} 