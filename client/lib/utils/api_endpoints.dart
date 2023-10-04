class ApiEndPoints {
  static final String baseUrl = 'http://127.0.0.1:8000';
  static _AuthEndPoints authEndPoints = _AuthEndPoints();
}

class _AuthEndPoints {
  final String registerEmail = "/signup";
  final String login = "/login";
  final String token = "/token";
}
