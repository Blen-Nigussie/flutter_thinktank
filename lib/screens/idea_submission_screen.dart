import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/idea_submission_view_model.dart';

class IdeaSubmissionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => IdeaSubmissionViewModel(),
      child: IdeaSubmissionContent(),
    );
  }
}

class IdeaSubmissionContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<IdeaSubmissionViewModel>(context);
    final uiState = viewModel.uiState;

    return Scaffold(
      body: Container(
        color: Color(0xFF1A1A1A),
        padding: EdgeInsets.all(16),
        child: Stack(
          children: [
            Column(
              children: [
                // Top Bar
                Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                      child: IconButton(
                        icon: Icon(Icons.arrow_back, color: Colors.white),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ),
                    SizedBox(width: 16),
                    Text(
                      'Submit Your Idea',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 24),

                // Light Bulb Image
                Image.asset(
                  'assets/images/bulb_image.png',
                  width: 200,
                  height: 200,
                ),

                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        // Title Field
                        TextField(
                          onChanged: viewModel.onTitleChange,
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            labelText: 'Title',
                            labelStyle: TextStyle(color: Colors.white),
                            filled: true,
                            fillColor: Color(0xFF2A2A2A),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: Color(0xFFFFA500)),
                            ),
                            helperText: 'Minimum 3 characters',
                            helperStyle: TextStyle(
                              color: uiState.title.length < 3 && uiState.title.isNotEmpty
                                  ? Color(0xFFFF5252)
                                  : Colors.grey,
                              fontSize: 12,
                            ),
                          ),
                        ),
                        SizedBox(height: 16),

                        // Description Field
                        TextField(
                          onChanged: viewModel.onDescriptionChange,
                          style: TextStyle(color: Colors.white),
                          maxLines: 5,
                          decoration: InputDecoration(
                            labelText: 'Description',
                            labelStyle: TextStyle(color: Colors.white),
                            filled: true,
                            fillColor: Color(0xFF2A2A2A),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: Color(0xFFFFA500)),
                            ),
                            helperText: 'Minimum 10 characters',
                            helperStyle: TextStyle(
                              color: uiState.description.length < 10 && uiState.description.isNotEmpty
                                  ? Color(0xFFFF5252)
                                  : Colors.grey,
                              fontSize: 12,
                            ),
                          ),
                        ),
                        SizedBox(height: 16),

                        // Tags Field
                        TextField(
                          onChanged: viewModel.onTagsChange,
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            labelText: 'Tags (optional)',
                            labelStyle: TextStyle(color: Colors.white),
                            filled: true,
                            fillColor: Color(0xFF2A2A2A),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: Color(0xFFFFA500)),
                            ),
                            helperText: 'Separate tags with commas',
                            helperStyle: TextStyle(color: Colors.grey, fontSize: 12),
                          ),
                        ),
                        SizedBox(height: 16),

                        // Error Message
                        if (uiState.error != null)
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Color(0xFFFF5252).withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              uiState.error!,
                              style: TextStyle(color: Color(0xFFFF5252), fontSize: 14),
                            ),
                          ),
                        SizedBox(height: 16),

                        // Submit Button
                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: uiState.isSubmitting ? null : viewModel.onSubmitIdea,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFFFFA500),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: uiState.isSubmitting
                                ? SizedBox(
                                    width: 24,
                                    height: 24,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                    ),
                                  )
                                : Text(
                                    'Submit Idea',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            // Success Overlay
            if (uiState.submissionSuccess)
              Container(
                color: Colors.black.withOpacity(0.7),
                child: Center(
                  child: Container(
                    margin: EdgeInsets.all(32),
                    padding: EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Color(0xFF4CAF50),
                      borderRadius: BorderRadius.circular(16),
                    ),
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
                          'Idea Submitted Successfully!',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Redirecting to ideas page...',
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