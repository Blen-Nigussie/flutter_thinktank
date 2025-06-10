import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/my_ideas_view_model.dart';
import '../models/idea.dart';
import '../models/idea_status.dart';

class MyIdeasScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyIdeasViewModel(),
      child: MyIdeasContent(),
    );
  }
}

class MyIdeasContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<MyIdeasViewModel>(context);
    final uiState = viewModel.uiState;

    return Scaffold(
      body: Container(
        color: Colors.black,
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            _buildTopBar(context),
            SizedBox(height: 24),
            if (uiState.isLoading)
              Center(child: CircularProgressIndicator(color: Color(0xFFFFA500)))
            else if (uiState.ideas.isEmpty)
              _buildEmptyState()
            else
              Expanded(
                child: ListView.builder(
                  itemCount: uiState.ideas.length,
                  itemBuilder: (context, index) {
                    return _buildIdeaCard(uiState.ideas[index], viewModel);
                  },
                ),
              ),
            if (uiState.error != null)
              SnackBar(content: Text(uiState.error!)),
          ],
        ),
      ),
    );
  }

  Widget _buildTopBar(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        Text(
          'My Ideas',
          style: TextStyle(fontSize: 24, color: Color(0xFFFFA500), fontWeight: FontWeight.bold),
        ),
        SizedBox(width: 40),
      ],
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.edit, color: Color(0xFFFFA500), size: 64),
          SizedBox(height: 16),
          Text(
            'No ideas yet',
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          Text(
            'Start sharing your ideas!',
            style: TextStyle(color: Colors.grey, fontSize: 16),
          ),
        ],
      ),
    );
  }

  Widget _buildIdeaCard(Idea idea, MyIdeasViewModel viewModel) {
    return Card(
      color: Color(0xFF2A2A2A),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
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
                    style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.edit, color: Color(0xFFFFA500)),
                      onPressed: () => viewModel.onEditIdea(idea),
                    ),
                    IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () => viewModel.deleteIdea(idea.id),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 8),
            Text(
              idea.description,
              style: TextStyle(color: Colors.white, fontSize: 14),
            ),
            SizedBox(height: 8),
            _buildStatusChip(idea.status),
            SizedBox(height: 8),
            if (idea.tags.isNotEmpty)
              Wrap(
                spacing: 8,
                children: idea.tags.map((tag) => Chip(
                  label: Text(tag, style: TextStyle(color: Color(0xFFFFA500))),
                  backgroundColor: Color(0xFFFFA500).withOpacity(0.1),
                )).toList(),
              ),
            SizedBox(height: 8),
            Text(
              'Created: ${idea.createdAt}',
              style: TextStyle(color: Colors.grey, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusChip(String status) {
    final ideaStatus = IdeaStatus.fromString(status);
    Color chipColor;
    Color textColor;

    switch (ideaStatus) {
      case IdeaStatus.PENDING:
        chipColor = Color(0xFFFFA500).withOpacity(0.1);
        textColor = Color(0xFFFFA500);
        break;
      case IdeaStatus.APPROVED:
        chipColor = Color(0xFF4CAF50).withOpacity(0.1);
        textColor = Color(0xFF4CAF50);
        break;
      case IdeaStatus.REJECTED:
        chipColor = Color(0xFFFF5252).withOpacity(0.1);
        textColor = Color(0xFFFF5252);
        break;
      default:
        chipColor = Colors.grey.withOpacity(0.1);
        textColor = Colors.grey;
    }

    return Chip(
      label: Text(ideaStatus.name, style: TextStyle(color: textColor)),
      backgroundColor: chipColor,
    );
  }
} 