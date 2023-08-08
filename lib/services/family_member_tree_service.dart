import 'dart:convert';

import 'package:http/http.dart' as http;
import '../models/family_tree_member.dart';

class FamilyMemberTreeService {
  final String apiUrl;

  FamilyMemberTreeService(this.apiUrl);

  Future<FamilyTreeMember> getFamilyTreeMemberDetails(String memberId) async {
    final response = await http.get(Uri.parse('$apiUrl?id=$memberId'));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      return FamilyTreeMember.fromJson(jsonData);
    } else {
      throw Exception('Failed to fetch family member details');
    }
  }
}
