import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/idea.dart';
import '../viewmodels/feedback_view_model.dart';

class IdeaPoolListScreen extends StatelessWidget {
  final Function(Idea) onReviewIdea;
  final VoidCallback onViewReviewedIdeas;
  final VoidCallback onBack;

  const IdeaPoolListScreen({
    Key? key,
    required this.onReviewIdea,
    required this.onViewReviewedIdeas,
    required this.onBack,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Review Submitted Ideas",
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFFFFA500)),
          onPressed: onBack,
        ),
        actions: [
          TextButton(
            onPressed: onViewReviewedIdeas,
            child: const Text(
              "View Reviewed",
              style: TextStyle(
                color: Color(0xFFFFA500),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      backgroundColor: Colors.black,
      body: Consumer<FeedbackViewModel>(
        builder: (context, viewModel, _) {
          final ideas = viewModel.uiState.ideas;

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: ideas.length,
            itemBuilder: (context, index) {
              final idea = ideas[index];
              return Card(
                margin: const EdgeInsets.only(bottom: 16),
                elevation: 8,
                color: const Color(0xFF1A1A1A),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        idea.title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        idea.description,
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.8),
                          fontSize: 16,
                          height: 1.5,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Submitted by: ${idea.user?.firstName ?? "Unknown"} ${idea.user?.lastName ?? ""}",
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.7),
                              fontSize: 14,
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () => onReviewIdea(idea),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFFFA500),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              minimumSize: const Size(120, 40),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: const [
                                Icon(Icons.rate_review, color: Colors.black),
                                SizedBox(width: 8),
                                Text(
                                  "Review",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
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