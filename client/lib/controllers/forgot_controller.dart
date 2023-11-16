import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_intro/ui_views/login_views.dart';
import 'package:flutter_intro/utils/api_endpoints.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ForgotPasswordController extends GetxController {
  TextEditingController passwordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  String baseUrl = ApiEndPoints.checkPlatform();

  Future<void> changePasswordWithEmail(String email) async {
    try {
      print(
          "Debug Change Password, email:$email password ${passwordController.text}");
      final response = await http.post(
        Uri.parse('$baseUrl/user/forgotpassword'),
        headers: <String, String>{
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "new_password": passwordController.text,
          "user_email": email,
        }),
      );

      if (response.statusCode == 200) {
        //Go to Change Password Success page
        print("Debug Changed Password successfully");
        Get.off(() => ChangePasswordSuccessPage());
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
