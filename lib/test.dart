import 'package:flutter/material.dart';
import 'family_directory_screen.dart';
import 'family_tree_screen.dart';
import 'updates_screen.dart';
import 'login_page.dart'; // Import the LoginPage
import '../services/auth_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  bool _isAuthenticated = false;

  @override
  void initState() {
    super.initState();
    _checkAuthentication();
  }

  Future<void> _checkAuthentication() async {
    bool isAuthenticated = await AuthService().isAuthenticated();
    setState(() {
      _isAuthenticated = isAuthenticated;
    });
  }

  final List<Widget> _pages = [
    FamilyDirectoryPage(),
    FamilyTreePage(familyMemberId: "1"),
    UpdatesPage(),
  ];

  @override
  Widget build(BuildContext context) {
    if (!_isAuthenticated) {
      return LoginPage(); // Redirect to LoginPage if not authenticated
    }

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset(
              'images/logo.png',
              height: 30,
            ),
            const SizedBox(width: 8),
            const Text('AKKALLA FAMILY'),
          ],
        ),
        backgroundColor: Colors.green[800],
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: _isAuthenticated
          ? BottomNavigationBar(
              currentIndex: _currentIndex,
              onTap: _onTabTapped,
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.group),
                  label: 'Family Directory',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.family_restroom),
                  label: 'Family Tree',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.update),
                  label: 'Updates',
                ),
              ],
            )
          : null, // Hide the bottom navigation bar if not authenticated
    );
  }

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
