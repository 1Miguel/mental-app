import 'package:flutter/material.dart';
import 'package:flutter_intro/dashboard_profile.dart';
import 'package:flutter_intro/ui_views/book_appointment.dart';
import 'package:flutter_intro/ui_views/dashboard_views.dart';
import 'package:flutter_intro/utils/colors_scheme.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:flutter_intro/model/notification.dart' as notifModel;

class MessagesTab extends StatefulWidget {
  const MessagesTab({super.key});

  @override
  _MessagesTabState createState() {
    return _MessagesTabState();
  }
}

class _MessagesTabState extends State<MessagesTab> {
  int _selectedIndex = 1;
  List<notifModel.Notification> notifList = getNotifications();

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if (index == 0) {
        Navigator.push(context,
            MaterialPageRoute(builder: ((context) => DashboardPage())));
      } else if (index == 2) {
        Navigator.push(context,
            MaterialPageRoute(builder: ((context) => AppointmentTab())));
      } else if (index == 3) {
        Navigator.push(
            context, MaterialPageRoute(builder: ((context) => ProfileTab())));
      }
    });
  }

  static List<notifModel.Notification> getNotifications() {
    const data = [
      {
        "title": "Psychological Assesment Schedule Approved",
        "content": "Your request for psychological assessment...",
        "date": "023-11-06T09:00:00+00:00",
        "read": false,
      },
      {
        "title": "Psychological Assesment Schedule Approved",
        "content": "Your request for psychological assessment...",
        "date": "023-11-06T09:00:00+00:00",
        "read": false,
      },
      {
        "title": "Psychological Assesment Schedule Approved",
        "content": "Your request for psychological assessment...",
        "date": "023-11-06T09:00:00+00:00",
        "read": false,
      }
    ];
    return data
        .map<notifModel.Notification>(notifModel.Notification.fromJson)
        .toList();
  }

  Widget buildUpcoming(List<notifModel.Notification> notifList) =>
      ListView.builder(
        itemCount: notifList.length,
        itemBuilder: (context, index) {
          final notif = notifList[index];
          return LayoutBuilder(builder: (context, constraint) {
            return Column(
              children: [
                Container(
                    width: constraint.maxWidth, height: 80, child: NotifCard()),
                Divider(),
              ],
            );
          });
        },
      );

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraint) {
      const double appBarHeight = 80;
      const double botBarHeight = 60;
      double bodyHeight = constraint.maxHeight - appBarHeight - botBarHeight;
      return PopScope(
        canPop: false,
        child: Scaffold(
          appBar: AppBar(
            toolbarHeight: appBarHeight,
            automaticallyImplyLeading: false,
            flexibleSpace: Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('images/bg_teal_hd.png'),
                      fit: BoxFit.fill),
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.elliptical(50, 20),
                      bottomRight: Radius.elliptical(50, 20))),
            ),
            title: Text("NOTIFICATIONS",
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.w900)),
            centerTitle: true,
          ),
          body: Container(
            width: constraint.maxWidth,
            height: bodyHeight,
            child: Column(
              children: [
                Divider(),
                Container(
                  width: constraint.maxWidth,
                  height: bodyHeight - 40,
                  child: buildUpcoming(notifList),
                )
              ],
            ),
          ),
          bottomNavigationBar: SizedBox(
            width: MediaQuery.sizeOf(context).width,
            height: botBarHeight,
            child: BottomNavigationBar(
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Home',
                  backgroundColor: HexColor("#67ddd8"),
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.mail),
                  label: 'Messages',
                  backgroundColor: HexColor("#5ce1e6"),
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.event),
                  label: 'Appointment',
                  backgroundColor: HexColor("#67ddd8"),
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.account_circle),
                  label: 'Profile',
                  backgroundColor: HexColor("#5ce1e6"),
                ),
              ],
              currentIndex: _selectedIndex,
              selectedItemColor: Colors.teal,
              onTap: _onItemTapped,
            ),
          ),
        ),
      );
    });
  }
}

class NotifCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraint) {
      return Container(
        width: constraint.maxWidth,
        height: constraint.maxHeight,
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20.0),
              child: SizedBox(
                width: 50,
                height: 50,
                child: Icon(
                  Icons.mark_email_unread,
                  size: 35,
                  color: Colors.teal,
                ),
              ),
            ),
            Container(
              width: constraint.maxWidth - 100,
              child: Padding(
                padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                child: Column(
                  children: [
                    SizedBox(
                        width: constraint.maxWidth,
                        child: Text(
                          "Appointment Request has been approved",
                        )),
                    SizedBox(
                        width: constraint.maxWidth,
                        child: Text(
                          "Your request for psychological assesment...",
                          style: TextStyle(color: Colors.grey.shade600),
                        )),
                    SizedBox(
                        width: constraint.maxWidth,
                        child: Text(
                          "December 25, 2023 08:14 am",
                          style: TextStyle(fontSize: 10, color: Colors.grey),
                        )),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
