import 'package:intl/intl.dart';

class Notification {
  final String title;
  final String content;
  final String date;
  final bool read;

  const Notification({
    required this.title,
    required this.content,
    required this.date,
    required this.read,
  });

  factory Notification.fromJson(Map<String, dynamic> json) {
    String def_title;
    String def_content;
    String def_date;
    bool def_read;

    def_title = json['title'] ?? '';
    def_content = json['content'] ?? '';
    def_date = json['start_time'] ?? DateTime.now().toString();
    def_read = json['read'] ?? false;

    String formattedDate = DateFormat('yyyy-MM-ddTHH:mm')
        .format(DateTime.parse(def_date))
        .toString();

    return Notification(
      title: def_title as String,
      content: def_content as String,
      date: formattedDate as String,
      read: def_read as bool,
    );
  }
}
