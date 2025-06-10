import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/providers/idea_view_model_provider.dart';

class IdeaListScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ideaState = ref.watch(ideaViewModelProvider);
    final ideaViewModel = ref.read(ideaViewModelProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: Text('Ideas')),
      body: RefreshIndicator(
        onRefresh: () => ideaViewModel.loadIdeas(),
        child: ideaState.isLoading
            ? Center(child: CircularProgressIndicator())
            : ideaState.error != null
                ? Center(child: Text(ideaState.error!))
                : ListView.builder(
                    itemCount: ideaState.ideas.length,
                    itemBuilder: (context, index) {
                      final idea = ideaState.ideas[index];
                      return ListTile(
                        title: Text(idea.title),
                        subtitle: Text(idea.description),
                        onTap: () {
                          ideaViewModel.selectIdea(idea.id);
                          Navigator.pushNamed(context, '/ideas/detail');
                        },
                      );
                    },
                  ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to idea creation screen
        },
        child: Icon(Icons.add),
      ),
    );
  }
} 