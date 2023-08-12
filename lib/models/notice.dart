class Notice {
  final String id;
  final String title;
  final String date;
  final String details;

  Notice({
    required this.id,
    required this.title,
    required this.date,
    required this.details,
  });

  factory Notice.fromJson(Map<String, dynamic> json) {
    return Notice(
      id: json['id'],
      title: json['title'],
      date: json['date'],
      details: json['details'],
    );
  }
}
