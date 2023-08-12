import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../models/family_tree_member.dart';

class FamilyMemberTreeService {
  final String apiUrl;

  FamilyMemberTreeService(this.apiUrl);

  Future<FamilyTreeMember> getFamilyTreeMemberDetails(String memberId) async {
      final prefs = await SharedPreferences.getInstance();
      final sessionId = prefs.getString('session_id') ?? '';
      final response = await http.post(Uri.parse('$apiUrl?id=$memberId'), body: {
        'sessionId': sessionId,
      });

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      return FamilyTreeMember.fromJson(jsonData);
    } else {
        prefs.setString('isapproved', '');
        prefs.setString('session_id', '');
      throw Exception('Failed to fetch family member details');
    }
  }
}
