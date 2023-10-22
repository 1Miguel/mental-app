import 'package:get/get.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:intl/intl.dart';

class AppointmentSlot {
  final String startTime;
  final String endTime;

  const AppointmentSlot({
    required this.startTime,
    required this.endTime,
  });

  factory AppointmentSlot.fromJson(Map<String, dynamic> json) {
    String def_startTime;
    String def_endTime;

    def_startTime = json['start_time'] ?? "0000-00-00T00:00";
    def_endTime = json['end_time'] ?? "0000-00-00T00:00";

    String updStartTime = DateFormat('yyyy-MM-ddTHH:mm')
        .format(DateTime.parse(def_startTime))
        .toString();

    String updEndTime = DateFormat('yyyy-MM-ddTHH:mm')
        .format(DateTime.parse(def_endTime))
        .toString();

    return AppointmentSlot(
      startTime: updStartTime,
      endTime: updEndTime,
    );
  }
}

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
