import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'family_tree_screen.dart';
import 'family_member_details_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(),
        '/familyTree': (context) => FamilyTreeScreen(),
        '/familyMemberDetails': (context) => FamilyMemberDetailsScreen(),
      },
    );
  }
}
