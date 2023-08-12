import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/family_member.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FamilyMemberService {
  final String apiUrl; 
  FamilyMemberService(this.apiUrl); 

  Future<List<FamilyMember>> getFamilyMembers() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final sessionId = prefs.getString('session_id') ?? ''; 
      final response = await http.post(Uri.parse(apiUrl), body: {
        'sessionId': sessionId,
      });
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        List<FamilyMember> familyMembers = [];
        for (var item in jsonData) {
          FamilyMember familyMember = FamilyMember.fromJson(item);
          familyMembers.add(familyMember);
        }
        return familyMembers;
      } else {
          prefs.setString('isapproved', '');
          prefs.setString('session_id', '');
        throw Exception('Failed to fetch family members');
      }
    } catch (error) {
      throw Exception('Error fetching family members: $error');
    }
  }

}
