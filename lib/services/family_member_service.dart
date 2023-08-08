import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/family_member.dart';

class FamilyMemberService {
  final String apiUrl; // Add the apiUrl parameter to the class

  FamilyMemberService(this.apiUrl); // Constructor that takes the apiUrl as a parameter

  Future<List<FamilyMember>> getFamilyMembers() async {
    try {
      final response = await http.get(Uri.parse(apiUrl)); // Use the apiUrl here
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        List<FamilyMember> familyMembers = [];
        for (var item in jsonData) {
          FamilyMember familyMember = FamilyMember.fromJson(item);
          familyMembers.add(familyMember);
        }
        return familyMembers;
      } else {
        throw Exception('Failed to fetch family members');
      }
    } catch (error) {
      throw Exception('Error fetching family members: $error');
    }
  }

}
