import 'package:flutter/material.dart';

// Local import
import 'package:flutter_intro/utils/colors_scheme.dart';

// Third-party import
import 'package:syncfusion_flutter_calendar/calendar.dart';

class ScheduleCalendarView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SizedBox(
        height: 800,
        child: SfCalendar(
          view: CalendarView.month,
          showNavigationArrow: true,
          dataSource: _getCalendarDataSource(),
          monthViewSettings: MonthViewSettings(
              showAgenda: true,
              appointmentDisplayMode: MonthAppointmentDisplayMode.appointment),
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
        ),
      ),
    );
  }
}

_AppointmentDataSource _getCalendarDataSource() {
  DateTime startTime = DateTime(2023, 10, 16, 11, 0);
  List<Appointment> appointments = <Appointment>[];
  appointments.add(Appointment(
    startTime: startTime,
    endTime: startTime.add(Duration(minutes: 60)),
    subject: 'Appointment - Doe',
    color: Colors.grey,
    startTimeZone: '',
    endTimeZone: '',
  ));
  appointments.add(Appointment(
    startTime: DateTime(2023, 10, 17, 8, 0),
    endTime: DateTime(2023, 10, 17, 8, 0).add(Duration(minutes: 60)),
    subject: 'Appointment - Perry',
    color: mainLightGreen,
    startTimeZone: '',
    endTimeZone: '',
  ));
  appointments.add(Appointment(
    startTime: DateTime(2023, 10, 17, 9, 0),
    endTime: DateTime(2023, 10, 17, 9, 0).add(Duration(minutes: 60)),
    subject: 'Appointment - Perry',
    color: mainLightGreen,
    startTimeZone: '',
    endTimeZone: '',
  ));
  appointments.add(Appointment(
    startTime: DateTime(2023, 10, 21, 9, 0),
    endTime: DateTime(2023, 10, 21, 9, 0).add(Duration(minutes: 60)),
    subject: 'Appointment - Lara',
    color: mainLightGreen,
    startTimeZone: '',
    endTimeZone: '',
  ));
  appointments.add(Appointment(
    startTime: DateTime(2023, 10, 21, 10, 0),
    endTime: DateTime(2023, 10, 21, 10, 0).add(Duration(minutes: 60)),
    subject: 'Appointment - Ellis',
    color: mainLightGreen,
    startTimeZone: '',
    endTimeZone: '',
  ));
  appointments.add(Appointment(
    startTime: DateTime(2023, 10, 21, 11, 0),
    endTime: DateTime(2023, 10, 21, 11, 0).add(Duration(minutes: 60)),
    subject: 'Appointment - Adams',
    color: mainLightGreen,
    startTimeZone: '',
    endTimeZone: '',
  ));
  appointments.add(Appointment(
    startTime: DateTime(2023, 10, 21, 1, 0),
    endTime: DateTime(2023, 10, 21, 1, 0).add(Duration(minutes: 60)),
    subject: 'Appointment - Owens',
    color: mainLightGreen,
    startTimeZone: '',
    endTimeZone: '',
  ));
  appointments.add(Appointment(
    startTime: DateTime(2023, 10, 21, 2, 0),
    endTime: DateTime(2023, 10, 21, 2, 0).add(Duration(minutes: 60)),
    subject: 'Appointment - Balnc',
    color: mainLightGreen,
    startTimeZone: '',
    endTimeZone: '',
  ));

  return _AppointmentDataSource(appointments);
}

class _AppointmentDataSource extends CalendarDataSource {
  _AppointmentDataSource(List<Appointment> source) {
    appointments = source;
  }
}
