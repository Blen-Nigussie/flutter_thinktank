import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/edit_idea_view_model.dart';

class EditIdeaScreen extends StatelessWidget {
  final String ideaId;

  const EditIdeaScreen({
    Key? key,
    required this.ideaId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => EditIdeaViewModel()..loadIdea(ideaId),
      child: EditIdeaContent(),
    );
  }
}

class EditIdeaContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<EditIdeaViewModel>(context);
    final uiState = viewModel.uiState;

    return Scaffold(
      body: Container(
        color: Colors.black,
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            // Top Bar
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () => Navigator.pop(context),
                ),
                Text(
                  'Edit Idea',
                  style: TextStyle(
                    color: Color(0xFFFFA500),
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: 40), // For balance
              ],
            ),
            SizedBox(height: 24),

            if (uiState.isLoading)
              Expanded(
                child: Center(
                  child: CircularProgressIndicator(
                    color: Color(0xFFFFA500),
                  ),
                ),
              )
            else
              Expanded(
                child: Column(
                  children: [
                    TextField(
                      onChanged: viewModel.onTitleChange,
                      controller: TextEditingController(text: uiState.title),
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        labelText: 'Title',
                        labelStyle: TextStyle(color: Colors.grey),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFFFFA500)),
                        ),
                        focusedLabelStyle: TextStyle(color: Color(0xFFFFA500)),
                      ),
                    ),
                    SizedBox(height: 16),

                    TextField(
                      onChanged: viewModel.onDescriptionChange,
                      controller: TextEditingController(text: uiState.description),
                      style: TextStyle(color: Colors.white),
                      maxLines: 3,
                      decoration: InputDecoration(
                        labelText: 'Description',
                        labelStyle: TextStyle(color: Colors.grey),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFFFFA500)),
                        ),
                        focusedLabelStyle: TextStyle(color: Color(0xFFFFA500)),
                      ),
                    ),
                    SizedBox(height: 16),

                    TextField(
                      onChanged: viewModel.onTagsChange,
                      controller: TextEditingController(text: uiState.tags ?? ''),
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        labelText: 'Tags (comma-separated)',
                        labelStyle: TextStyle(color: Colors.grey),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFFFFA500)),
                        ),
                        focusedLabelStyle: TextStyle(color: Color(0xFFFFA500)),
                      ),
                    ),
                    SizedBox(height: 24),

                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: uiState.isUpdating ? null : viewModel.onUpdateIdea,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFFFFA500),
                        ),
                        child: uiState.isUpdating
                            ? SizedBox(
                                width: 24,
                                height: 24,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                ),
                              )
                            : Text(
                                'Update Idea',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                      ),
                    ),
                  ],
                ),
              ),

            if (uiState.error != null)
              Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  uiState.error!,
                  style: TextStyle(color: Colors.red),
                ),
              ),

            if (uiState.updateSuccess)
              Container(
                color: Colors.black.withOpacity(0.7),
                child: Center(
                  child: Container(
                    margin: EdgeInsets.all(32),
                    decoration: BoxDecoration(
                      color: Color(0xFF4CAF50),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    padding: EdgeInsets.all(24),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.check_circle,
                          color: Colors.white,
                          size: 48,
                        ),
                        SizedBox(height: 16),
                        Text(
                          'Idea Updated Successfully!',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Redirecting back...',
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.8),
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
} 