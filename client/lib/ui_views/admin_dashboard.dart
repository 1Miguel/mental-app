import 'package:flutter/material.dart';

// Local import
import 'package:flutter_intro/utils/colors_scheme.dart';

// Third-party imports
import 'package:sidebarx/sidebarx.dart';

GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();

class AdminDashboardPage extends StatefulWidget {
  const AdminDashboardPage({super.key});

  @override
  State<AdminDashboardPage> createState() => _AdminDashboardPageState();
}

class _AdminDashboardPageState extends State<AdminDashboardPage> {
  int _selectedIndex = 0;

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 0: Home',
      style: optionStyle,
    ),
    Text(
      'Index 1: Business',
      style: optionStyle,
    ),
    Text(
      'Index 2: School',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Philippine Mental Health Association',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontFamily: 'Proza Libre',
          ),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: <Color>[primaryLightBlue, primaryBlue]),
          ),
        ),
      ),
      body: Row(
        children: [
          SidebarX(
            controller: SidebarXController(selectedIndex: 0),
            items: const [
              SidebarXItem(icon: Icons.home, label: 'Home'),
              SidebarXItem(icon: Icons.search, label: 'Search'),
            ],
          ),
          // Your app screen body
          //MainBody(),
        ],
      ),
      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text('Drawer Header'),
            ),
            ListTile(
              title: const Text('Home'),
              selected: _selectedIndex == 0,
              onTap: () {
                // Update the state of the app
                _onItemTapped(0);
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Business'),
              selected: _selectedIndex == 1,
              onTap: () {
                // Update the state of the app
                _onItemTapped(1);
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('School'),
              selected: _selectedIndex == 2,
              onTap: () {
                // Update the state of the app
                _onItemTapped(2);
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class MainBody extends StatelessWidget {
  const MainBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 50),
        Padding(
          padding: const EdgeInsets.only(left: 60.0, top: 20.0, bottom: 20.0),
          child: SearchBarApp(),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 65.0, bottom: 15.0, top: 20.0),
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
    );
  }
}

class StatusBoxList extends StatelessWidget {
  const StatusBoxList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10.0, right: 10.0),
          child: StatusCard(
            count: "1",
            label: "Doctors",
            icon: Icons.medical_services,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10.0, right: 10.0),
          child: StatusCard(
              count: "5", label: "Patients", icon: Icons.wheelchair_pickup),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10.0, right: 10.0),
          child: StatusCard(
              count: "10", label: "New Booking", icon: Icons.bookmarks),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10.0, right: 10.0),
          child: StatusCard(
              count: "0", label: "Today Sessions", icon: Icons.monitor_heart),
        ),
      ],
    );
  }
}

class StatusCard extends StatelessWidget {
  final String count;
  final String label;
  final IconData icon;

  const StatusCard({
    super.key,
    required this.count,
    required this.label,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
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
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: StatusInfo(count: count, label: label),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 20.0),
              child: StatusIcon(icon: icon),
            ),
          ],
        ),
      ),
    );
  }
}

class StatusInfo extends StatelessWidget {
  final String count;
  final String label;

  const StatusInfo({
    super.key,
    required this.count,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            SizedBox(
              width: 150,
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
              width: 150,
              height: 50,
              child: Text(
                label,
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontFamily: 'Roboto',
                ),
              ),
            ),
          ],
        ),
      ],
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
    return Center(
      child: SizedBox(
        width: 50,
        height: 50,
        child: Container(
          color: iconBoxBgColor,
          child: Icon(
            icon,
            color: primaryGrey,
            size: 30.0,
          ),
        ),
      ),
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
    return Row(
      children: [
        SizedBox(
          width: 940,
          height: 50,
          child: SearchBar(
            surfaceTintColor: MaterialStateProperty.all<Color>(Colors.white),
            backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
            shape: MaterialStateProperty.all(
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(0))),
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
  }
}
