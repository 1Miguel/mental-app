// Standart import
import 'dart:convert';
import 'package:flutter/material.dart';

// Local import
import 'package:flutter_intro/model/user.dart';
import 'package:flutter_intro/utils/api_endpoints.dart';

// Third-party import
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class MoodController extends GetxController {
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

  Future<void> logMood(int mood) async {
    String? token = await getToken();
    String? token_type = await getTokenType();

    try {
      final response = await http.post(
        Uri.parse('$baseUrl/user/mood'),
        headers: <String, String>{
          'Accept': 'application/json',
          'Authorization': '$token_type $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "mood": 0,
          "note": "Feeling Sad",
        }),
      );

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        print(json);
        final SharedPreferences? prefs = await _prefs;
        final datenow = DateTime.now();
        final later = datenow.add(const Duration(hours: 24));

        await prefs?.setString('moodExpiryDate', later.toString());
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
    }
  }
}
