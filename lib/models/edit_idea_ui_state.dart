class EditIdeaUiState {
  final String ideaId;
  final String title;
  final String description;
  final String? tags;
  final bool isLoading;
  final bool isUpdating;
  final bool updateSuccess;
  final String? error;

  EditIdeaUiState({
    this.ideaId = '',
    this.title = '',
    this.description = '',
    this.tags,
    this.isLoading = false,
    this.isUpdating = false,
    this.updateSuccess = false,
    this.error,
  });

  EditIdeaUiState copyWith({
    String? ideaId,
    String? title,
    String? description,
    String? tags,
    bool? isLoading,
    bool? isUpdating,
    bool? updateSuccess,
    String? error,
  }) {
    return EditIdeaUiState(
      ideaId: ideaId ?? this.ideaId,
      title: title ?? this.title,
      description: description ?? this.description,
      tags: tags ?? this.tags,
      isLoading: isLoading ?? this.isLoading,
      isUpdating: isUpdating ?? this.isUpdating,
      updateSuccess: updateSuccess ?? this.updateSuccess,
      error: error ?? this.error,
    );
  }
} 