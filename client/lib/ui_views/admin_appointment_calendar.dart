import 'package:flutter/material.dart';
import 'package:flutter_intro/controllers/admin_appointment_controller.dart';

// Local import
import 'package:flutter_intro/utils/colors_scheme.dart';

// Third-party import
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:flutter_intro/model/appointment.dart' as app_model;
import 'package:flutter_intro/controllers/appointment_controller.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ScheduleCalendarView extends StatelessWidget {
  late Future<List<app_model.AppointmentInfo>> futureBlockedSlots;
  AdminAppointmentController adminAppointmentController =
      Get.put(AdminAppointmentController());

  Color getColor(String serviceType) {
    if (serviceType == "OCCUPATIONAL_THERAPY") {
      return calendarOTColor;
    } else if (serviceType == "PSYCHIATRIC_CONSULTATION") {
      return calendarPCColor;
    } else if (serviceType == "COUNSELING") {
      return calendarCoColor;
    } else if (serviceType == "PSYCHOLOGICAL_ASSESMENT") {
      return calendarPAColor;
    }
    return unselectedLightBlue;
  }

  String getServiceTypeString(String serviceType) {
    if (serviceType == "OCCUPATIONAL_THERAPY") {
      return "Occupational Therapy";
    } else if (serviceType == "PSYCHIATRIC_CONSULTATION") {
      return "Psychiatric Consultation";
    } else if (serviceType == "COUNSELING") {
      return "Counseling";
    } else if (serviceType == "PSYCHOLOGICAL_ASSESMENT") {
      return "Psychological Assesment";
    }
    return "Unknown Service";
  }

  Future<List<Meeting>> getBlockedDatesAsync() async {
    List<DateTime> dateList = <DateTime>[];
    List<Appointment> appointments = <Appointment>[];
    List<Meeting> meetings = <Meeting>[];

    List<app_model.AppointmentInfo> futureBlockedSlots =
        await adminAppointmentController.fetchAppointments();

    futureBlockedSlots.forEach((element) {
      String startSched = "${element.date} ${element.startTime}";
      String endSched = "${element.date} ${element.endTime}";
      DateTime start = DateTime.parse(startSched);
      DateTime end = DateTime.parse(endSched);
      if (element.startTime == "01:00" ||
          element.startTime == "02:00" ||
          element.startTime == "03:00") {
        start.add(const Duration(hours: 12));
        end.add(const Duration(hours: 12));
      }

      // appointments.add(Appointment(
      //     startTime: DateTime.parse(element.startTime),
      //     endTime: DateTime.parse(element.endTime),
      //     color: Colors.green));
      meetings.add(Meeting(getServiceTypeString(element.service), start, end,
          getColor(element.service), false));
    });
    print("Meetings");
    print(meetings);

    return meetings;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Monthly Schedule Overview',
          style: TextStyle(
            color: loginDarkTeal,
            fontSize: 20,
            fontWeight: FontWeight.w600,
            fontFamily: 'Roboto',
          ),
        ),
      ),
      body: Container(
        child: SizedBox(
          height: 800,
          child: FutureBuilder<List<Meeting>>(
              future: getBlockedDatesAsync(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final dates = snapshot.data!;
                  return SfCalendar(
                    view: CalendarView.month,
                    showNavigationArrow: true,
                    //dataSource: _getCalendarDataSource(dates),
                    dataSource: MeetingDataSource(dates),
                    todayHighlightColor: Colors.lightBlueAccent,
                    monthViewSettings: MonthViewSettings(
                      appointmentDisplayCount: 3,
                      showAgenda: true,
                      appointmentDisplayMode:
                          MonthAppointmentDisplayMode.appointment,
                    ),
                    headerHeight: 80,
                    headerStyle: CalendarHeaderStyle(
                      //textAlign: TextAlign.center,
                      backgroundColor: Colors.teal,
                      textStyle: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 25,
                          fontStyle: FontStyle.normal,
                          letterSpacing: 5,
                          color: Color(0xFFff5eaea),
                          fontWeight: FontWeight.w800),
                    ),
                    viewHeaderStyle: ViewHeaderStyle(
                        backgroundColor: Colors.tealAccent,
                        dayTextStyle: TextStyle(
                            fontSize: 18,
                            color: loginDarkTeal,
                            fontWeight: FontWeight.w500),
                        dateTextStyle: TextStyle(
                            fontSize: 22,
                            color: mainBlue,
                            letterSpacing: 2,
                            fontWeight: FontWeight.w500)),
                  );
                } else {
                  return const Text('No Data to Display');
                }
              }),
        ),
      ),
    );
  }
}

_AppointmentDataSource _getCalendarDataSource(List<Appointment> appointments) {
  DateTime startTime = DateTime(2023, 10, 16, 11, 0);
  return _AppointmentDataSource(appointments);
}

class _AppointmentDataSource extends CalendarDataSource {
  _AppointmentDataSource(List<Appointment> source) {
    appointments = source;
  }
}

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Meeting> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return appointments![index].from;
  }

  @override
  DateTime getEndTime(int index) {
    return appointments![index].to;
  }

  @override
  String getSubject(int index) {
    return appointments![index].eventName;
  }

  @override
  Color getColor(int index) {
    return appointments![index].background;
  }

  @override
  bool isAllDay(int index) {
    return appointments![index].isAllDay;
  }
}

class Meeting {
  Meeting(this.eventName, this.from, this.to, this.background, this.isAllDay);

  String eventName;
  DateTime from;
  DateTime to;
  Color background;
  bool isAllDay;
}
