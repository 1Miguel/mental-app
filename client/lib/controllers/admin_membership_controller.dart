// Standart import
import 'dart:convert';
import 'package:flutter/material.dart';

// Local import
import 'package:flutter_intro/utils/api_endpoints.dart';

// Third-party import
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:rflutter_alert/rflutter_alert.dart';

class AdminMembershipController extends GetxController {
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

  _showSuccessDialog(context) {
    Alert(
      context: context,
      //style: alertStyle,
      type: AlertType.success,
      title: "Success",
      desc: "Membership approved successfully",
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
          onPressed: () => Navigator.of(context, rootNavigator: true).pop(),
          color: Colors.redAccent,
          radius: BorderRadius.circular(0.0),
        ),
      ],
    ).show();
  }

  Future<void> approveMembership(int id) async {
    String? token = await getToken();
    String? token_type = await getTokenType();

    try {
      final response = await http.post(
        Uri.parse('$baseUrl/admin/membership/$id/set'),
        headers: <String, String>{
          'Accept': 'application/json',
          'Authorization': '$token_type $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "status": "ACTIVE",
        }),
      );

      if (response.statusCode == 200) {
        _showSuccessDialog(Get.context!);
      } else {
        _showErrorDialog(
            Get.context!, "This request cannot be processed right now");
        print(response.body);
        print(response.statusCode);
        throw jsonDecode(response.body)['Message'] ?? "Unknown Error Occurred";
      }
    } catch (e) {
      Get.back();
      _showErrorDialog(Get.context!, "Unknown Error Occurred");
      throw "Unknown Error Occurred";
    }
  }
}
