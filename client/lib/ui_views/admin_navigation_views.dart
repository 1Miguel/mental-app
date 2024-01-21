// standard import
import 'package:flutter/material.dart';
import 'package:flutter_intro/ui_views/admin_users.dart';
import 'package:flutter_intro/ui_views/login_views.dart';
import 'package:shared_preferences/shared_preferences.dart';

// local import
import 'admin_dashboard.dart';
import 'admin_appointment_requests.dart';
import 'admin_appointment_calendar.dart';
import 'admin_membership_requests.dart';
import 'admin_donation_requests.dart';

// third-party import
import 'package:sidebarx/sidebarx.dart';

class AdminApp extends StatelessWidget {
  AdminApp({Key? key}) : super(key: key);

  final _controller = SidebarXController(selectedIndex: 0, extended: true);
  final _key = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PMHA Admin',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: primaryColor,
        canvasColor: scaffoldBackgroundColor,
        scaffoldBackgroundColor: scaffoldBackgroundColor,
        textTheme: const TextTheme(
          headlineSmall: TextStyle(
            color: primaryColor,
            fontSize: 46,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
      home: Builder(
        builder: (context) {
          final isSmallScreen = MediaQuery.of(context).size.width < 600;
          return Scaffold(
            key: _key,
            appBar: isSmallScreen
                ? AppBar(
                    backgroundColor: canvasColor,
                    title: Text(_getTitleByIndex(_controller.selectedIndex)),
                    leading: IconButton(
                      onPressed: () {
                        // if (!Platform.isAndroid && !Platform.isIOS) {
                        //   _controller.setExtended(true);
                        // }
                        _key.currentState?.openDrawer();
                      },
                      icon: const Icon(Icons.menu),
                    ),
                  )
                : null,
            drawer: AdminSidebarX(controller: _controller),
            body: Row(
              children: [
                if (!isSmallScreen) AdminSidebarX(controller: _controller),
                Expanded(
                  child: Center(
                    child: _ScreensExample(
                      controller: _controller,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class AdminSidebarX extends StatelessWidget {
  const AdminSidebarX({
    Key? key,
    required SidebarXController controller,
  })  : _controller = controller,
        super(key: key);

  final SidebarXController _controller;

  Future<bool?> isSuperUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? isSuper;

    if (prefs.containsKey('is_super')) {
      isSuper = prefs.getBool('is_super');
    }
    return isSuper;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: isSuperUser(),
        initialData: false,
        builder: (BuildContext context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.deepPurpleAccent,
              ),
            );
          }
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return Center(
                child: Text(
                  'An ${snapshot.error} occurred',
                  style: const TextStyle(fontSize: 18, color: Colors.red),
                ),
              );
            } else if (snapshot.hasData) {
              final data = snapshot.data;
              if (data == true) {
                return SidebarX(
                  controller: _controller,
                  theme: SidebarXTheme(
                    margin: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: canvasColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    hoverColor: scaffoldBackgroundColor,
                    textStyle: TextStyle(color: Colors.white.withOpacity(0.7)),
                    selectedTextStyle: const TextStyle(color: Colors.white),
                    itemTextPadding: const EdgeInsets.only(left: 30),
                    selectedItemTextPadding: const EdgeInsets.only(left: 30),
                    itemDecoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: canvasColor),
                    ),
                    selectedItemDecoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: actionColor.withOpacity(0.37),
                      ),
                      gradient: const LinearGradient(
                        colors: [accentCanvasColor, canvasColor],
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.28),
                          blurRadius: 30,
                        )
                      ],
                    ),
                    iconTheme: IconThemeData(
                      color: Colors.white.withOpacity(0.7),
                      size: 20,
                    ),
                    selectedIconTheme: const IconThemeData(
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                  extendedTheme: const SidebarXTheme(
                    width: 200,
                    decoration: BoxDecoration(
                      color: canvasColor,
                    ),
                  ),
                  footerDivider: divider,
                  headerBuilder: (context, extended) {
                    return SizedBox(
                      height: 200,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Image.asset('images/pmha_logo_rembg.png'),
                      ),
                    );
                  },
                  items: [
                    SidebarXItem(
                      icon: Icons.home,
                      label: 'Home',
                      onTap: () {
                        debugPrint('Home');
                      },
                    ),
                    const SidebarXItem(
                      icon: Icons.schedule,
                      label: 'Schedule',
                    ),
                    const SidebarXItem(
                      icon: Icons.today,
                      label: 'Appointment',
                    ),
                    const SidebarXItem(
                      icon: Icons.group,
                      label: 'Users',
                    ),
                  ],
                );
              } else {
                return SidebarX(
                  controller: _controller,
                  theme: SidebarXTheme(
                    margin: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: canvasColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    hoverColor: scaffoldBackgroundColor,
                    textStyle: TextStyle(color: Colors.white.withOpacity(0.7)),
                    selectedTextStyle: const TextStyle(color: Colors.white),
                    itemTextPadding: const EdgeInsets.only(left: 30),
                    selectedItemTextPadding: const EdgeInsets.only(left: 30),
                    itemDecoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: canvasColor),
                    ),
                    selectedItemDecoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: actionColor.withOpacity(0.37),
                      ),
                      gradient: const LinearGradient(
                        colors: [accentCanvasColor, canvasColor],
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.28),
                          blurRadius: 30,
                        )
                      ],
                    ),
                    iconTheme: IconThemeData(
                      color: Colors.white.withOpacity(0.7),
                      size: 20,
                    ),
                    selectedIconTheme: const IconThemeData(
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                  extendedTheme: const SidebarXTheme(
                    width: 200,
                    decoration: BoxDecoration(
                      color: canvasColor,
                    ),
                  ),
                  footerDivider: divider,
                  headerBuilder: (context, extended) {
                    return SizedBox(
                      height: 200,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Image.asset('images/pmha_logo_rembg.png'),
                      ),
                    );
                  },
                  items: [
                    SidebarXItem(
                      icon: Icons.home,
                      label: 'Home',
                      onTap: () {
                        debugPrint('Home');
                      },
                    ),
                    const SidebarXItem(
                      icon: Icons.schedule,
                      label: 'Schedule',
                    ),
                    const SidebarXItem(
                      icon: Icons.today,
                      label: 'Appointment',
                    ),
                  ],
                );
              }
            }
          }
          // non data
          return const Center(
            child: CircularProgressIndicator(),
          );
        });
  }
}

class _ScreensExample extends StatelessWidget {
  const _ScreensExample({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final SidebarXController controller;

  Future<bool?> isSuperUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? isSuper;

    if (prefs.containsKey('is_super')) {
      isSuper = prefs.getBool('is_super');
    }
    return isSuper;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return FutureBuilder(
      future: isSuperUser(),
      initialData: false,
      builder: (BuildContext context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.deepPurpleAccent,
            ),
          );
        }
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return Center(
              child: Text(
                'An ${snapshot.error} occurred',
                style: const TextStyle(fontSize: 18, color: Colors.red),
              ),
            );
          } else if (snapshot.hasData) {
            final data = snapshot.data;
            if (data == true) {
              return AnimatedBuilder(
                  animation: controller,
                  builder: (context, child) {
                    final pageTitle =
                        _getTitleByIndexSuper(controller.selectedIndex);
                    switch (controller.selectedIndex) {
                      case 0:
                        return MainBody();
                      case 1:
                        return ScheduleCalendarView();
                      case 2:
                        return AppointmentRequestsMainView();
                      case 3:
                        return AdminUsersMainView();

                      default:
                        return Text(
                          pageTitle,
                          style: theme.textTheme.headlineSmall,
                        );
                    }
                  });
            }
          }
          return AnimatedBuilder(
              animation: controller,
              builder: (context, child) {
                final pageTitle = _getTitleByIndex(controller.selectedIndex);
                switch (controller.selectedIndex) {
                  case 0:
                    return MainBody();
                  case 1:
                    return ScheduleCalendarView();
                  case 2:
                    return AppointmentRequestsMainView();

                  default:
                    return Text(
                      pageTitle,
                      style: theme.textTheme.headlineSmall,
                    );
                }
              });
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}

String _getTitleByIndex(int index) {
  switch (index) {
    case 0:
      return 'Home';
    case 1:
      return 'Schedule';
    case 2:
      return 'Appointment';
    default:
      return 'Not found page';
  }
}

String _getTitleByIndexSuper(int index) {
  switch (index) {
    case 0:
      return 'Home';
    case 1:
      return 'Schedule';
    case 2:
      return 'Appointment';
    case 3:
      return 'Users';
    default:
      return 'Not found page';
  }
}

const primaryColor = Colors.teal;
const canvasColor = Colors.teal;
const accentCanvasColor = Colors.tealAccent;
final actionColor = Colors.teal.shade900;

//const primaryColor = Color(0xFF445fd2);
//const canvasColor = Color(0xFF445fd2);
//const canvasColor = Color(0xFF445fd2);
const scaffoldBackgroundColor = Color(0xFFf9fafb);
//const accentCanvasColor = Color(0xFF2196F3);
const white = Colors.white;
// final actionColor = const Color(0xFF5F5FA7).withOpacity(0.6);
final divider = Divider(color: white.withOpacity(0.3), height: 1);
