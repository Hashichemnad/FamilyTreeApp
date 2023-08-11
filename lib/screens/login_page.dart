import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../services/auth_service.dart'; // Import the AuthService

class LoginPage extends StatelessWidget {
  final AuthService _authService = AuthService(); // Create an instance of AuthService

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            // Sign in with Google
            final User? user = await _authService.signInWithGoogle();

            // Check if sign-in was successful
            if (user != null) {
              Navigator.of(context).pushReplacementNamed('/home');
            }
          },
          child: Text('Sign in with Google'),
        ),
      ),
    );
  }
}
