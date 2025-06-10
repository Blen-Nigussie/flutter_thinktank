import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/providers/feedback_view_model_provider.dart';

class FeedbackScreen extends ConsumerWidget {
  final TextEditingController commentController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final feedbackState = ref.watch(feedbackViewModelProvider);
    final feedbackViewModel = ref.read(feedbackViewModelProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: Text('Feedback')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: commentController,
              decoration: InputDecoration(labelText: 'Comment'),
            ),
            ElevatedButton(
              onPressed: feedbackState.isLoading
                  ? null
                  : () {
                      // You may want to pass the selected ideaId here
                      feedbackViewModel.createFeedback('ideaId', commentController.text);
                    },
              child: Text('Submit Feedback'),
            ),
            if (feedbackState.isLoading) CircularProgressIndicator(),
            if (feedbackState.error != null) Text(feedbackState.error!, style: TextStyle(color: Colors.red)),
            Expanded(
              child: ListView.builder(
                itemCount: feedbackState.feedbacks.length,
                itemBuilder: (context, index) {
                  final feedback = feedbackState.feedbacks[index];
                  return ListTile(
                    title: Text(feedback.comment),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
} 