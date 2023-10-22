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
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class MembershipController extends GetxController {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  String loginUrl = ApiEndPoints.checkPlatform();

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

  Future<void> registerMembership(String filename) async {
    String? token = await getToken();
    String? token_type = await getTokenType();

    try {
      Map<String, String> headersList = {
        'Accept': 'application/json',
        'Authorization': '$token_type $token',
        'Content-Type': 'application/json'
      };
      Map<String, String> dataList = {
        'membership_api': "{'membership_type': 0}"
      };
      var request = http.MultipartRequest(
          'POST', Uri.parse('$baseUrl/user/membership/register'));
      request.headers.addAll(headersList);
      request.fields.addAll(dataList);
      request.files.add(http.MultipartFile('files',
          File(filename).readAsBytes().asStream(), File(filename).lengthSync(),
          filename: filename.split("/").last));

      var response = await request.send();

      if (response.statusCode == 200) {
        // final json = jsonDecode(response.body);
        // // final SharedPreferences? prefs = await _prefs;

        // // await prefs?.setString('token', token);
        // firstNameController.clear();
        // lastNameController.clear();
        // emailController.clear();
        // passwordController.clear();
        // //go to home
        // Get.off(() => SignupSuccessPage());
      } else {
        throw "Unknown Error Occurred";
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
