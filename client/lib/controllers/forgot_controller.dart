import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_intro/model/user.dart';
import 'package:flutter_intro/ui_views/login_views.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ForgotPasswordController extends GetxController {
  TextEditingController emailController = TextEditingController();
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<void> loginWithEmail() async {
    try {
      print(emailController.text);
      final response = await http.post(
        Uri.parse('http://10.0.2.2:8000/token'),
        headers: <String, String>{
          'Accept': 'application/json',
          'Content-Type': 'application/x-www-form-urlencoded;charset=UTF-8',
        },
        body: {
          'grant_type': 'password',
          'code': '1',
          'username': emailController.text,
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body.toString());
        var accessToken = data['access_token'];
        var tokenType = data['token_type'];

        final loginResponse = await http.get(
            Uri.parse('http://10.0.2.2:8000/login'),
            headers: <String, String>{
              'Authorization': '$tokenType $accessToken'
            });

        if (loginResponse.statusCode == 200) {
          final Map<String, dynamic> userdata = jsonDecode(loginResponse.body);
          print(userdata);
          print('encode');
          print(userdata);

          // User userData = User.fromJson(jsonDecode(loginResponse.body));
          // print('userData here');
          // print(userData);

          final SharedPreferences? prefs = await _prefs;

          await prefs?.setString('user_data', jsonEncode(userdata));
          await prefs?.setString('token', accessToken);
          await prefs?.setString('first_name', userdata['firstname']);
          await prefs?.setString('last_name', userdata['lastname']);
          emailController.clear();

          //Go to Home
          Get.off(() => WelcomePage());
        } else {
          // If the server did not return a 201 CREATED response,
          // then throw an exception.
          throw jsonDecode(response.body)['Message'] ??
              "Unknown Error Occurred";
        }
      } else {
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
