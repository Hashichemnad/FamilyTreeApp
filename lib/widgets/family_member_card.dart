import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';
import '../models/family_member.dart';
import 'package:cached_network_image/cached_network_image.dart';


class FamilyMemberCard extends StatelessWidget {
  final FamilyMember familyMember;

  const FamilyMemberCard({
    required this.familyMember,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _makePhoneCall(familyMember.contact); // Call the function to make the phone call
      },
      child: Card(
        color: Colors.black.withOpacity(0.7),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Container(
        height: 160, // Fixed height for the card
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 80,
              height: 80,
                child: CachedNetworkImage(
                  imageUrl: familyMember.profileImageUrl,
                  placeholder: (context, url) => CircularProgressIndicator(), // Show a loading indicator while loading the image
                  errorWidget: (context, url, error) => Icon(Icons.error), // Show an error icon if the image fails to load
                  fit: BoxFit.cover,
                ),
              ),
            
            SizedBox(height: 4),
            Text(
              familyMember.name,
              textAlign: TextAlign.center, // Center-align the name
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 2),
            Expanded( // Allow the bottom section to expand
              child: Text(
                familyMember.fatherName,
                textAlign: TextAlign.center, // Center-align the father's name
                style: TextStyle(
                  fontSize: 12,
                color: Colors.grey[300],
                ),
              ),
              ),
          ],
        ),
      ),
      ),
    );
  }

  void _makePhoneCall(String phoneNumber) async {
    final Uri phoneCallUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );

    if (await canLaunchUrlString(phoneCallUri.toString())) {
      await launchUrlString(phoneCallUri.toString());
    } else {
      throw 'Could not launch phone call: $phoneCallUri';
    }
  }
}
