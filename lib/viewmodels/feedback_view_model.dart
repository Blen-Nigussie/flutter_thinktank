import 'package:flutter/material.dart';
import '../core/models/idea.dart';
import '../core/viewmodels/auth_view_model.dart';
import '../core/services/feedback_services.dart';

class FeedbackViewModel extends ChangeNotifier {
  final FeedbackServices feedbackServices;
  FeedbackViewModel({FeedbackServices? feedbackServices})
      : feedbackServices = feedbackServices ?? FeedbackServices();

  // Define your state and methods here

  void selectIdea(Idea idea) {
    // Logic to select an idea for feedback
    AuthUiState authState = AuthUiState();
    authState = authState.copyWith(selectedIdea: idea); 
    // This could involve setting the selected idea in state
    // and notifying listeners to update the UI
    notifyListeners();
  }
}