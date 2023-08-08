import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../models/family_member.dart';
import '../widgets/family_member_card.dart';
import '../services/family_member_service.dart';

class FamilyDirectoryPage extends StatefulWidget {
  @override
  _FamilyDirectoryPageState createState() => _FamilyDirectoryPageState();
}

class _FamilyDirectoryPageState extends State<FamilyDirectoryPage> {
  final ScrollController _scrollController = ScrollController();
  final familyMemberService =
      FamilyMemberService('http://akkalla.esy.es/app-api/get-members.php');
  List<FamilyMember> familyMembers = []; // List to hold all family members
  List<FamilyMember> _filteredFamilyMembers = []; // List to hold filtered family members
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchTextChanged);
    _fetchFamilyMembers();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.removeListener(_onSearchTextChanged);
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _fetchFamilyMembers() async {
    try {
      List<FamilyMember> fetchedFamilyMembers =
          await familyMemberService.getFamilyMembers();
      setState(() {
        familyMembers = fetchedFamilyMembers;
        _filteredFamilyMembers.addAll(familyMembers);
      });
    } catch (e) {
      print('Error fetching family members: $e');
    }
  }

  void _onSearchTextChanged() {
    String searchText = _searchController.text.toLowerCase();
    setState(() {
      _filteredFamilyMembers = familyMembers
          .where((familyMember) =>
              familyMember.name.toLowerCase().contains(searchText) ||
              familyMember.fatherName.toLowerCase().contains(searchText))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Set the background color to black
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              style: TextStyle(color: Colors.white), // Set text color to white
              cursorColor: Colors.white, // Set cursor color to white
              decoration: InputDecoration(
                hintText: 'Search',
                hintStyle: TextStyle(color: Colors.white), // Set hint color to white
                prefixIcon: Icon(
                  Icons.search,
                  color: Colors.white, // Set icon color to white
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              itemCount: (_filteredFamilyMembers.length / 3).ceil(),
              itemBuilder: (context, rowIndex) {
                final startIndex = rowIndex * 3;
                final endIndex =
                    (startIndex + 3).clamp(0, _filteredFamilyMembers.length);

                final rowFamilyMembers =
                    _filteredFamilyMembers.sublist(startIndex, endIndex);

                return Row(
                  children: rowFamilyMembers.map((familyMember) {
                    return Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: FamilyMemberCard(
                          familyMember: familyMember,
                        ),
                      ),
                    );
                  }).toList(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
