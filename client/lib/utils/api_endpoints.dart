import 'package:flutter/foundation.dart' show kIsWeb;
import 'dart:io' show Platform;

class ApiEndPoints {
  //static String baseUrl = 'http://192.168.1.5:8080';
  static String baseUrl = 'http://35.197.129.194:8080';
  static _AuthEndPoints authEndPoints = _AuthEndPoints();
  //baseUrl = 'http://10.0.2.2:8000';

  static String checkPlatform() {
    if (kIsWeb) {
    } else if (Platform.isAndroid) {
      baseUrl = "http://35.197.129.194:8080";
    } else {
      // Unsupported platform
    }
    return "http://35.197.129.194:8080";
  }
}

class _AuthEndPoints {
  final String registerEmail = "/signup";
  final String login = "/login";
  final String token = "/token";
  final String usermoood = "/user/mood";
}
