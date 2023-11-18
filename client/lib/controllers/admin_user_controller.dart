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

  _showSuccessDialog(context, successMessage, onpressed) {
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
          onPressed: () => {
            Navigator.of(context, rootNavigator: true).pop(),
            onpressed(),
          },
          color: Color.fromRGBO(0, 179, 134, 1.0),
          radius: BorderRadius.circular(0.0),
        ),
      ],
    ).show();
  }

  Future<void> deleteUser(int id, VoidCallback pressed) async {
    String? token = await getToken();
    String? token_type = await getTokenType();

    try {
      final response = await http.delete(
        Uri.parse('$baseUrl/admin/user/$id'),
        headers: <String, String>{
          'Accept': 'application/json',
          'Authorization': '$token_type $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        _showSuccessDialog(Get.context!, "User successfully deleted", pressed);
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

  Future<void> restoreUser(String email, VoidCallback pressed) async {
    String? token = await getToken();
    String? token_type = await getTokenType();

    try {
      final response = await http.post(
        Uri.parse('$baseUrl/admin/archive/recover/?email=$email'),
        headers: <String, String>{
          'Accept': 'application/json',
          'Authorization': '$token_type $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "email": email,
        }),
      );

      if (response.statusCode == 200) {
        _showSuccessDialog(Get.context!, "User successfully restored", pressed);
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

  Future<void> unbanUser(int id, VoidCallback pressed) async {
    String? token = await getToken();
    String? token_type = await getTokenType();

    try {
      final response = await http.post(
        Uri.parse('$baseUrl/admin/user/$id/unban/'),
        headers: <String, String>{
          'Accept': 'application/json',
          'Authorization': '$token_type $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        _showSuccessDialog(Get.context!, "User successfully unbanned", pressed);
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

  Future<List<User>> fetchAllArchivedUsers() async {
    String? token = await getToken();
    String? token_type = await getTokenType();

    // get 2 months
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/admin/archive/'),
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

  Future<List<User>> fetchAllBannedUsers() async {
    String? token = await getToken();
    String? token_type = await getTokenType();

    // get 2 months
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/admin/user/banned/all/'),
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
}
