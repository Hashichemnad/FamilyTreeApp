import 'package:flutter/material.dart';
import '../models/family_tree_member.dart';
import '../widgets/family_tree_member_card.dart';
import '../services/family_member_tree_service.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../constants.dart';

class FamilyTreePage extends StatefulWidget {
  final String familyMemberId;

  FamilyTreePage({required this.familyMemberId});

  @override
  _FamilyTreePageState createState() => _FamilyTreePageState();
}

class _FamilyTreePageState extends State<FamilyTreePage> {
  late Future<FamilyTreeMember> _familyTreeMemberFuture;
  final FamilyMemberTreeService familyMemberTreeService = FamilyMemberTreeService(AppConstants.getMemberTree);

  @override
  void initState() {
    super.initState();
    _familyTreeMemberFuture = _fetchFamilyTreeMemberDetails();
  }

  Future<FamilyTreeMember> _fetchFamilyTreeMemberDetails() async {
    try {
      return await familyMemberTreeService.getFamilyTreeMemberDetails(widget.familyMemberId);
    } catch (e) {
      print('Error fetching family member details: $e');
      throw e;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                if (Navigator.canPop(context))
                  IconButton(
                    color: Colors.white,
                    icon: Icon(Icons.arrow_back),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                
                Spacer(), // Adds a flexible space
                if (Navigator.canPop(context))
                  IconButton(
                    color: Colors.white,
                    icon: Icon(Icons.home),
                    onPressed: () {
                      Navigator.popUntil(context, (route) => route.isFirst);
                    },
                  ),
              ],
            ),
            Expanded(
              child: FutureBuilder<FamilyTreeMember>(
        future: _familyTreeMemberFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            final familyTreeMember = snapshot.data!;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 8), 
                FamilyTreeMemberCard(familyTreeMember: familyTreeMember),
                SizedBox(height: 8), 
                if (familyTreeMember.spouse != null) ...[
                  SpouseCard(spouse: familyTreeMember.spouse!),
                  SizedBox(height: 8),
                ],
                Text(
                  'CHILDRENS',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8), 
                Expanded(
                  child: ListView.builder(
                    itemCount: familyTreeMember.children.length,
                    itemBuilder: (context, index) {
                      return ChildrenCard(child: familyTreeMember.children[index]);
                    },
                  ),
                ),
              ],
            );
          }
        },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SpouseCard extends StatelessWidget {
  final FamilyTreeMember spouse;

  SpouseCard({required this.spouse});

  @override
  Widget build(BuildContext context) {
    return FamilyTreeMemberCard(familyTreeMember: spouse);
  }
}

class ChildrenCard extends StatelessWidget {
  final FamilyTreeMember child;

  ChildrenCard({required this.child});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // Navigate to the tree details of that child
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => FamilyTreePage(familyMemberId: child.id),
          ),
        );
      },
      child: Card(
        color: Color.fromRGBO(163, 163, 163, 1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Container(
          height: 80, // Fixed height for the card
          padding: EdgeInsets.all(8),
          child: Row(
            children: [
              Container(
                width: 64,
                height: 64,
                child: CachedNetworkImage(
                  imageUrl: child.profileImageUrl,
                  imageBuilder: (context, imageProvider) => Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  placeholder: (context, url) => CircularProgressIndicator(), // Show a loading indicator while loading the image
                  errorWidget: (context, url, error) => Icon(Icons.error), // Show an error icon if the image fails to load
                  fit: BoxFit.cover,
                ),
                
              ),
              SizedBox(width: 6),
              Expanded(
                child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                  children: [
                  Text(
                    child.name,
                    style: TextStyle(
                      color: Color(0xFFFCFCFC),
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(width: 8),
                  Text(
                    child.count,
                    style: TextStyle(
                      color: Color(0xFFFCFCFC),
                      fontWeight: FontWeight.normal,
                      fontSize: 15,
                    ),
                  ),
                  ],
                  ),
                ],
              ),
              ),
              Icon(
                Icons.arrow_forward,
                color: Colors.black,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
