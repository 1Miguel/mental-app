import 'package:intl/intl.dart';

class Notification {
  final int id;
  final String title;
  final String content;
  final String date;
  final bool read;

  const Notification({
    required this.id,
    required this.title,
    required this.content,
    required this.date,
    required this.read,
  });

  factory Notification.fromJson(Map<String, dynamic> json) {
    int def_notifId;
    String def_title;
    String def_content;
    String def_date;
    bool def_read;

    def_notifId = json['id'] ?? 0;
    def_title = json['title'] ?? '';
    def_content = json['message'] ?? '';
    def_date = json['created'] ?? DateTime.now().toString();
    def_read = json['is_read'] ?? false;

    String formattedDate = DateFormat('yyyy-MM-ddTHH:mm')
        .format(DateTime.parse(def_date))
        .toString();

    return Notification(
      id: def_notifId as int,
      title: def_title as String,
      content: def_content as String,
      date: formattedDate as String,
      read: def_read as bool,
    );
  }
}
