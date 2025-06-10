import 'package:flutter/material.dart';

class LandingPage extends StatelessWidget {
  final VoidCallback onNavigateToSignup;
  final VoidCallback onNavigateToLogin;

  LandingPage({required this.onNavigateToSignup, required this.onNavigateToLogin});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/landing_page_lightbulb.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  ElevatedButton(
                    onPressed: onNavigateToLogin,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFFAA60C),
                      minimumSize: Size(270, 70),
                    ),
                    child: Text(
                      'Login',
                      style: TextStyle(fontSize: 26, color: Colors.black),
                    ),
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: onNavigateToSignup,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFFAA60C),
                      minimumSize: Size(270, 70),
                    ),
                    child: Text(
                      'Register',
                      style: TextStyle(fontSize: 26, color: Colors.black),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 64),
            Text(
              'ThinkTank Inspire the world!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFFFAA60C),
              ),
            ),
          ],
        ),
      ),
    );
  }
} 