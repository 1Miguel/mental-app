// Standart import
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_intro/model/appointment.dart';
import 'package:intl/intl.dart';

// Local import
import 'package:flutter_intro/ui_views/book_appointment.dart';
import 'package:flutter_intro/utils/api_endpoints.dart';

// Third-party import
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class AppointmentController extends GetxController {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  TextEditingController concernController = TextEditingController();

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

  Future<List<AppointmentInfo>> fetchAppointmentInfo() async {
    String? token = await getToken();
    String? token_type = await getTokenType();

    try {
      final response = await http.get(
        Uri.parse('$baseUrl/admin/appointment/'),
        headers: <String, String>{
          'Accept': 'application/json',
          'Authorization': '$token_type $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        List<dynamic> myMap = json.decode(response.body);
        List<AppointmentInfo> AppointmentList = <AppointmentInfo>[];

        myMap.forEach((element) {
          //print(element);
          AppointmentList.add(AppointmentInfo.fromJson(element));
        });

        return AppointmentList;
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

  Future<List<AppointmentSlot>> fetchBlockedSlots(int year, int month) async {
    String? token = await getToken();
    String? token_type = await getTokenType();
    List<AppointmentSlot> AppointmentList = <AppointmentSlot>[];
    int advMonth = month + 1;
    int advYear = year;
    if (advMonth > 12) {
      advMonth = 1;
      advYear = year + 1;
    }

    // get 2 months
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/user/appointment/schedule/$year/$month'),
        headers: <String, String>{
          'Accept': 'application/json',
          'Authorization': '$token_type $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        List<dynamic> myMap = json.decode(response.body);
        myMap.forEach((element) {
          //print(element);
          AppointmentList.add(AppointmentSlot.fromJson(element));
        });

        try {
          final response2 = await http.get(
            Uri.parse('$baseUrl/user/appointment/schedule/$advYear/$advMonth'),
            headers: <String, String>{
              'Accept': 'application/json',
              'Authorization': '$token_type $token',
              'Content-Type': 'application/json',
            },
          );

          if (response2.statusCode == 200) {
            List<dynamic> myMap = json.decode(response.body);
            myMap.forEach((element) {
              //print(element);
              AppointmentList.add(AppointmentSlot.fromJson(element));
            });
            return AppointmentList;
          } else {
            print(response.body);
            print(response.statusCode);
            throw jsonDecode(response.body)['Message'] ??
                "Unknown Error Occurred";
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

  Future<void> setAppointment(
      String startTime, String endTime, String service, String concern) async {
    String? token = await getToken();
    String? token_type = await getTokenType();

    try {
      final response = await http.post(
        Uri.parse('$baseUrl/user/appointment/new/'),
        headers: <String, String>{
          'Accept': 'application/json',
          'Authorization': '$token_type $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "start_time": startTime,
          "end_time": endTime,
          "service": service,
          "concerns": concern,
        }),
      );

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        print(json);
        final SharedPreferences? prefs = await _prefs;
        //go to home
        concernController.clear();
        String pendDate =
            DateFormat('MMMM dd, yyyy').format(DateTime.parse(startTime));
        String startSlot =
            DateFormat('HH:mm').format(DateTime.parse(startTime)).toString();
        String endSlot =
            DateFormat('HH:mm').format(DateTime.parse(endTime)).toString();

        Get.to(() => BookScheduleSuccessPage(
              date: pendDate,
              startTime: startSlot,
              endTime: endSlot,
            ));
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
    }
  }

  Future<void> rescheduleAppointment(
      int id, String startTime, String endTime, String service) async {
    String? token = await getToken();
    String? token_type = await getTokenType();

    try {
      final response = await http.post(
        Uri.parse('$baseUrl/user/appointment/myschedule/$id/reschedule/'),
        headers: <String, String>{
          'Accept': 'application/json',
          'Authorization': '$token_type $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "start_time": startTime,
          "end_time": endTime,
          "service": service,
          "concerns": "",
        }),
      );

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        print(json);
        final SharedPreferences? prefs = await _prefs;
        //go to home
        concernController.clear();
        String pendDate =
            DateFormat('MMMM dd, yyyy').format(DateTime.parse(startTime));
        String startSlot =
            DateFormat('HH:mm').format(DateTime.parse(startTime)).toString();
        String endSlot =
            DateFormat('HH:mm').format(DateTime.parse(endTime)).toString();

        Get.to(() => BookScheduleSuccessPage(
              date: pendDate,
              startTime: startSlot,
              endTime: endSlot,
            ));
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
    }
  }

  Future<void> cancelAppointment(int id) async {
    String? token = await getToken();
    String? token_type = await getTokenType();

    try {
      final response = await http.post(
        Uri.parse('$baseUrl/user/appointment/myschedule/$id/cancel/'),
        headers: <String, String>{
          'Accept': 'application/json',
          'Authorization': '$token_type $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        print(json);
        final SharedPreferences? prefs = await _prefs;
        //go to home
        //Get.to(() => BookScheduleSuccessPage());
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
    }
  }

  Future<List<AppointmentInfo>> fetchPendingList() async {
    String? token = await getToken();
    String? token_type = await getTokenType();

    try {
      final response = await http.get(
        Uri.parse('$baseUrl/user/appointment/myschedule/pending/?limit=20'),
        headers: <String, String>{
          'Accept': 'application/json',
          'Authorization': '$token_type $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        List<dynamic> myMap = json.decode(response.body);
        List<AppointmentInfo> AppointmentList = <AppointmentInfo>[];

        myMap.forEach((element) {
          //print(element);
          AppointmentList.add(AppointmentInfo.fromJson(element));
        });

        return AppointmentList;
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

  Future<List<AppointmentInfo>> fetchUpcomingList() async {
    String? token = await getToken();
    String? token_type = await getTokenType();

    try {
      final response = await http.get(
        Uri.parse('$baseUrl/user/appointment/myschedule/upcoming/?limit=20'),
        headers: <String, String>{
          'Accept': 'application/json',
          'Authorization': '$token_type $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        List<dynamic> myMap = json.decode(response.body);
        List<AppointmentInfo> AppointmentList = <AppointmentInfo>[];

        myMap.forEach((element) {
          //print(element);
          AppointmentList.add(AppointmentInfo.fromJson(element));
        });

        return AppointmentList;
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

  Future<List<AppointmentInfo>> fetchPreviousList() async {
    String? token = await getToken();
    String? token_type = await getTokenType();

    try {
      final response = await http.get(
        Uri.parse('$baseUrl/user/appointment/myschedule/previous/?limit=20'),
        headers: <String, String>{
          'Accept': 'application/json',
          'Authorization': '$token_type $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        List<dynamic> myMap = json.decode(response.body);
        List<AppointmentInfo> AppointmentList = <AppointmentInfo>[];

        myMap.forEach((element) {
          //print(element);
          AppointmentList.add(AppointmentInfo.fromJson(element));
        });

        return AppointmentList;
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

  Future<List<AppointmentInfo>> fetchLatestUpcoming() async {
    String? token = await getToken();
    String? token_type = await getTokenType();

    try {
      final response = await http.get(
        Uri.parse('$baseUrl/user/appointment/myschedule/upcoming/?limit=1'),
        headers: <String, String>{
          'Accept': 'application/json',
          'Authorization': '$token_type $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        List<dynamic> myMap = json.decode(response.body);
        List<AppointmentInfo> AppointmentList = <AppointmentInfo>[];

        myMap.forEach((element) {
          //print(element);
          AppointmentList.add(AppointmentInfo.fromJson(element));
        });

        return AppointmentList;
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
