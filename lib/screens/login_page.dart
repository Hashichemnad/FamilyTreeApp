import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _mobileNumberController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String _errorText = '';

  Future<void> _login() async {
    final String mobileNumber = _mobileNumberController.text;
    final String password = _passwordController.text;

    if (mobileNumber.isEmpty || password.isEmpty) {
      setState(() {
        _errorText = 'Mobile number and password are required';
      });
      return;
    }

    if (!_isValidMobileNumber(mobileNumber)) {
      setState(() {
        _errorText = 'Invalid mobile number format';
      });
      return;
    }

    final String apiUrl = AppConstants.validateLogin;

    try {
      final response = await http.post(Uri.parse(apiUrl), body: {
        'mobileNumber': mobileNumber,
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
        final jsonResponse = json.decode(response.body);
        final errorMsg = jsonResponse['response']; 
        setState(() {
          _errorText = errorMsg;
        });
      }
    } catch (error) {
      setState(() {
        _errorText = 'An error occurred. Please try again later.';
      });
    }
  }

  bool _isValidMobileNumber(String mobileNumber) {
    if(mobileNumber.length>8 && mobileNumber.length<12){
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset(
              'assets/images/logo.png',
              height: 30,
            ),
            const SizedBox(width: 8),
            const Text('Family Tree'),
          ],
        ),
        backgroundColor: Colors.green[800],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: TextFormField(
                controller: _mobileNumberController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  labelText: 'Mobile Number',
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
            SizedBox(height: 8),
            if (_errorText.isNotEmpty)
              Text(
                _errorText,
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 14,
                ),
              ),
            SizedBox(height: 16),
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
