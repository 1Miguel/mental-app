// Standard import
import 'dart:convert';
import 'package:flutter/material.dart';

// Local import
import 'package:flutter_intro/ui_views/login_views.dart';
import 'package:flutter_intro/utils/api_endpoints.dart';
import 'package:flutter_intro/ui_views/admin_navigation_views.dart';

// Third-party import
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class LoginController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  String loginUrl = ApiEndPoints.checkPlatform();

  Future<void> loginWithEmail() async {
    try {
      final response = await http.post(
        Uri.parse('$loginUrl/token'),
        headers: <String, String>{
          'Accept': 'application/json',
          'Content-Type': 'application/x-www-form-urlencoded;charset=UTF-8',
        },
        body: {
          'grant_type': 'password',
          'code': '1',
          'username': emailController.text,
          'password': passwordController.text,
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body.toString());
        var accessToken = data['access_token'];
        var tokenType = data['token_type'];

        final loginResponse = await http.get(Uri.parse('$loginUrl/login'),
            headers: <String, String>{
              'Authorization': '$tokenType $accessToken'
            });

        if (loginResponse.statusCode == 200) {
          final Map<String, dynamic> userdata = jsonDecode(loginResponse.body);

          final SharedPreferences? prefs = await _prefs;

          await prefs?.setString('user_data', jsonEncode(userdata));
          await prefs?.setString('token', accessToken);
          await prefs?.setString('token_type', tokenType);
          await prefs?.setString('first_name', userdata['firstname']);
          await prefs?.setString('last_name', userdata['lastname']);
          await prefs?.setString('islogged_in', "true");
          emailController.clear();
          passwordController.clear();

          if (userdata['email'] == "admin0@mentalapp.com") {
            Get.off(() => AdminApp());
          } else {
            //Go to Home
            Get.off(() => WelcomePage());
          }
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
