import 'package:get/get.dart';

class ThreadComment {
  final String creator;
  final String date;
  final String content;

  const ThreadComment({
    required this.creator,
    required this.date,
    required this.content,
  });

  factory ThreadComment.fromJson(Map<String, dynamic> json) {
    String def_creator;
    String def_date;
    String def_content;

    def_creator = json['creator'] ?? 'anonymous';
    def_date = json['date_created'] ?? DateTime.now().toString();
    def_content = json['content'] ?? '';

    return ThreadComment(
      creator: def_creator as String,
      date: def_date as String,
      content: def_content as String,
    );
  }
}

class Thread {
  final int threadId;
  final String topic;
  final String content;
  final String creator;
  final String date;
  //final List<ThreadComment> comments;

  const Thread({
    required this.threadId,
    required this.topic,
    required this.content,
    required this.creator,
    required this.date,
    //required this.comments,
  });

  factory Thread.fromJson(Map<String, dynamic> json) {
    int def_threadId;
    String def_topic;
    String def_content;
    String def_creator;
    String def_date;
    //List<ThreadComment> def_comments;

    def_threadId = json['thread_id'] ?? 0;
    def_topic = json['topic'] ?? '';
    def_content = json['content'] ?? '';
    def_creator = json['creator'] ?? '';
    def_date = json['date'] ?? '';
    //def_comments = json['comments'] ?? [];

    return Thread(
      threadId: def_threadId as int,
      topic: def_topic as String,
      content: def_content as String,
      creator: def_creator as String,
      date: def_date as String,
      //comments: def_comments as List<ThreadComment>,
    );
  }
}
