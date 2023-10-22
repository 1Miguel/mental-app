import 'package:get/get.dart';

class Membership {
  final int id;
  final int user;
  final String firstname;
  final String lastname;
  final String email;
  final String type;
  final String status;

  const Membership({
    required this.id,
    required this.user,
    required this.firstname,
    required this.lastname,
    required this.email,
    required this.type,
    required this.status,
  });

  factory Membership.fromJson(Map<String, dynamic> json) {
    int def_id;
    int def_user;
    String def_fname;
    String def_lname;
    String def_email;
    String def_type;
    String def_status;

    def_id = json['id'] ?? 0;
    def_user = json['user'] ?? 0;
    def_fname = json['firstname'] ?? '';
    def_lname = json['lastname'] ?? '';
    def_email = json['email'] ?? '';
    def_type = json['type'] ?? '';
    def_status = json['status'] ?? [];

    return Membership(
      id: def_id as int,
      user: def_user as int,
      firstname: def_fname as String,
      lastname: def_lname as String,
      email: def_email as String,
      type: def_type as String,
      status: def_status as String,
    );
  }
}
