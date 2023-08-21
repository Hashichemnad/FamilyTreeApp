import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants.dart';

class ApprovalPage extends StatefulWidget {
  @override
  _ApprovalPageState createState() => _ApprovalPageState();
}

class _ApprovalPageState extends State<ApprovalPage> {


    @override
  void initState() {
    super.initState();
    _approval();
  }

  Future<void> _approval() async {

    // Replace with your PHP API URL for login
    final String apiUrl = AppConstants.validateSession;
    final prefs = await SharedPreferences.getInstance();
    final sessionId = prefs.getString('session_id') ?? ''; 

    try {
      final response = await http.post(Uri.parse(apiUrl), body: {
        'sessionId': sessionId,
      });
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        final code = jsonResponse['code']; 
        final isApproved = jsonResponse['isApproved'];
        if(code=='200'){
          prefs.setString('isapproved', isApproved);
          if(isApproved=='1'){
            Navigator.pushReplacementNamed(context, '/home');
          }
        }
        else{
          prefs.setString('isapproved', isApproved);
          prefs.setString('session_id', '');
          Navigator.pushReplacementNamed(context, '/home');
        }
        
        
        
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
          children:[
            Text("App will open after approve by admin"),
          ]
          
        ),
      ),
    );
  }
}
