// Standard import
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

// Local import
import 'package:flutter_intro/ui_views/login_views.dart';
import 'package:flutter_intro/utils/api_endpoints.dart';
import 'package:flutter_intro/ui_views/admin_navigation_views.dart';

// Third-party import
import 'package:get/get.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:onesignal_flutter/onesignal_flutter.dart';

class LoginController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  String loginUrl = ApiEndPoints.checkPlatform();

  _showErrorAlert(context) {
    Alert(
      context: context,
      type: AlertType.error,
      title: "Login Error",
      desc: "Unauthorized Login",
      buttons: [
        DialogButton(
          onPressed: () {
            Navigator.of(context, rootNavigator: true).pop();
            //Navigator.of(context, rootNavigator: true).pop();
          },
          child: Text(
            "OK",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        )
      ],
    ).show();
  }

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

          String _userId = userdata['id'].toString();
          String _externalUserId = "userId_$_userId";
          print("Debug OneSignal Set External ID: $_externalUserId");
          OneSignal.login(_externalUserId);
          bool isBanned = false;

          if (userdata['status'] == "BANNED") {
            isBanned = true;
          }

          await prefs?.setString('user_data', jsonEncode(userdata));
          await prefs?.setString('token', accessToken);
          await prefs?.setString('token_type', tokenType);
          await prefs?.setInt('id', userdata['id']);
          await prefs?.setString('first_name', userdata['firstname']);
          await prefs?.setString('last_name', userdata['lastname']);
          await prefs?.setString('username', userdata['username']);
          await prefs?.setString('dateCreated', userdata['created']);
          await prefs?.setString('status', userdata['status']);
          await prefs?.setBool('is_admin', userdata['is_admin']);
          await prefs?.setBool('is_super', userdata['is_super']);
          await prefs?.setBool('islogged_in', true);
          await prefs?.setBool('isbanned', isBanned);

          if (userdata['email'] == "admin0@mentalapp.com" ||
              userdata['email'] == "superadmin0@mentalapp.com") {
            // emailController.clear();
            // passwordController.clear();
            var context = Get.context!;
            Navigator.push(
                context, MaterialPageRoute(builder: ((context) => AdminApp())));
            //Get.to(() => AdminApp());
          } else {
            //Go to Home
            if (kIsWeb) {
              // emailController.clear();
              // passwordController.clear();
              await prefs?.setBool('islogged_in', false);
              prefs?.remove("islogged_in");
              Get.off(() => LoginMainPage());
            } else {
              // emailController.clear();
              // passwordController.clear();
              Get.off(() => WelcomePage());
            }
          }
        } else {
          // If the server did not return a 201 CREATED response,
          // then throw an exception.
          Get.off(() => LoginMainPage());
          throw jsonDecode(response.body)['Message'] ??
              "Unknown Error Occurred";
        }
      } else if (response.statusCode == 401) {
        _showErrorAlert(Get.context!);
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
