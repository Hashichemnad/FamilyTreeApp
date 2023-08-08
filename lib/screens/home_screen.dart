import 'package:flutter/material.dart';
import 'family_directory_screen.dart';
import 'family_tree_screen.dart';
import 'updates_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    FamilyDirectoryPage(),
    FamilyTreePage(familyMemberId: "1",),
    UpdatesPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset(
              'images/logo.png', // Path to your logo image
              height: 30, // Adjust the logo height as needed
            ),
            const SizedBox(width: 8), // Add some spacing between the logo and title
            const Text('AKKALLA FAMILY'),
          ],
        ),
        backgroundColor: Colors.green[800], // You can also change the background color of the AppBar
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
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
      ),
    );
  }

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
