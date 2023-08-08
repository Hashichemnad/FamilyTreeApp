import 'package:flutter/material.dart';
import '../models/family_tree_member.dart';

class FamilyTreeMemberCard extends StatelessWidget {
  final FamilyTreeMember familyTreeMember;

  FamilyTreeMemberCard({required this.familyTreeMember});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color.fromRGBO(199, 199, 199, 1),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Container(
        height: 160, // Fixed height for the card
        child: Row(
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage(familyTreeMember.profileImageUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    familyTreeMember.name,
                    style: TextStyle(
                      color: Color.fromRGBO(46, 125, 50, 1),
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(
                        Icons.phone,
                        color: Colors.black,
                        size: 16,
                      ),
                      SizedBox(width: 4),
                      Text(
                        familyTreeMember.contact,
                        style: TextStyle(
                          color: Color.fromRGBO(46, 125, 50, 1),
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(
                        Icons.school,
                        color: Colors.black,
                        size: 16,
                      ),
                      SizedBox(width: 4),
                      Text(
                        familyTreeMember.education,
                        style: TextStyle(
                          color: Color.fromRGBO(46, 125, 50, 1),
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(
                        Icons.message,
                        color: Colors.black,
                        size: 16,
                      ),
                      SizedBox(width: 4),
                      Text(
                        familyTreeMember.whatsapp,
                        style: TextStyle(
                          color: Color.fromRGBO(46, 125, 50, 1),
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(
                        Icons.calendar_today,
                        color: Colors.black,
                        size: 16,
                      ),
                      SizedBox(width: 4),
                      Text(
                        familyTreeMember.age,
                        style: TextStyle(
                          color: Color.fromRGBO(46, 125, 50, 1),
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
