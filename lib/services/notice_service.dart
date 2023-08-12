import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/notice.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NoticeService {
  final String baseUrl;

  NoticeService(this.baseUrl);

  Future<List<Notice>> getNoticeList() async {
      final prefs = await SharedPreferences.getInstance();
      final sessionId = prefs.getString('session_id') ?? '';
    final response = await http.post(Uri.parse('$baseUrl'), body: {
        'sessionId': sessionId,
      });
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final List<Notice> notices = [];
      for (var item in jsonData) {
        notices.add(Notice.fromJson(item));
      }
      return notices;
    } else {
        prefs.setString('isapproved', '');
        prefs.setString('session_id', '');
      throw Exception('Failed to fetch notice list');
    }
  }
}
