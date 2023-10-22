import 'package:get/get.dart';

class Appointment {
  final String startTime;
  final String endTime;
  final String service;
  final String concerns;

  const Appointment({
    required this.startTime,
    required this.endTime,
    required this.service,
    required this.concerns,
  });

  factory Appointment.fromJson(Map<String, dynamic> json) {
    String def_startTime;
    String def_endTime;
    String def_service;
    String def_concerns;

    def_startTime = json['start_time'] ?? DateTime.now.toString();
    def_endTime = json['end_time'] ?? DateTime.now.toString();
    def_service = json['service'] ?? '';
    def_concerns = json['concenrs'] ?? '';

    return Appointment(
      startTime: def_startTime as String,
      endTime: def_endTime as String,
      service: def_service as String,
      concerns: def_concerns as String,
    );
  }
}
