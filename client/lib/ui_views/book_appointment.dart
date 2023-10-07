import 'package:flutter/material.dart';
import 'package:flutter_intro/utils/colors_scheme.dart';
import 'package:table_calendar/table_calendar.dart';
import 'dashboard_views.dart';
import 'dart:convert';

// Loacl import
import 'package:flutter_intro/model/user.dart';

// Third-party import
import 'package:shared_preferences/shared_preferences.dart';

// Const
enum ConsulationServices { consultation, therapy, counseling, assessment }

class AccountNameHeadingText extends StatelessWidget {
  final String title;
  final bool isOverflow;
  final bool isHeavy;
  final Color customColor;

  const AccountNameHeadingText({
    super.key,
    required this.title,
    required this.isOverflow,
    required this.isHeavy,
    required this.customColor,
  });

  @override
  Widget build(BuildContext context) {
    //Overwrite size based on length
    double newSize = (title.length > 20) ? 25 : 30;
    FontWeight newWeight = isHeavy ? FontWeight.w700 : FontWeight.bold;
    return Text(
      title,
      textAlign: TextAlign.center,
      softWrap: true,
      maxLines: 2,
      style: TextStyle(
        color: customColor,
        fontFamily: 'Proza Libre',
        fontWeight: newWeight,
        fontSize: newSize,
      ),
    );
  }
}

class TimeBox extends StatelessWidget {
  final String time;

  const TimeBox({
    super.key,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return InputChip(
      label: Text(
        time,
        textAlign: TextAlign.center,
        style:
            TextStyle(fontFamily: 'Roboto', fontSize: 10, color: Colors.black),
      ),
      selectedColor: Colors.black26,
    );
  }
}

class BookAppointmentIntroPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            SizedBox(height: 60),
            Image.asset(
              'images/therapy_logo.png',
              fit: BoxFit.fitWidth,
              height: 400,
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'BOOK\nAPPOINTMENT',
                  softWrap: true,
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 40,
                      fontWeight: FontWeight.w800,
                      color: const Color.fromARGB(255, 0, 74, 173)),
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'We will continue to enhance\nindividual and collective well-being\nfor a mentally healthy Philippines!',
                  softWrap: true,
                  maxLines: 3,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 18,
                      color: const Color.fromARGB(255, 0, 74, 173)),
                ),
              ],
            ),
            SizedBox(height: 40),
            FilledButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: ((context) => BookAppointmentPage())));
              },
              style: ButtonStyle(
                  minimumSize: MaterialStateProperty.all<Size>(Size(200, 50)),
                  backgroundColor: MaterialStateProperty.all<Color>(
                      const Color.fromARGB(255, 0, 74, 173))),
              child: Text('GET STARTED'),
            ),
          ],
        ),
      ),
    );
  }
}

class BookAppointmentPage extends StatelessWidget {
  User emptyUser = User(
    id: 0,
    email: "",
    password_hash: "",
    firstname: "",
    lastname: "",
    address: "",
    age: 0,
    occupation: "",
  );

  getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString('user_data') ?? jsonEncode(emptyUser).toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 40,
        leading: SizedBox(
          width: 20,
          height: 20,
          child: Padding(
            padding: EdgeInsets.only(bottom: 3.0, left: 11.0),
            child: IconButton(
              icon: const Icon(
                Icons.arrow_back,
                size: 30,
                color: Colors.grey,
              ),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: ((context) => DashboardPage())));
              },
            ),
          ),
        ),
        title: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Text(
            'BOOK APPOINTMENT',
            style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: const Color.fromARGB(255, 0, 74, 173)),
          ),
        ),
      ),
      body: FutureBuilder(
          future: getUserData(),
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
                String mystring = data.toString();
                //Map<String, dynamic> myjson = jsonDecode(mystring);
                User userdata = User.fromJson(jsonDecode(mystring));
                String firstname = userdata.firstname;
                String lastname = userdata.lastname;
                String address = userdata.address;
                String occupation = userdata.occupation;
                int age = userdata.age;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BookAccountSummaryCard(
                      name: "$lastname, $firstname",
                      address: address,
                      occupation: occupation,
                      age: "$age yo",
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 30.0, top: 30.0),
                      child: Text(
                        "SERVICES",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: mainDeepPurple,
                          fontSize: 30,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 30.0),
                      child: Row(
                        children: [
                          BookIcon(
                            membershipTitle: "Psychiatric Consultation",
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: ((context) =>
                                          GenericConsultationPage(
                                            service: ConsulationServices
                                                .consultation,
                                            name: "$firstname, $lastname",
                                            address: address,
                                            occupation: occupation,
                                            age: "$age yo",
                                          ))));
                            },
                          ),
                          BookIcon(
                            membershipTitle: "Occupational Therapy",
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: ((context) =>
                                          GenericConsultationPage(
                                            service:
                                                ConsulationServices.therapy,
                                            name: "$firstname, $lastname",
                                            address: address,
                                            occupation: occupation,
                                            age: "$age yo",
                                          ))));
                            },
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 30.0),
                      child: Row(
                        children: [
                          BookIcon(
                            membershipTitle: "Counseling",
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: ((context) =>
                                          GenericConsultationPage(
                                            service:
                                                ConsulationServices.counseling,
                                            name: "$firstname, $lastname",
                                            address: address,
                                            occupation: occupation,
                                            age: "$age yo",
                                          ))));
                            },
                          ),
                          BookIcon(
                            membershipTitle: "Psychological Assesment",
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: ((context) =>
                                          GenericConsultationPage(
                                            service:
                                                ConsulationServices.assessment,
                                            name: "$firstname, $lastname",
                                            address: address,
                                            occupation: occupation,
                                            age: "$age yo",
                                          ))));
                            },
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 40.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FilledButton(
                            onPressed: () {},
                            style: ButtonStyle(
                                minimumSize: MaterialStateProperty.all<Size>(
                                    Size(200, 50)),
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Color.fromARGB(255, 0, 74, 173))),
                            child: Text('SELECT'),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              }
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
  }
}

class BookAccountSummaryCard extends StatelessWidget {
  final String name;
  final String address;
  final String occupation;
  final String age;

  const BookAccountSummaryCard({
    super.key,
    required this.name,
    required this.address,
    required this.occupation,
    required this.age,
  });

  @override
  Widget build(BuildContext context) {
    String details = "$address · $occupation · $age";
    return Center(
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 130,
        child: Card(
          elevation: 0,
          surfaceTintColor: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Row(
                children: [
                  SizedBox(
                    width: 80,
                    height: 120,
                    child: IconButton(
                      icon: Image.asset('images/generic_user.png'),
                      iconSize: 5.0,
                      onPressed: () {},
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.sizeOf(context).width - 100,
                    height: 100,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: AccountNameHeadingText(
                                title: name,
                                isOverflow: true,
                                isHeavy: true,
                                customColor: mainBlue,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: Text(
                                details,
                                softWrap: true,
                                maxLines: 3,
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    color: Colors.deepPurple, fontSize: 12),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BookIcon extends StatelessWidget {
  final String membershipTitle;
  final VoidCallback onTap;

  const BookIcon({
    super.key,
    required this.membershipTitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              onTap();
            },
            child: Container(
              height: 140,
              width: 140,
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  border: Border.all(width: 20, color: Colors.grey)),
              child: SizedBox(
                height: 120,
                width: 120,
                child: Image.asset(
                  'images/membership_logo.png',
                ),
              ),
            ),
          ),
          SizedBox(
            width: 170,
            child: Text(
              membershipTitle,
              textAlign: TextAlign.center,
              softWrap: true,
              maxLines: 2,
              style: TextStyle(
                color: mainDeepPurple,
                fontWeight: FontWeight.bold,
                fontFamily: 'Roboto',
                fontSize: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class GenericConsultationPage extends StatelessWidget {
  final ConsulationServices service;
  // TODO: use datamodel once integrating
  final String name;
  final String address;
  final String occupation;
  final String age;

  const GenericConsultationPage({
    super.key,
    required this.service,
    required this.name,
    required this.address,
    required this.occupation,
    required this.age,
  });

  @override
  Widget build(BuildContext context) {
    var title = "Psychiatric Consultation";
    var subheading =
        "A comprehensive evaluation of the psychological, biological, medical and social causes of emotional distress.";
    if (service == ConsulationServices.therapy) {
      title = "Occupational Therapy";
      subheading =
          "Helps patients develop, recover, improve, as well as maintain the skills needed for daily living and working.";
    } else if (service == ConsulationServices.counseling) {
      title = "Counseling";
      subheading =
          "Learn about your condition and your moods, feelings, thoughts, and behaviors.";
    } else if (service == ConsulationServices.assessment) {
      title = "Psychological Assesment";
      subheading =
          "To understand a person's strengths, and weaknesses, identify potential problem with cognitions, emotional reactivity, and make recommendations for treatment/remediation.";
    }
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 40,
        leading: SizedBox(
          width: 20,
          height: 20,
          child: Padding(
            padding: EdgeInsets.only(bottom: 3.0, left: 11.0),
            child: IconButton(
              icon: const Icon(
                Icons.arrow_back,
                size: 30,
                color: Colors.grey,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ),
        title: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Text(
            'BOOK APPOINTMENT',
            style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: const Color.fromARGB(255, 0, 74, 173)),
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BookAccountSummaryCard(
            name: name,
            address: address,
            occupation: occupation,
            age: age,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 30.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                BookIcon(
                  membershipTitle: title,
                  onTap: () {},
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 30.0),
            child: SizedBox(
              height: 80,
              width: MediaQuery.sizeOf(context).width,
              child: Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                child: Text(
                  subheading,
                  softWrap: true,
                  maxLines: 6,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 15,
                      color: Colors.black54),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30.0, top: 30.0),
            child: Text(
              "Concerns",
              textAlign: TextAlign.left,
              style: TextStyle(
                color: const Color.fromARGB(255, 0, 74, 173),
                fontSize: 30,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: MediaQuery.sizeOf(context).width - 20.0,
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                  child: TextField(
                    maxLines: 3,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(25.0)),
                      ),
                      hintText: 'Please note here your concern',
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 30.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FilledButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: ((context) => BookSchedulePage())));
                  },
                  style: ButtonStyle(
                      minimumSize:
                          MaterialStateProperty.all<Size>(Size(200, 50)),
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Color.fromARGB(255, 0, 74, 173))),
                  child: Text('BOOK'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class BookSchedulePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 40,
        leading: SizedBox(
          width: 20,
          height: 20,
          child: Padding(
            padding: EdgeInsets.only(bottom: 3.0, left: 11.0),
            child: IconButton(
              icon: const Icon(
                Icons.arrow_back,
                size: 30,
                color: Colors.grey,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ),
        title: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Text(
            'BOOK APPOINTMENT',
            style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: const Color.fromARGB(255, 0, 74, 173)),
          ),
        ),
      ),
      body: Column(
        children: [
          BookAccountSummaryCard(
            name: "Philippine Mental Health Association-Palawan Chapter",
            address: "Manalo Extension, Puerto Princesa",
            occupation: "",
            age: "",
          ),
          SizedBox(
            width: MediaQuery.sizeOf(context).width,
            child: Padding(
              padding: const EdgeInsets.only(left: 30.0, top: 20.0),
              child: Text(
                'DATE',
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          SizedBox(
            width: MediaQuery.sizeOf(context).width,
            height: 380,
            child: TableCalendar(
              firstDay: DateTime.utc(2010, 10, 16),
              lastDay: DateTime.utc(2030, 3, 14),
              focusedDay: DateTime.now(),
            ),
          ),
          SizedBox(
            width: MediaQuery.sizeOf(context).width,
            child: Padding(
              padding: const EdgeInsets.only(left: 30.0),
              child: Text(
                'TIME',
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TimeBox(time: "11:00"),
              TimeBox(time: "14:30"),
              TimeBox(time: "15:00"),
              TimeBox(time: "14:30"),
              TimeBox(time: "15:00"),
            ],
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: TimeBox(time: "11:00"),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FilledButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: ((context) => DashboardPage())));
                  },
                  style: ButtonStyle(
                      minimumSize:
                          MaterialStateProperty.all<Size>(Size(200, 50)),
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.deepPurple)),
                  child: Text('BOOK'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
