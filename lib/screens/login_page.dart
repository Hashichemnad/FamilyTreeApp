import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _login() async {
    final String username = _usernameController.text;
    final String password = _passwordController.text;

    // Replace with your PHP API URL for login
    final String apiUrl = 'http://akkalla.esy.es/app-api/get-validate-login.php';

    try {
      final response = await http.post(Uri.parse(apiUrl), body: {
        'username': username,
        'password': password,
      });
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        final sessionId = jsonResponse['sessionId']; 
        final isApproved = jsonResponse['isApproved'];
        final prefs = await SharedPreferences.getInstance();
        prefs.setString('session_id', sessionId);
        prefs.setString('isapproved', isApproved);
        
        Navigator.pushReplacementNamed(context, '/home');
      } else {
        // Failed to log in, show an error message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Login failed. Please check your credentials.')),
        );
      }
    } catch (error) {
      print('Login error: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Akkalla Family'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: TextFormField(
                controller: _usernameController,
                decoration: InputDecoration(
                  labelText: 'Username',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            SizedBox(height: 16),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            SizedBox(height: 24),
            ElevatedButton(
              onPressed: _login,
              child: Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
