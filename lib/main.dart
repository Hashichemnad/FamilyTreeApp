import 'package:flutter/material.dart';
import '../screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const FamilyTreeApp());
}

class FamilyTreeApp extends StatelessWidget {
  const FamilyTreeApp({super.key});

  @override
  Widget build(BuildContext context) {
    // _configureFCM(); // Call the function to configure FCM

    return MaterialApp(
      title: 'AKKALLA FAMILY',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: HomeScreen(),
      debugShowCheckedModeBanner: false,
      routes: {
        '/home': (context) => HomeScreen(),
      },
    );
  }
}
