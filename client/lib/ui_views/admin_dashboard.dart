import 'package:flutter/material.dart';

// Local import
import 'package:flutter_intro/utils/colors_scheme.dart';

// Third-party imports
import 'package:syncfusion_flutter_charts/charts.dart';

GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();

class MainBody extends StatelessWidget {
  const MainBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraint) {
        double searchHeight = constraint.maxHeight / 4 - 100;
        double statusHeight = constraint.maxHeight / 4;
        double summaryHeight = constraint.maxHeight / 2;
        return Column(
          children: [
            //SizedBox(height: 50),
            Container(
              width: constraint.maxWidth,
              height: searchHeight,
              child: Padding(
                padding:
                    const EdgeInsets.only(left: 60.0, top: 20.0, bottom: 20.0),
                child: SearchBarApp(),
              ),
            ),
            Container(
              width: constraint.maxWidth,
              height: statusHeight,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 65.0, bottom: 15.0, top: 20.0),
                    child: SizedBox(
                      width: MediaQuery.sizeOf(context).width,
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
  const StatusBoxList({
    super.key,
  });

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
                child: StatusCard(
                    count: "125",
                    label: "Patients",
                    icon: Icons.wheelchair_pickup,
                    overflowLabel: false),
              ),
            ),
            Container(
              width: cardWidth,
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                child: StatusCard(
                  count: "5",
                  label: "Today's Sessions",
                  icon: Icons.schedule,
                  overflowLabel: true,
                ),
              ),
            ),
            Container(
              width: cardWidth,
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                child: StatusCard(
                    count: "10",
                    label: "New Appointment\nRequests",
                    icon: Icons.pending_actions,
                    overflowLabel: true),
              ),
            ),
            Container(
              width: cardWidth,
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                child: StatusCard(
                    count: "0",
                    label: "Membership\nRequests",
                    icon: Icons.bookmark,
                    overflowLabel: true),
              ),
            ),
            Container(
              width: cardWidth,
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                child: StatusCard(
                  count: "0",
                  label: "Pending\nDonations",
                  icon: Icons.loyalty,
                  overflowLabel: true,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class UpcomingEventsList extends StatelessWidget {
  const UpcomingEventsList({
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
                width: constraint.maxWidth / 3 - 40,
                height: constraint.maxHeight,
                child: Padding(
                  padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                  child: MembershipCard(
                    title: "Membership Requests",
                    label: "Doctors",
                    image: "images/admin_membership.png",
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Container(
                width: constraint.maxWidth / 3 - 40,
                height: constraint.maxHeight,
                child: Padding(
                  padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                  child: Donationcard(
                    title: "Donation",
                    label: "Doctors",
                    image: "images/admin_donation.png",
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

  getDate() {
    final datenow = DateTime.now();
    int month = datenow.month;
    int year = datenow.year;
    int day = datenow.day;

    String dateToday = "$year-$month-$day";
    return dateToday;
  }

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
            SizedBox(
              width: 150,
              height: 50,
              child: Row(
                children: [
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 3.0),
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
                ],
              ),
            ),
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

  const UpcomingAppointmentCard({
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
                  child: DayView(),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class DayView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraint) {
        double TimeBox = constraint.maxWidth / 5;
        return Container(
          width: constraint.maxWidth,
          height: 300,
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20.0, bottom: 10),
                child: Row(
                  children: [
                    SizedBox(width: TimeBox, child: Text('09:00 - 10:00')),
                    SizedBox(
                      width: constraint.maxWidth - TimeBox - 20 - 16,
                      child: TimeCard(type: "Psychiatric Consultation"),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0, bottom: 10),
                child: Row(
                  children: [
                    SizedBox(width: TimeBox, child: Text('10:00 - 11:00')),
                    SizedBox(
                      width: constraint.maxWidth - TimeBox - 20 - 16,
                      child: TimeCard(type: "Counseling"),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0, bottom: 10),
                child: Row(
                  children: [
                    SizedBox(width: TimeBox, child: Text('11:00 - 12:00')),
                    SizedBox(
                      width: constraint.maxWidth - TimeBox - 20 - 16,
                      child: TimeCard(type: "Occupational Therapy"),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0, bottom: 10),
                child: Row(
                  children: [
                    SizedBox(width: TimeBox, child: Text('01:00 - 02:00')),
                    SizedBox(
                      width: constraint.maxWidth - TimeBox - 20 - 16,
                      child: TimeCard(type: "Psychological Assesment"),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0, bottom: 10),
                child: Row(
                  children: [
                    SizedBox(width: TimeBox, child: Text('02:00 - 03:00')),
                    SizedBox(
                      width: constraint.maxWidth - TimeBox - 20 - 16,
                      child: TimeCard(type: "Counseling"),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0, bottom: 10),
                child: Row(
                  children: [
                    SizedBox(width: TimeBox, child: Text('03:00 - 04:00')),
                    SizedBox(
                      width: constraint.maxWidth - TimeBox - 20 - 16,
                      child: TimeCard(type: "Counseling"),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class TimeCard extends StatelessWidget {
  final String type;

  const TimeCard({
    super.key,
    required this.type,
  });

  Color getColor() {
    if (type == "Occupational Therapy") {
      return calendarOTColor;
    } else if (type == "Psychiatric Consultation") {
      return calendarPCColor;
    } else if (type == "Counseling") {
      return calendarCoColor;
    } else if (type == "Psychological Assesment") {
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
                          'Patient Name: John Doe',
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
  @override
  Widget build(BuildContext context) {
    final List<ChartData> chartData = [
      ChartData('David', 25),
      ChartData('Steve', 38),
      ChartData('Jack', 34),
      ChartData('Others', 52)
    ];
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
