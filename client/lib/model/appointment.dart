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

class AppointmentInfo {
  final int id;
  final int patientId;
  final String center;
  final String startTime;
  final String endTime;
  final String status;

  const AppointmentInfo({
    required this.id,
    required this.patientId,
    required this.center,
    required this.startTime,
    required this.endTime,
    required this.status,
  });

  factory AppointmentInfo.fromJson(Map<String, dynamic> json) {
    int def_id;
    int def_patientId;
    String def_center;
    String def_startTime;
    String def_endTime;
    String def_status;

    def_id = json['id'] ?? 0;
    def_patientId = json['patient_id'] ?? 0;
    def_center = json['center'] ?? '';
    def_startTime = json['start_time'] ?? DateTime.now.toString();
    def_endTime = json['end_time'] ?? DateTime.now.toString();
    def_status = json['status'] ?? '';

    return AppointmentInfo(
      id: def_id as int,
      patientId: def_patientId as int,
      center: def_center as String,
      startTime: def_startTime as String,
      endTime: def_endTime as String,
      status: def_status as String,
    );
  }
}
