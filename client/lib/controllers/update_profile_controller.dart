// Standart import
import 'dart:convert';
import 'package:flutter/material.dart';

// Local import
import 'package:flutter_intro/model/user.dart';
import 'package:flutter_intro/ui_views/dashboard_profile.dart';
import 'package:flutter_intro/ui_views/forum_myposts.dart';
import 'package:flutter_intro/utils/api_endpoints.dart';

// Third-party import
import 'package:get/get.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class UpdateProfileController extends GetxController {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
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

  _showSuccessDialog(context, successMessage) {
    Alert(
      context: context,
      //style: alertStyle,
      type: AlertType.success,
      title: "Success",
      desc: successMessage,
      buttons: [
        DialogButton(
          child: Text(
            "OK",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => Navigator.of(context, rootNavigator: true).pop(),
          color: Color.fromRGBO(0, 179, 134, 1.0),
          radius: BorderRadius.circular(0.0),
        ),
      ],
    ).show();
  }

  _showErrorDialog(context, errorMessage) {
    Alert(
      context: context,
      //style: alertStyle,
      type: AlertType.error,
      title: "Error",
      desc: errorMessage,
      buttons: [
        DialogButton(
          child: Text(
            "OK",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => Navigator.push(
              context, MaterialPageRoute(builder: ((context) => ProfileTab()))),
          color: Colors.redAccent,
          radius: BorderRadius.circular(0.0),
        ),
      ],
    ).show();
  }

  Future<User> updateProfile(
      String firstName, String lastName, String userName) async {
    String? token = await getToken();
    String? token_type = await getTokenType();

    try {
      final response = await http.post(
        Uri.parse('$baseUrl/user/updateprofile'),
        headers: <String, String>{
          'Accept': 'application/json',
          'Authorization': '$token_type $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "firstname": firstName,
          "lastname": lastName,
          "username": userName,
        }),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> userdata = jsonDecode(response.body);

        final SharedPreferences? prefs = await _prefs;
        await prefs?.setString('user_data', jsonEncode(userdata));
        await prefs?.setString('first_name', userdata['firstname']);
        await prefs?.setString('last_name', userdata['lastname']);
        await prefs?.setString('username', userdata['username']);
        await Future.delayed(Duration(seconds: 2));
        return User.fromJson(userdata);

        // _showSuccessDialog(
        //     Get.context!, "User Profile Details are successfully saved!");
        //go to home
        //Get.off(() => ProfileTab());
      } else {
        _showErrorDialog(
            Get.context!, "This request cannot be processed right now");
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
