import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import '../screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // Initialize Firebase
  runApp(const FamilyTreeApp());
}

class FamilyTreeApp extends StatelessWidget {
  const FamilyTreeApp({super.key});

  @override
  Widget build(BuildContext context) {
    _configureFCM(); // Call the function to configure FCM

    return MaterialApp(
      title: 'AKKALLA FAMILY',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }

  void _configureFCM() {
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    FirebaseMessaging.instance.getToken().then((String? token) {
      print("Device Token: $token");
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      // Handle foreground notification
      print("Foreground Notification: $message");
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      // Handle notification when app is in background and opened
      print("Notification Opened: $message");
    });
  }

  Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
    // Handle background notification
    print("Background Notification: $message");
  }
}
