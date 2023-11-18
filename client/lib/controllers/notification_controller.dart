// Standart import
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_intro/model/mood.dart';
import 'package:flutter_intro/model/notification.dart' as notifModel;
import 'package:flutter_intro/model/thread.dart';

// Local import
import 'package:flutter_intro/model/user.dart';
import 'package:flutter_intro/ui_views/community_views.dart';
import 'package:flutter_intro/utils/api_endpoints.dart';

// Third-party import
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class NotificationController extends GetxController {
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

  Future<List<notifModel.Notification>> fetchUserNotifications() async {
    String? token = await getToken();
    String? token_type = await getTokenType();

    try {
      final response = await http.get(
        Uri.parse('$baseUrl/user/notification/'),
        headers: <String, String>{
          'Accept': 'application/json',
          'Authorization': '$token_type $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        List<dynamic> myMap = json.decode(response.body);
        List<notifModel.Notification> notifList = <notifModel.Notification>[];

        myMap.forEach((element) {
          notifList.add(notifModel.Notification.fromJson(element));
        });

        return notifList;
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

  Future<void> readNotification(int id) async {
    String? token = await getToken();
    String? token_type = await getTokenType();

    try {
      final response = await http.get(
        Uri.parse('$baseUrl/user/notification/$id'),
        headers: <String, String>{
          'Accept': 'application/json',
          'Authorization': '$token_type $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
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
}
