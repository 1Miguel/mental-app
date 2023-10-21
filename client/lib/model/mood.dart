import 'package:get/get.dart';

class Mood {
  final int mood;
  final String note;
  final String date;

  const Mood({
    required this.mood,
    required this.note,
    required this.date,
  });

  factory Mood.fromJson(Map<String, dynamic> json) {
    int def_mood;
    String def_note;
    String def_date;

    def_mood = json['mood'] ?? 0;
    def_note = json['note'] ?? '';
    def_date = json['date'] ?? DateTime.now().toString();

    return Mood(
      mood: def_mood as int,
      note: def_note as String,
      date: def_date as String,
    );
  }
}
