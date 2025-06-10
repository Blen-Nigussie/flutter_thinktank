import 'package:flutter/material.dart';
import '../models/idea.dart';

class EditFeedbackScreen extends StatefulWidget {
  final Idea idea;
  final String currentFeedback;
  final Function(String) onSave;
  final VoidCallback onBack;
  final bool isLoading;
  final String? error;

  const EditFeedbackScreen({
    Key? key,
    required this.idea,
    required this.currentFeedback,
    required this.onSave,
    required this.onBack,
    this.isLoading = false,
    this.error,
  }) : super(key: key);

  @override
  State<EditFeedbackScreen> createState() => _EditFeedbackScreenState();
}

class _EditFeedbackScreenState extends State<EditFeedbackScreen> {
  late TextEditingController _feedbackController;
  bool _showError = false;

  @override
  void initState() {
    super.initState();
    _feedbackController = TextEditingController(text: widget.currentFeedback);
  }

  @override
  void dispose() {
    _feedbackController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Edit Feedback",
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color(0xFF1E1E1E),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            FocusScope.of(context).unfocus();
            widget.onBack();
          },
        ),
      ),
      backgroundColor: const Color(0xFF121212),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Card(
                  color: const Color(0xFF1E1E1E),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.idea.title,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          widget.idea.description,
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.7),
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _feedbackController,
                  decoration: InputDecoration(
                    labelText: "Feedback",
                    labelStyle: const TextStyle(color: Colors.white),
                    errorText: _showError ? "Feedback cannot be empty" : null,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                        color: Colors.white.withOpacity(0.5),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(
                        color: Color(0xFFFFA500),
                      ),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: Colors.red),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: Colors.red),
                    ),
                  ),
                  style: const TextStyle(color: Colors.white),
                  maxLines: null,
                  minLines: 3,
                  enabled: !widget.isLoading,
                ),
                if (widget.error != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                      widget.error!,
                      style: const TextStyle(color: Colors.red),
                    ),
                  ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: widget.isLoading
                        ? null
                        : () {
                            FocusScope.of(context).unfocus();
                            if (_feedbackController.text.trim().isNotEmpty) {
                              widget.onSave(_feedbackController.text);
                            } else {
                              setState(() {
                                _showError = true;
                              });
                            }
                          },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFFA500),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: widget.isLoading
                        ? const SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(
                              color: Colors.black,
                              strokeWidth: 2,
                            ),
                          )
                        : const Text(
                            "Save Feedback",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  ),
                ),
              ],
            ),
          ),
          if (widget.isLoading)
            Container(
              color: Colors.black.withOpacity(0.5),
              child: const Center(
                child: CircularProgressIndicator(
                  color: Color(0xFFFFA500),
                ),
              ),
            ),
        ],
      ),
    );
  }
} 