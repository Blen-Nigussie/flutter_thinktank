import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/register_view_model.dart';

class RegisterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => RegisterViewModel(),
      child: RegisterContent(),
    );
  }
}

class RegisterContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<RegisterViewModel>(context);

    return Scaffold(
      body: Container(
        color: Colors.black,
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                SizedBox(height: 85),
                Image.asset(
                  'assets/register_image.png',
                  width: 550,
                  height: 250,
                ),
                SizedBox(height: 23),
                Text(
                  'Register and Unleash Your Creativity!',
                  style: TextStyle(fontSize: 22, color: Color(0xFFFFA60C)),
                ),
              ],
            ),
            Column(
              children: [
                TextField(
                  onChanged: viewModel.updateFirstName,
                  decoration: InputDecoration(
                    labelText: 'Firstname:',
                    labelStyle: TextStyle(color: Colors.white),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFFFAA60C)),
                    ),
                  ),
                  style: TextStyle(color: Color(0xFFFAA60C), fontSize: 22),
                ),
                SizedBox(height: 12),
                TextField(
                  onChanged: viewModel.updateLastName,
                  decoration: InputDecoration(
                    labelText: 'Lastname:',
                    labelStyle: TextStyle(color: Colors.white),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFFFAA60C)),
                    ),
                  ),
                  style: TextStyle(color: Color(0xFFFAA60C), fontSize: 22),
                ),
                SizedBox(height: 12),
                TextField(
                  onChanged: viewModel.updateEmail,
                  decoration: InputDecoration(
                    labelText: 'Email:',
                    labelStyle: TextStyle(color: Colors.white),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFFFAA60C)),
                    ),
                  ),
                  style: TextStyle(color: Color(0xFFFAA60C), fontSize: 22),
                ),
                SizedBox(height: 12),
                TextField(
                  onChanged: viewModel.updatePassword,
                  decoration: InputDecoration(
                    labelText: 'Password:',
                    labelStyle: TextStyle(color: Colors.white),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFFFAA60C)),
                    ),
                  ),
                  style: TextStyle(color: Color(0xFFFAA60C), fontSize: 22),
                  obscureText: true,
                ),
                SizedBox(height: 8),
                if (viewModel.registrationError != null)
                  Text(
                    viewModel.registrationError!,
                    style: TextStyle(fontSize: 16, color: Colors.red),
                  ),
                SizedBox(height: 8),
                ElevatedButton(
                  onPressed: viewModel.isRegistering ? null : viewModel.register,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFFAA60C),
                    minimumSize: Size(250, 50),
                  ),
                  child: viewModel.isRegistering
                      ? CircularProgressIndicator(color: Colors.white)
                      : Text('Register', style: TextStyle(fontSize: 18)),
                ),
                SizedBox(height: 8),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/login');
                  },
                  child: Text(
                    'Already have an account? Login',
                    style: TextStyle(fontSize: 16, color: Color(0xFFFAA60C)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
} 