import 'package:flutter/material.dart';

// Local import
import 'package:flutter_intro/utils/colors_scheme.dart';

// Third-party import
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:flutter_intro/model/appointment.dart' as app_model;
import 'package:flutter_intro/controllers/appointment_controller.dart';
import 'package:get/get.dart';

class ScheduleCalendarView extends StatelessWidget {
  late Future<List<app_model.AppointmentSlot>> futureBlockedSlots;
  AppointmentController appointmentController =
      Get.put(AppointmentController());

  Future<List<Appointment>> getBlockedDatesAsync() async {
    List<DateTime> dateList = <DateTime>[];
    List<Appointment> appointments = <Appointment>[];

    List<app_model.AppointmentSlot> futureBlockedSlots =
        await appointmentController.fetchBlockedSlots(
            DateTime.now().year, DateTime.now().month);

    futureBlockedSlots.forEach((element) {
      appointments.add(Appointment(
          startTime: DateTime.parse(element.startTime),
          endTime: DateTime.parse(element.endTime),
          color: Colors.green));
    });

    return appointments;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SizedBox(
        height: 800,
        child: FutureBuilder<List<Appointment>>(
            future: getBlockedDatesAsync(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final dates = snapshot.data!;
                return SfCalendar(
                  view: CalendarView.month,
                  showNavigationArrow: true,
                  dataSource: _getCalendarDataSource(dates),
                  monthViewSettings: MonthViewSettings(
                      showAgenda: true,
                      appointmentDisplayMode:
                          MonthAppointmentDisplayMode.appointment),
                  headerHeight: 80,
                  headerStyle: CalendarHeaderStyle(
                    //textAlign: TextAlign.center,
                    backgroundColor: calendarHeaderMainLightBlue,
                    textStyle: TextStyle(
                        fontFamily: 'Asap',
                        fontSize: 25,
                        fontStyle: FontStyle.normal,
                        letterSpacing: 5,
                        color: Color(0xFFff5eaea),
                        fontWeight: FontWeight.w800),
                  ),
                );
              } else {
                return SfCalendar(
                  view: CalendarView.month,
                  showNavigationArrow: true,
                  monthViewSettings: MonthViewSettings(
                      showAgenda: true,
                      appointmentDisplayMode:
                          MonthAppointmentDisplayMode.appointment),
                  headerHeight: 80,
                  headerStyle: CalendarHeaderStyle(
                    //textAlign: TextAlign.center,
                    backgroundColor: calendarHeaderMainLightBlue,
                    textStyle: TextStyle(
                        fontFamily: 'Asap',
                        fontSize: 25,
                        fontStyle: FontStyle.normal,
                        letterSpacing: 5,
                        color: Color(0xFFff5eaea),
                        fontWeight: FontWeight.w800),
                  ),
                );
              }
            }),
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
