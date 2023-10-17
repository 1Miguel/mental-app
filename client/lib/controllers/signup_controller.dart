// Standard import
import 'dart:convert';
import 'package:flutter/material.dart';

// Local import
import 'package:flutter_intro/ui_views/login_views.dart';
import 'package:flutter_intro/utils/api_endpoints.dart';

// Third-party import
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class SignupController extends GetxController {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  String loginUrl = ApiEndPoints.checkPlatform();

  Future<void> registerWithEmail() async {
    try {
      final response = await http.post(
        Uri.parse('$loginUrl/signup'),
        headers: <String, String>{
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'email': emailController.text,
          'password': passwordController.text,
          'firstname': firstNameController.text,
          'lastname': lastNameController.text,
        }),
      );

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        // final SharedPreferences? prefs = await _prefs;

        // await prefs?.setString('token', token);
        firstNameController.clear();
        lastNameController.clear();
        emailController.clear();
        passwordController.clear();
        //go to home
        Get.off(() => SignupSuccessPage());
      } else if (response.statusCode == 409) {
        throw jsonDecode(response.body)['Message'] ?? "Account already exists";
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
