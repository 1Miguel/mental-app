// Standart import
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_intro/model/mood.dart';
import 'package:flutter_intro/model/thread.dart';

// Local import
import 'package:flutter_intro/model/user.dart';
import 'package:flutter_intro/ui_views/community_views.dart';
import 'package:flutter_intro/utils/api_endpoints.dart';

// Third-party import
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ThreadController extends GetxController {
  TextEditingController topicController = TextEditingController();
  TextEditingController contentController = TextEditingController();
  TextEditingController commentController = TextEditingController();
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  String baseUrl = ApiEndPoints.checkPlatform();

  Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? token = prefs.getString('token');
    return token;
  }

  Future<String?> getTokenType() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? token_type = prefs.getString('token_type');
    return token_type;
  }

  Future<List<ThreadComment>> fetchThreadComments(int threadId) async {
    String? token = await getToken();
    String? token_type = await getTokenType();

    try {
      final response = await http.get(
        Uri.parse('$baseUrl/user/thread/$threadId'),
        headers: <String, String>{
          'Accept': 'application/json',
          'Authorization': '$token_type $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> myMap = json.decode(response.body);
        List<dynamic> comment_list = myMap["comments"];
        List<ThreadComment> threadComments = <ThreadComment>[];

        comment_list.forEach((element) {
          threadComments.add(ThreadComment.fromJson(element));
        });

        return threadComments;

        // mood_list.forEach((element) {
        //   print(element);
        //   MoodList.add(Mood.fromJson(element));
        // });
        // print(MoodList);
        // return MoodList;

        // mood_list.forEach((mood) {
        //   (mood as Map<String, dynamic>).forEach((key, value) {
        //     print(key);
        //     (value as Map<String, dynamic>).forEach((key2, value2) {
        //       print(key2);
        //       print(value2);
        //     });
        //   });
        // });
        // print(jsonDecode(response.body));
        //return Mood.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
        // final SharedPreferences? prefs = await _prefs;
        // final datenow = DateTime.now();
        // final later = datenow.add(const Duration(hours: 24));

        //await prefs?.setString('moodExpiryDate', later.toString());
        //go to home
        //Get.off(() => SignupSuccessPage());
      } else {
        print(response.body);
        print(response.statusCode);
        throw jsonDecode(response.body)['Message'] ?? "Unknown Error Occurred";
      }
    } catch (e) {
      Get.back();
      showDialog(
          context: Get.context!,
          builder: (context) {
            return SimpleDialog(
              title: Text('Error!'),
              contentPadding: EdgeInsets.all(20),
              children: [Text(e.toString())],
            );
          });
      throw "Unknown Error Occurred";
    }
  }

  Future<List<Thread>> fetchThreads(int page) async {
    String? token = await getToken();
    String? token_type = await getTokenType();

    try {
      final response = await http.get(
        Uri.parse('$baseUrl/user/thread/$page/?limit=5'),
        headers: <String, String>{
          'Accept': 'application/json',
          'Authorization': '$token_type $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        List<dynamic> myMap = json.decode(response.body);
        List<Thread> ThreadList = <Thread>[];

        myMap.forEach((element) {
          print(element);
          ThreadList.add(Thread.fromJson(element));
        });

        return ThreadList;

        // mood_list.forEach((element) {
        //   print(element);
        //   MoodList.add(Mood.fromJson(element));
        // });
        // print(MoodList);
        // return MoodList;

        // mood_list.forEach((mood) {
        //   (mood as Map<String, dynamic>).forEach((key, value) {
        //     print(key);
        //     (value as Map<String, dynamic>).forEach((key2, value2) {
        //       print(key2);
        //       print(value2);
        //     });
        //   });
        // });
        // print(jsonDecode(response.body));
        //return Mood.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
        // final SharedPreferences? prefs = await _prefs;
        // final datenow = DateTime.now();
        // final later = datenow.add(const Duration(hours: 24));

        //await prefs?.setString('moodExpiryDate', later.toString());
        //go to home
        //Get.off(() => SignupSuccessPage());
      } else {
        print(response.body);
        print(response.statusCode);
        throw jsonDecode(response.body)['Message'] ?? "Unknown Error Occurred";
      }
    } catch (e) {
      Get.back();
      showDialog(
          context: Get.context!,
          builder: (context) {
            return SimpleDialog(
              title: Text('Error!'),
              contentPadding: EdgeInsets.all(20),
              children: [Text(e.toString())],
            );
          });
      throw "Unknown Error Occurred";
    }
  }

  Future<void> createPost() async {
    String? token = await getToken();
    String? token_type = await getTokenType();

    String myTopic = "This is a sample topic";
    String myNote = "This is a sample content";

    print(topicController.text);
    print(contentController.text);

    try {
      final response = await http.post(
        Uri.parse('$baseUrl/user/thread/submit'),
        headers: <String, String>{
          'Accept': 'application/json',
          'Authorization': '$token_type $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "topic": topicController.text,
          "content": contentController.text,
        }),
      );

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        print(json);
        final SharedPreferences? prefs = await _prefs;
        topicController.clear();
        contentController.clear();
        //go to home
        Get.off(() => CommunityMainpage());
      } else {
        print(response.body);
        print(response.statusCode);
        throw jsonDecode(response.body)['Message'] ?? "Unknown Error Occurred";
      }
    } catch (e) {
      Get.back();
      showDialog(
          context: Get.context!,
          builder: (context) {
            return SimpleDialog(
              title: Text('Error!'),
              contentPadding: EdgeInsets.all(20),
              children: [Text(e.toString())],
            );
          });
    }
  }

  Future<void> createComment(int threadId) async {
    String? token = await getToken();
    String? token_type = await getTokenType();

    try {
      final response = await http.post(
        Uri.parse('$baseUrl/user/thread/$threadId/comment/'),
        headers: <String, String>{
          'Accept': 'application/json',
          'Authorization': '$token_type $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "content": commentController.text,
        }),
      );

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        print(json);
        final SharedPreferences? prefs = await _prefs;
        commentController.clear();
        //go to home
        //Get.off(() => CommunityMainpage());
      } else {
        print(response.body);
        print(response.statusCode);
        throw jsonDecode(response.body)['Message'] ?? "Unknown Error Occurred";
      }
    } catch (e) {
      Get.back();
      showDialog(
          context: Get.context!,
          builder: (context) {
            return SimpleDialog(
              title: Text('Error!'),
              contentPadding: EdgeInsets.all(20),
              children: [Text(e.toString())],
            );
          });
    }
  }
}
