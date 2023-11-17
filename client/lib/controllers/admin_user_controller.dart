import 'dart:convert';

// Local import
import 'package:flutter/material.dart';
import 'package:flutter_intro/model/admin.dart';
import 'package:flutter_intro/model/user.dart';
import 'package:flutter_intro/utils/api_endpoints.dart';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:rflutter_alert/rflutter_alert.dart';

class AdminUserController extends GetxController {
  String baseUrl = ApiEndPoints.checkPlatform();
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

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

  Future<List<User>> fetchAllUsers() async {
    String? token = await getToken();
    String? token_type = await getTokenType();

    // get 2 months
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/admin/user/'),
        headers: <String, String>{
          'Accept': 'application/json',
          'Authorization': '$token_type $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        List<dynamic> usersList = json.decode(response.body);
        List<User> users = <User>[];
        usersList.forEach((element) {
          users.add(User.fromJson(element));
        });

        return users;
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

  Future<List<String>> fetchServiceStats() async {
    String? token = await getToken();
    String? token_type = await getTokenType();

    // get 2 months
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/admin/'),
        headers: <String, String>{
          'Accept': 'application/json',
          'Authorization': '$token_type $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> myMap = json.decode(response.body);
        Map<String, dynamic> serviceMap = myMap["services_percentages"];
        List<String> serviceList = [];
        print("Stats");
        serviceList.add(serviceMap["OCCUPATIONAL_THERAPY"].toString());
        serviceList.add(serviceMap["PSYCHIATRIC_CONSULTATION"].toString());
        serviceList.add(serviceMap["COUNSELING"].toString());
        serviceList.add(serviceMap["PSYCHOLOGICAL_ASSESMENT"].toString());

        return serviceList;
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
