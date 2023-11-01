class ConfigFormData {
  String chars =
      'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890';
  int length = 5;
  double fontSize = 0;
  bool caseSensitive = true;
  Duration codeExpireAfter = const Duration(minutes: 1);

  @override
  String toString() {
    return '$chars$length$caseSensitive${codeExpireAfter.inMinutes}';
  }
}
