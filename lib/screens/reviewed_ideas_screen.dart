import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/idea.dart';
import '../viewmodels/feedback_view_model.dart';

class ReviewedIdeasScreen extends StatelessWidget {
  final VoidCallback onBack;
  final Function(Idea) onEditFeedback;
  final Function(Idea) onDeleteFeedback;
  final bool isAdmin;

  const ReviewedIdeasScreen({
    Key? key,
    required this.onBack,
    required this.onEditFeedback,
    required this.onDeleteFeedback,
    required this.isAdmin,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Ideas with Feedback",
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color(0xFF1E1E1E),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: onBack,
        ),
      ),
      backgroundColor: const Color(0xFF121212),
      body: Consumer<FeedbackViewModel>(
        builder: (context, viewModel, _) {
          final uiState = viewModel.uiState;

          if (uiState.isLoading) {
            return const Center(
              child: CircularProgressIndicator(
                color: Color(0xFFFFA500),
              ),
            );
          }

          if (uiState.error != null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    uiState.error!,
                    style: const TextStyle(color: Colors.red),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: onBack,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFFA500),
                    ),
                    child: const Text("Go Back"),
                  ),
                ],
              ),
            );
          }

          if (uiState.ideas.isEmpty) {
            return const Center(
              child: Text(
                "No ideas with feedback found",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: uiState.ideas.length,
            itemBuilder: (context, index) {
              final idea = uiState.ideas[index];
              return Card(
                margin: const EdgeInsets.only(bottom: 16),
                color: const Color(0xFF1E1E1E),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              idea.title,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          if (isAdmin)
                            Row(
                              children: [
                                IconButton(
                                  onPressed: () => onEditFeedback(idea),
                                  icon: const Icon(
                                    Icons.edit,
                                    color: Color(0xFFFFA500),
                                    size: 20,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () => onDeleteFeedback(idea),
                                  icon: const Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                    size: 20,
                                  ),
                                ),
                              ],
                            ),
                        ],
                      ),
                      if (idea.user != null)
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          child: Text(
                            "Submitted by: ${idea.user!.firstName} ${idea.user!.lastName}",
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.7),
                              fontSize: 14,
                            ),
                          ),
                        ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Text(
                          idea.description,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      Card(
                        margin: const EdgeInsets.only(top: 8),
                        color: const Color(0xFF2A2A2A),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Feedback",
                                style: TextStyle(
                                  color: Color(0xFFFFA500),
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                idea.feedback?.firstOrNull?.comment ?? "No feedback provided",
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
} 