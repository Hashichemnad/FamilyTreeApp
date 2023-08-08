import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'route_generator.dart';

void main() {
  runApp(const FamilyTreeApp());
}

class FamilyTreeApp extends StatelessWidget {
  const FamilyTreeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AKKALLA FAMILY',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      initialRoute: '/',
      onGenerateRoute: RouteGenerator.generateRoute,
      debugShowCheckedModeBanner: false,
    );
  }
}
