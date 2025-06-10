import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import '../viewmodels/edit_profile_view_model.dart';

class EditProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => EditProfileViewModel(),
      child: EditProfileContent(),
    );
  }
}

class EditProfileContent extends StatelessWidget {
  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<EditProfileViewModel>(context);
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
                  'Edit Profile',
                  style: TextStyle(
                    fontSize: 24,
                    color: Color(0xFFFFA500),
                  ),
                ),
                SizedBox(width: 40), // For balance
              ],
            ),
            SizedBox(height: 24),

            // Profile Picture
            GestureDetector(
              onTap: () async {
                final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
                if (image != null) {
                  viewModel.uploadProfilePicture(image.path);
                }
              },
              child: Stack(
                children: [
                  Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Color(0xFFFFA500),
                        width: 2,
                      ),
                    ),
                    child: ClipOval(
                      child: uiState.profilePicture != null
                          ? Image.network(
                              uiState.profilePicture!,
                              fit: BoxFit.cover,
                            )
                          : Image.asset(
                              'assets/images/user_profile_icon.png',
                              fit: BoxFit.cover,
                            ),
                    ),
                  ),
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: Container(
                      padding: EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Colors.black,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.edit,
                        color: Color(0xFFFFA500),
                        size: 24,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 24),

            // Form Fields
            TextField(
              onChanged: (value) => viewModel.onFieldChange((state) => state.copyWith(firstName: value)),
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'First Name',
                labelStyle: TextStyle(color: Colors.white),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFFFA500)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFFFA500)),
                ),
                focusedLabelStyle: TextStyle(color: Color(0xFFFFA500)),
              ),
            ),
            SizedBox(height: 16),

            TextField(
              onChanged: (value) => viewModel.onFieldChange((state) => state.copyWith(lastName: value)),
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'Last Name',
                labelStyle: TextStyle(color: Colors.white),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFFFA500)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFFFA500)),
                ),
                focusedLabelStyle: TextStyle(color: Color(0xFFFFA500)),
              ),
            ),
            SizedBox(height: 16),

            TextField(
              onChanged: (value) => viewModel.onFieldChange((state) => state.copyWith(email: value)),
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'Email',
                labelStyle: TextStyle(color: Colors.white),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFFFA500)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFFFA500)),
                ),
                focusedLabelStyle: TextStyle(color: Color(0xFFFFA500)),
              ),
            ),
            SizedBox(height: 24),

            // Error Message
            if (uiState.error != null)
              Text(
                uiState.error!,
                style: TextStyle(color: Colors.red),
              ),

            // Save Button
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: uiState.isLoading ? null : viewModel.onSaveChanges,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFFFA500),
                ),
                child: uiState.isLoading
                    ? SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                        ),
                      )
                    : Text(
                        'Save Changes',
                        style: TextStyle(color: Colors.white),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
} 