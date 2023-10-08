import 'package:flutter/foundation.dart' show kIsWeb;
import 'dart:io' show Platform;

class ApiEndPoints {
  static String baseUrl = 'http://127.0.0.1:8000';
  static _AuthEndPoints authEndPoints = _AuthEndPoints();

  static String checkPlatform() {
    if (kIsWeb) {
    } else if (Platform.isAndroid) {
      baseUrl = 'http://10.0.2.2:8000';
    } else {
      // Unsupported platform
    }
    return baseUrl;
  }
}

class _AuthEndPoints {
  final String registerEmail = "/signup";
  final String login = "/login";
  final String token = "/token";
}
