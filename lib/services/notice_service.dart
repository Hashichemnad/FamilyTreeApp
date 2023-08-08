import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/notice.dart';

class NoticeService {
  final String baseUrl;

  NoticeService(this.baseUrl);

  Future<List<Notice>> getNoticeList() async {
    final response = await http.get(Uri.parse('$baseUrl/notices'));
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final List<Notice> notices = [];
      for (var item in jsonData) {
        notices.add(Notice.fromJson(item));
      }
      return notices;
    } else {
      throw Exception('Failed to fetch notice list');
    }
  }
}
