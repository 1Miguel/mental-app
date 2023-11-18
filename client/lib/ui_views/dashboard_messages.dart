import 'package:flutter/material.dart';
import 'package:flutter_intro/controllers/notification_controller.dart';
import 'package:flutter_intro/ui_views/book_appointment.dart';
import 'package:flutter_intro/ui_views/dashboard_profile.dart';
import 'package:flutter_intro/ui_views/dashboard_views.dart';
import 'package:flutter_intro/utils/colors_scheme.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:flutter_intro/model/notification.dart' as notifModel;
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class MessagesTab extends StatefulWidget {
  const MessagesTab({super.key});

  @override
  _MessagesTabState createState() {
    return _MessagesTabState();
  }
}

class _MessagesTabState extends State<MessagesTab> {
  int _selectedIndex = 1;
  late Future<List<notifModel.Notification>> futureNotifList;
  NotificationController notificationController =
      Get.put(NotificationController());

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

  Future<List<notifModel.Notification>> fetchUserNotifcation() async {
    futureNotifList = notificationController.fetchUserNotifications();
    print(futureNotifList);
    return futureNotifList;
  }

  Widget buildNotifList(
          List<notifModel.Notification> notifList, VoidCallback callback) =>
      ListView.builder(
        itemCount: notifList.length,
        itemBuilder: (context, index) {
          final notif = notifList[index];
          return LayoutBuilder(builder: (context, constraint) {
            return Column(
              children: [
                Container(
                  width: constraint.maxWidth,
                  height: 80,
                  child: NotifCard(
                    id: notif.id,
                    title: notif.title,
                    content: notif.content,
                    date: notif.date,
                    isRead: notif.read,
                    onTap: () {
                      callback();
                    },
                  ),
                ),
                Divider(),
              ],
            );
          });
        },
      );

  Widget waitThreads(context) => Container(
        width: MediaQuery.sizeOf(context).width,
        child: Column(
          children: [
            SizedBox(
              width: 100,
              height: 100,
              child: CircularProgressIndicator(
                color: primaryGrey,
              ),
            ),
          ],
        ),
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
                //Divider(),
                Container(
                  width: constraint.maxWidth,
                  height: bodyHeight - 40,
                  child: FutureBuilder<List<notifModel.Notification>>(
                      future: fetchUserNotifcation(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          final notifList = snapshot.data!;
                          if (notifList.length > 0) {
                            return buildNotifList(notifList, () {
                              setState(() {});
                            });
                          }
                          return Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: SizedBox(
                              width: constraint.maxWidth - 30 - 20 - 10,
                              child: Text("No Available Data",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey.shade800,
                                  )),
                            ),
                          );
                        } else {
                          return waitThreads(context);
                        }
                      }),
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
  final int id;
  final String title;
  final String content;
  final String date;
  final bool isRead;
  final VoidCallback onTap;
  NotificationController notificationController =
      Get.put(NotificationController());

  NotifCard({
    super.key,
    required this.id,
    required this.title,
    required this.content,
    required this.date,
    required this.isRead,
    required this.onTap,
  });

  // _onBasicAlertPressed(context) {
  //   Alert(
  //     context: context,
  //     title: "RFLUTTER ALERT",
  //     desc: "Flutter is more awesome with RFlutter Alert.",
  //   ).show();
  // }

  @override
  Widget build(BuildContext context) {
    String notifDate =
        DateFormat('MMMM dd, yyyy HH:mm').format(DateTime.parse(date));
    return LayoutBuilder(builder: (context, constraint) {
      return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          notificationController.readNotification(id);
          showDialog<String>(
            context: context,
            builder: (BuildContext context) => AlertDialog(
              title: Text(title),
              content: Text(content),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.pop(context, 'OK'),
                  child: Text('OK'),
                ),
              ],
            ),
          );
          onTap();
        },
        child: Container(
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
                    (isRead == true) ? Icons.email : Icons.mark_email_unread,
                    size: 35,
                    color: (isRead == true) ? Colors.grey : Colors.teal,
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
                            title,
                          )),
                      SizedBox(
                          width: constraint.maxWidth,
                          child: Text(
                            content,
                            style: TextStyle(color: Colors.grey.shade600),
                          )),
                      SizedBox(
                          width: constraint.maxWidth,
                          child: Text(
                            notifDate,
                            style: TextStyle(fontSize: 10, color: Colors.grey),
                          )),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
