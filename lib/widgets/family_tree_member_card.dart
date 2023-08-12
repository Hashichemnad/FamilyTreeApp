import 'package:flutter/material.dart';
import '../models/family_tree_member.dart';
import 'package:cached_network_image/cached_network_image.dart';

class FamilyTreeMemberCard extends StatelessWidget {
  final FamilyTreeMember familyTreeMember;

  FamilyTreeMemberCard({required this.familyTreeMember});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.green[800],
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
              child: CachedNetworkImage(
                  imageUrl: familyTreeMember.profileImageUrl,
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
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                  children: [
                  Text(
                    familyTreeMember.name,
                    style: TextStyle(
                      color: Color(0xFFFCFCFC),
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(width: 8),
                  Text(
                    familyTreeMember.familyId,
                    style: TextStyle(
                      color: Color(0xFFFCFCFC),
                      fontWeight: FontWeight.normal,
                      fontSize: 15,
                    ),
                  ),
                  ],
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
                          color: Colors.white,
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
                          color: Colors.white,
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
                          color: Colors.white,
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
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(
                        Icons.bloodtype,
                        color: Colors.black,
                        size: 16,
                      ),
                      SizedBox(width: 4),
                      Text(
                        familyTreeMember.blood,
                        style: TextStyle(
                          color: Colors.white,
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
