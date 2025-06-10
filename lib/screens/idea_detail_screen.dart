import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/providers/idea_view_model_provider.dart';

class IdeaDetailScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ideaState = ref.watch(ideaViewModelProvider);

    final idea = ideaState.selectedIdea;
    if (idea == null) {
      return Scaffold(
        appBar: AppBar(title: Text('Idea Detail')),
        body: Center(child: Text('No idea selected')),
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text('Idea Detail')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(idea.title, style: Theme.of(context).textTheme.headline6),
            SizedBox(height: 8),
            Text(idea.description),
            // Add more fields as needed
          ],
        ),
      ),
    );
  }
} 