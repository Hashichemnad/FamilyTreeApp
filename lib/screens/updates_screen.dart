import 'package:flutter/material.dart';
import '../models/notice.dart'; // Import your Notice model
import '../services/notice_service.dart'; // Import your NoticeService

class UpdatesPage extends StatefulWidget {
  @override
  _UpdatesPageState createState() => _UpdatesPageState();
}

class _UpdatesPageState extends State<UpdatesPage> {
  late Future<List<Notice>> _noticeListFuture;
  final NoticeService _noticeService = NoticeService('http://akkalla.esy.es/app-api/get-notices.php');

  @override
  void initState() {
    super.initState();
    _noticeListFuture = _fetchNoticeList();
  }

  Future<List<Notice>> _fetchNoticeList() async {
    try {
      return await _noticeService.getNoticeList();
    } catch (e) {
      print('Error fetching notice list: $e');
      throw e;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: FutureBuilder<List<Notice>>(
        future: _noticeListFuture,
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
            final noticeList = snapshot.data!;
            return ListView.builder(
              itemCount: noticeList.length,
              itemBuilder: (context, index) {
                final notice = noticeList[index];
                return NoticeCard(notice: notice);
              },
            );
          }
        },
      ),
    );
  }
}

class NoticeCard extends StatelessWidget {
  final Notice notice;

  NoticeCard({required this.notice});

  @override
  Widget build(BuildContext context) {
    return Card(
      // Customize card appearance here
      child: ListTile(
        title: Text(notice.title),
        subtitle: Text(notice.date),
        onTap: () {
          // Handle tapping on the notice card (if needed)
        },
      ),
    );
  }
}
