import 'package:flutter/material.dart';
import 'package:flutter_intro/controllers/admin_appointment_controller.dart';
import 'package:flutter_intro/controllers/admin_controller.dart';
import 'package:flutter_intro/model/admin.dart';
import 'package:flutter_intro/model/appointment.dart';
import 'package:flutter_intro/ui_views/login_views.dart';

// Local import
import 'package:flutter_intro/utils/colors_scheme.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Third-party imports
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:get/get.dart';

GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();

class MainBody extends StatelessWidget {
  const MainBody({
    super.key,
  });

  getDate() {
    final datenow = DateTime.now();
    int month = datenow.month;
    int year = datenow.year;
    int day = datenow.day;

    String dateToday = "$year-$month-$day";
    return dateToday;
  }

  Future<void> getLogOutState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setBool('islogged_in', false);
    await prefs.remove("user_data");
    await prefs.remove("token");
    await prefs.remove("token_type");
    await prefs.remove("first_name");
    await prefs.remove("last_name");
    await prefs.remove("username");
    await prefs.remove("is_admin");
    await prefs.remove("is_super");
    await prefs.remove("isbanned");
    //await prefs.remove("islogged_in");
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraint) {
        double searchHeight = constraint.maxHeight / 4 - 100;
        double statusHeight = constraint.maxHeight / 4;
        double summaryHeight = constraint.maxHeight / 2;
        return Column(
          children: [
            SizedBox(height: 50),
            Container(
              width: constraint.maxWidth,
              height: searchHeight - 50,
              child: Padding(
                padding:
                    const EdgeInsets.only(left: 60.0, top: 20.0, bottom: 20.0),
                child: SizedBox(
                  width: 200,
                  height: searchHeight,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 3.0,
                            ),
                            child: Text("Today's Date"),
                          ),
                          Text(getDate()),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15.0),
                        child: SizedBox(
                          width: 50,
                          height: 50,
                          child: Container(
                            color: unselectedGray,
                            child: Icon(
                              Icons.calendar_month,
                              color: primaryGrey,
                              size: 20.0,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20, right: 15.0),
                        child: IconButton(
                          color: unselectedGray,
                          icon: const Icon(
                            Icons.logout,
                            size: 30,
                            color: Colors.black,
                          ),
                          onPressed: () async {
                            await getLogOutState();
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: ((context) => LoginMainPage())));
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              width: constraint.maxWidth,
              height: statusHeight,
              child: Column(
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 65.0, bottom: 15.0, top: 20.0),
                        child: SizedBox(
                          width: statusHeight,
                          child: Text(
                            'Status',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Roboto',
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 50.0),
                    child: StatusBoxList(),
                  ),
                ],
              ),
            ),
            Container(
              width: constraint.maxWidth,
              height: summaryHeight,
              child: Padding(
                padding: const EdgeInsets.only(left: 50.0),
                child: UpcomingEventsList(),
              ),
            ),
          ],
        );
      },
    );
  }
}

class StatusBoxList extends StatelessWidget {
  AdminController adminController = Get.put(AdminController());
  late Future<DashboardStats> stats;

  StatusBoxList({
    super.key,
  });

  Future<DashboardStats> fetchStats() async {
    stats = adminController.fetchAdminStats();
    print(stats);
    return stats;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraint) {
        double cardWidth = constraint.maxWidth / 5;
        return Row(
          children: [
            Container(
              width: cardWidth,
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                child: FutureBuilder<DashboardStats>(
                    future: fetchStats(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        final statData = snapshot.data!;
                        return StatusCard(
                            count: statData.numPatients.toString(),
                            label: "Patients",
                            icon: Icons.wheelchair_pickup,
                            overflowLabel: false);
                      } else {
                        return Container(
                            height: 100,
                            width: cardWidth,
                            child: Center(
                                child: SizedBox(
                                    width: 100,
                                    height: 100,
                                    child: CircularProgressIndicator(
                                        color: Colors.grey))));
                      }
                    }),
              ),
            ),
            Container(
              width: cardWidth,
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                child: FutureBuilder<DashboardStats>(
                    future: fetchStats(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        final statData = snapshot.data!;
                        return StatusCard(
                          count: statData.numSessions.toString(),
                          label: "Today's Sessions",
                          icon: Icons.schedule,
                          overflowLabel: true,
                        );
                      } else {
                        return Container(
                            height: 100,
                            width: cardWidth,
                            child: Center(
                                child: SizedBox(
                                    width: 100,
                                    height: 100,
                                    child: CircularProgressIndicator(
                                        color: Colors.grey))));
                      }
                    }),
              ),
            ),
            Container(
              width: cardWidth,
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                child: FutureBuilder<DashboardStats>(
                    future: fetchStats(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        final statData = snapshot.data!;
                        return StatusCard(
                            count: statData.numAppointments.toString(),
                            label: "New Appointment\nRequests",
                            icon: Icons.pending_actions,
                            overflowLabel: true);
                      } else {
                        return Container(
                            height: 100,
                            width: cardWidth,
                            child: Center(
                                child: SizedBox(
                                    width: 100,
                                    height: 100,
                                    child: CircularProgressIndicator(
                                        color: Colors.grey))));
                      }
                    }),
              ),
            ),
          ],
        );
      },
    );
  }
}

class UpcomingEventsList extends StatelessWidget {
  UpcomingEventsList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraint) {
        return Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Container(
                width: constraint.maxWidth / 3 - 40,
                height: constraint.maxHeight,
                child: Padding(
                  padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                  child: UpcomingAppointmentCard(
                    title: "Today's Appointments",
                    label: "Doctors",
                    image: "images/admin_appointment.png",
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Container(
                width: constraint.maxWidth / 3 + 100,
                height: constraint.maxHeight,
                child: Padding(
                  padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                  child: MembershipCard(
                    title: "Service Summary",
                    label: "Doctors",
                    image: "images/admin_membership.png",
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class StatusCard extends StatelessWidget {
  final String count;
  final String label;
  final IconData icon;
  final bool overflowLabel;

  const StatusCard({
    super.key,
    required this.count,
    required this.label,
    required this.icon,
    required this.overflowLabel,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraint) {
        return SizedBox(
          width: constraint.maxWidth,
          height: 120,
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0.0),
            ),
            elevation: 1,
            surfaceTintColor: Colors.grey,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: (constraint.maxWidth / 3) * 2 - 20,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: StatusInfo(
                        count: count, label: label, overflow: overflowLabel),
                  ),
                ),
                Container(
                  width: constraint.maxWidth / 3 - 10,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 20.0),
                    child: StatusIcon(icon: icon),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class StatusInfo extends StatelessWidget {
  final String count;
  final String label;
  final bool overflow;

  const StatusInfo({
    super.key,
    required this.count,
    required this.label,
    required this.overflow,
  });

  @override
  Widget build(BuildContext context) {
    double size = overflow ? 18 : 20;
    return LayoutBuilder(
      builder: (context, constraint) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                SizedBox(
                  width: constraint.maxWidth,
                  height: 50,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 15.0),
                    child: Text(
                      count,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: primaryBlue,
                        fontSize: 25,
                        fontFamily: 'Roboto',
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: constraint.maxWidth,
                  height: 50,
                  child: Text(
                    label,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: size,
                      fontFamily: 'Roboto',
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}

class StatusIcon extends StatelessWidget {
  final IconData icon;

  const StatusIcon({
    super.key,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraint) {
        return Center(
          child: SizedBox(
            width: constraint.maxWidth,
            height: 50,
            child: Container(
              color: mainBlue,
              child: Icon(
                icon,
                color: Colors.white,
                size: 20.0,
              ),
            ),
          ),
        );
      },
    );
  }
}

class SearchBarApp extends StatefulWidget {
  const SearchBarApp({super.key});

  @override
  State<SearchBarApp> createState() => _SearchBarAppState();
}

class _SearchBarAppState extends State<SearchBarApp> {
  bool isDark = false;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraint) {
        return Row(
          children: [
            SizedBox(
              width: (constraint.maxWidth / 3) * 2,
              height: 50,
              child: SearchBar(
                surfaceTintColor:
                    MaterialStateProperty.all<Color>(Colors.white),
                backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0))),
                padding: const MaterialStatePropertyAll<EdgeInsets>(
                    EdgeInsets.symmetric(horizontal: 16.0)),
                onTap: () {},
                onChanged: (_) {},
                leading: const Icon(Icons.search),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30.0, right: 20.0),
              child: SizedBox(
                height: 50,
                child: MaterialButton(
                  color: unselectedLightBlue,
                  child: const Text("Search",
                      style: TextStyle(
                          color: Colors.blue, fontWeight: FontWeight.bold)),
                  onPressed: () {
                    //getImageFromGallery();
                  },
                ),
              ),
            ),
            SizedBox(width: 30),
          ],
        );
      },
    );
  }
}

class UpcomingAppointmentCard extends StatelessWidget {
  final String title;
  final String label;
  final String image;
  AdminAppointmentController adminAppointmentController =
      Get.put(AdminAppointmentController());
  late Future<List<AppointmentInfo>> futureTodayAppointments;

  UpcomingAppointmentCard({
    super.key,
    required this.title,
    required this.label,
    required this.image,
  });

  Future<List<AppointmentInfo>> fetchTodayAppointments() async {
    futureTodayAppointments =
        adminAppointmentController.fetchAppointmentsToday();
    print(futureTodayAppointments);
    return futureTodayAppointments;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraint) {
        return SizedBox(
          width: constraint.maxWidth - 20,
          height: constraint.maxHeight - 70,
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0.0),
            ),
            elevation: 1,
            surfaceTintColor: Colors.grey,
            child: Column(
              children: [
                Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0, top: 10.0),
                          child: Text(
                            title,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color: primaryBlue,
                              fontSize: 25,
                              fontFamily: 'Roboto',
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: Text(
                            title,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color: Colors.black87,
                              fontSize: 15,
                              fontFamily: 'Roboto',
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          //width: constraint.maxWidth / 2 - 40,
                          height: 100,
                          child: Image.asset(
                            image,
                            fit: BoxFit.fitHeight,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Divider(),
                Container(
                  width: constraint.maxWidth,
                  height: constraint.maxHeight / 2,
                  child: FutureBuilder<List<AppointmentInfo>>(
                      future: fetchTodayAppointments(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          final statData = snapshot.data!;
                          return Container(
                              width: constraint.maxWidth,
                              height: constraint.maxHeight / 2,
                              child: buildTodayList(statData));
                        } else {
                          return CircularProgressIndicator(color: Colors.grey);
                        }
                      }),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildTodayList(List<AppointmentInfo> appointments) => ListView.builder(
      itemCount: appointments.length,
      itemBuilder: (context, index) {
        final appointment = appointments[index];

        return LayoutBuilder(builder: (context, constraint) {
          double TimeBox = constraint.maxWidth / 5;
          return Container(
            width: constraint.maxWidth,
            height: 70,
            child: Padding(
              padding: const EdgeInsets.only(left: 20.0, bottom: 10),
              child: Row(
                children: [
                  SizedBox(
                      width: TimeBox, height: 60, child: Text('09:00 - 10:00')),
                  SizedBox(
                    width: constraint.maxWidth - TimeBox - 20 - 16,
                    height: 60,
                    child: TimeCard(
                        type: appointment.service,
                        name: appointment.patientName),
                  ),
                ],
              ),
            ),
          );
        });
      });
}

class TimeCard extends StatelessWidget {
  final String type;
  final String name;

  const TimeCard({
    super.key,
    required this.type,
    required this.name,
  });

  Color getColor() {
    if (type == "OCCUPATIONAL_THERAPY") {
      return calendarOTColor;
    } else if (type == "PSYCHIATRIC_CONSULTATION") {
      return calendarPCColor;
    } else if (type == "COUNSELING") {
      return calendarCoColor;
    } else if (type == "PSYCHOLOGICAL_ASSESMENT") {
      return calendarPAColor;
    }
    return unselectedLightBlue;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraint) {
        return Container(
          child: Card(
            color: getColor(),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(15.0),
                  bottomRight: Radius.circular(15.0)),
            ),
            elevation: 1,
            child: Row(
              children: [
                Container(
                  width: 5,
                  height: 50,
                  color: mainDarkBlue,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                      child: SizedBox(
                        width: constraint.maxWidth - 50 - 5,
                        child: Text(
                          type,
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 20.0, right: 20.0, bottom: 5),
                      child: SizedBox(
                        width: constraint.maxWidth - 50 - 5,
                        child: Text(
                          'Patient Name: $name',
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class MembershipCard extends StatelessWidget {
  final String title;
  final String label;
  final String image;

  const MembershipCard({
    super.key,
    required this.title,
    required this.label,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraint) {
        return SizedBox(
          width: constraint.maxWidth - 20,
          height: constraint.maxHeight - 70,
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0.0),
            ),
            elevation: 1,
            surfaceTintColor: Colors.grey,
            child: Column(
              children: [
                Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0, top: 10.0),
                          child: Text(
                            title,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color: primaryBlue,
                              fontSize: 25,
                              fontFamily: 'Roboto',
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: Text(
                            title,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color: Colors.black87,
                              fontSize: 15,
                              fontFamily: 'Roboto',
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          //width: constraint.maxWidth / 2 - 40,
                          height: 100,
                          child: Image.asset(
                            image,
                            fit: BoxFit.fitHeight,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Divider(),
                Container(
                  width: constraint.maxWidth,
                  height: constraint.maxHeight / 2,
                  child: MembershipChart(),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class MembershipChart extends StatelessWidget {
  AdminController adminController = Get.put(AdminController());
  late Future<List<String>> stats;

  Future<List<String>> fetchServiceStats() async {
    stats = adminController.fetchServiceStats();
    return stats;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<String>>(
        future: fetchServiceStats(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final statData = snapshot.data!;
            final List<ChartData> chartData = [];

            if (statData[0] != "0") {
              chartData.add(ChartData('Counseling', double.parse(statData[0])));
            }
            if (statData[1] != "0") {
              chartData.add(ChartData(
                  'Psychiatric Consultation', double.parse(statData[1])));
            }
            if (statData[2] != "0") {
              chartData.add(
                  ChartData('Occupational Therapy', double.parse(statData[2])));
            }
            if (statData[3] != "0") {
              chartData.add(ChartData(
                  'Psychological Assesment', double.parse(statData[3])));
            }

            return Center(
              child: SfCircularChart(
                  title: ChartTitle(
                      text: 'New Membership Requests',
                      alignment: ChartAlignment.near,
                      textStyle: TextStyle(
                        fontFamily: 'Roboto',
                        fontStyle: FontStyle.italic,
                        fontSize: 12,
                      )),
                  legend: Legend(isVisible: true),
                  series: <CircularSeries>[
                    // Render pie chart

                    PieSeries<ChartData, String>(
                        dataSource: chartData,
                        xValueMapper: (ChartData data, _) => data.x,
                        yValueMapper: (ChartData data, _) => data.y,
                        radius: '100%',
                        dataLabelSettings: DataLabelSettings(isVisible: true))
                  ]),
            );
          } else {
            return Container(
                height: 100,
                width: 100,
                child: Center(
                    child: SizedBox(
                        width: 100,
                        height: 100,
                        child: CircularProgressIndicator(color: Colors.grey))));
          }
        });
  }
}

class Donationcard extends StatelessWidget {
  final String title;
  final String label;
  final String image;

  const Donationcard({
    super.key,
    required this.title,
    required this.label,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraint) {
        return SizedBox(
          width: constraint.maxWidth - 20,
          height: constraint.maxHeight - 70,
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0.0),
            ),
            elevation: 1,
            surfaceTintColor: Colors.grey,
            child: Column(
              children: [
                Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0, top: 10.0),
                          child: Text(
                            title,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color: primaryBlue,
                              fontSize: 25,
                              fontFamily: 'Roboto',
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: Text(
                            title,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color: Colors.black87,
                              fontSize: 15,
                              fontFamily: 'Roboto',
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          //width: constraint.maxWidth / 2 - 40,
                          height: 100,
                          child: Image.asset(
                            image,
                            fit: BoxFit.fitHeight,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Divider(),
                Container(
                  width: constraint.maxWidth,
                  height: constraint.maxHeight / 2,
                  child: DonationChart(),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class DonationChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<DonationData> donationData = [
      DonationData('Pending', 25, Colors.grey),
      DonationData('Received', 75, Colors.lightGreen),
    ];
    return Center(
      child: SfCircularChart(
          annotations: <CircularChartAnnotation>[
            // CircularChartAnnotation(
            //     radius: '80%',
            //     angle: 200,
            //     widget: Container(
            //         child: PhysicalModel(
            //             child: Container(),
            //             shape: BoxShape.circle,
            //             elevation: 10,
            //             shadowColor: Colors.black,
            //             color: Colors.blue))),
            CircularChartAnnotation(
                widget: Center(
              child: Container(
                  child: const Text('10, 900',
                      style: TextStyle(
                          color: Color.fromRGBO(0, 0, 0, 0.5), fontSize: 25))),
            ))
          ],
          title: ChartTitle(
              text: 'Total Donation Funds',
              alignment: ChartAlignment.near,
              textStyle: TextStyle(
                fontFamily: 'Roboto',
                fontStyle: FontStyle.italic,
                fontSize: 12,
              )),
          legend: Legend(isVisible: true),
          series: <CircularSeries>[
            // Render pie chart
            DoughnutSeries<DonationData, String>(
                dataSource: donationData,
                pointColorMapper: (DonationData data, _) => data.color,
                xValueMapper: (DonationData data, _) => data.x,
                yValueMapper: (DonationData data, _) => data.y,
                radius: '100%',
                dataLabelSettings: DataLabelSettings(isVisible: true))
          ]),
    );
  }
}

class ChartData {
  ChartData(this.x, this.y);
  final String x;
  final double y;
}

class DonationData {
  DonationData(this.x, this.y, this.color);
  final String x;
  final double y;
  final Color color;
}
