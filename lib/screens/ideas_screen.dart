import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/ideas_view_model.dart';
import '../models/idea.dart';
import 'package:intl/intl.dart';

class IdeasScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => IdeasViewModel()..loadIdeas(),
      child: IdeasContent(),
    );
  }
}

class IdeasContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<IdeasViewModel>(context);
    final uiState = viewModel.uiState;

    return Scaffold(
      body: Stack(
        children: [
          if (uiState.isLoading)
            Center(
              child: CircularProgressIndicator(
                color: Color(0xFFFFA500),
                strokeWidth: 3,
              ),
            )
          else if (uiState.ideas.isEmpty)
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.edit,
                    color: Color(0xFFFFA500),
                    size: 64,
                  ),
                  SizedBox(height: 16),
                  Text(
                    'No ideas yet',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    'Start sharing your ideas!',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            )
          else
            ListView.builder(
              padding: EdgeInsets.all(16),
              itemCount: uiState.ideas.length,
              itemBuilder: (context, index) {
                final idea = uiState.ideas[index];
                return Padding(
                  padding: EdgeInsets.only(bottom: 16),
                  child: IdeaCard(
                    idea: idea,
                    onEditClick: () => Navigator.pushNamed(
                      context,
                      '/edit_idea',
                      arguments: idea,
                    ),
                    onDeleteClick: () => viewModel.deleteIdea(idea.id),
                    isDeleting: uiState.isDeleting && uiState.deletingIdeaId == idea.id,
                  ),
                );
              },
            ),
          if (uiState.error != null)
            Positioned(
              bottom: 16,
              left: 16,
              right: 16,
              child: SnackBar(
                content: Text(uiState.error!),
                backgroundColor: Colors.red,
              ),
            ),
        ],
      ),
    );
  }
}

class IdeaCard extends StatelessWidget {
  final Idea idea;
  final VoidCallback onEditClick;
  final VoidCallback onDeleteClick;
  final bool isDeleting;

  const IdeaCard({
    Key? key,
    required this.idea,
    required this.onEditClick,
    required this.onDeleteClick,
    required this.isDeleting,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    idea.title,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Row(
                  children: [
                    IconButton(
                      onPressed: isDeleting ? null : onEditClick,
                      icon: Icon(Icons.edit),
                      color: Theme.of(context).primaryColor,
                    ),
                    IconButton(
                      onPressed: isDeleting ? null : onDeleteClick,
                      icon: isDeleting
                          ? SizedBox(
                              width: 24,
                              height: 24,
                              child: CircularProgressIndicator(
                                color: Theme.of(context).colorScheme.error,
                              ),
                            )
                          : Icon(Icons.delete),
                      color: Theme.of(context).colorScheme.error,
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 8),
            Text(
              idea.description,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 8),
            if (idea.tags.isNotEmpty)
              Wrap(
                spacing: 8,
                children: idea.tags.map((tag) {
                  return Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      tag,
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 12,
                      ),
                    ),
                  );
                }).toList(),
              ),
            SizedBox(height: 8),
            Text(
              'Created: ${_formatDate(idea.createdAt)}',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return DateFormat('MMM dd, yyyy').format(date);
  }
} 