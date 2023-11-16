import 'package:flutter/material.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

void _handleOptIn() {
  OneSignal.User.pushSubscription.optIn();
}

void _handleOptOut() {
  OneSignal.User.pushSubscription.optOut();
}

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool msgNotif = false;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraint) {
      const double appBarHeight = 80;
      const double botBarHeight = 60;
      double bodyHeight = constraint.maxHeight - appBarHeight - botBarHeight;
      return Scaffold(
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
          title: Text("SETTINGS",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.w900)),
          centerTitle: true,
          leading: SizedBox(
            width: 20,
            height: 20,
            child: Padding(
              padding: EdgeInsets.only(bottom: 3.0, left: 11.0),
              child: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  size: 30,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ),
        ),
        body: Container(
          width: constraint.maxWidth,
          height: constraint.maxHeight - appBarHeight,
          child: Column(
            children: [
              SizedBox(height: 20),
              // Padding(
              //   padding: const EdgeInsets.only(left: 20.0, right: 20.0),
              //   child: SizedBox(
              //       width: constraint.maxWidth - 40,
              //       child: Text(
              //           "Contact us through any of the following below for more information.",
              //           style: TextStyle(
              //               fontSize: 18, color: Colors.tealAccent.shade700))),
              // ),
              // SizedBox(height: 10),
              // Divider(),
              ListTile(
                contentPadding:
                    EdgeInsets.only(left: 20.0, right: 30.0, top: 10.0),
                leading: CircleAvatar(
                  backgroundColor: Colors.lightBlue,
                  radius: 20,
                  child: Icon(Icons.alarm, size: 25, color: Colors.white),
                ),
                trailing: Switch(
                  // This bool value toggles the switch.
                  value: msgNotif,
                  activeColor: Colors.lightBlueAccent,
                  onChanged: (bool value) {
                    // This is called when the user toggles the switch.
                    setState(() {
                      msgNotif = value;
                      if (msgNotif == true) {
                        _handleOptIn();
                      } else {
                        _handleOptOut();
                      }
                    });
                  },
                ),
                horizontalTitleGap: 30.0,
                title: Text("Message Notification"),
                onTap: () {
                  //onTap();
                },
              ),
            ],
          ),
        ),
      );
    });
  }
}
