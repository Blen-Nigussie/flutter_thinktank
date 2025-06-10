import 'package:flutter/material.dart';

class LogoutScreen extends StatelessWidget {
  final VoidCallback onLogoutConfirm;

  LogoutScreen({required this.onLogoutConfirm});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black,
        padding: EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/bulb_image.png',
              width: 200,
              height: 200,
            ),
            SizedBox(height: 50),
            Text(
              'Logged out',
              style: TextStyle(fontSize: 40, color: Colors.white),
            ),
            SizedBox(height: 50),
            Text(
              'Thank you for using Think Tank',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.white),
            ),
            SizedBox(height: 24),
            ElevatedButton(
              onPressed: onLogoutConfirm,
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xCCD9D9D9),
                minimumSize: Size(200, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                'Sign in again',
                style: TextStyle(fontSize: 20, color: Colors.black),
              ),
            ),
            SizedBox(height: 20),
            Text(
              'See you later',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Color(0xFFFFA500)),
            ),
          ],
        ),
      ),
    );
  }
} 