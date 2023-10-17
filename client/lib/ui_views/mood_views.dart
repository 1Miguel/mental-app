import 'package:flutter/material.dart';
import 'dart:convert';

// Local import
import 'package:flutter_intro/controllers/mood_controller.dart';
import 'package:flutter_intro/model/user.dart';
import 'package:flutter_intro/ui_views/dashboard_views.dart';
import 'package:flutter_intro/ui_views/membership_views.dart';
import 'package:flutter_intro/utils/colors_scheme.dart';

// Third-party import
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';

class MoodModalPage extends StatelessWidget {
  MoodController moodController = Get.put(MoodController());
  User emptyUser = User(
    id: 0,
    email: "",
    password_hash: "",
    firstname: "",
    lastname: "",
    address: "",
    age: 0,
    occupation: "",
    contact_number: "",
  );

  getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString('user_data') ?? jsonEncode(emptyUser).toString();
  }

  @override
  Widget build(BuildContext context) {
    final moodMessageList = {
      'Happy': {
        'moodIcon': 'images/happy_emoji.png',
        'mainMessage': "Glad to hear that you're feeling good",
        'secondaryMessage': "We hope all is well!",
      },
      'Sad': {
        'moodIcon': 'images/sad_emoji.png',
        'mainMessage': "Things are tough right now, but we're here",
        'secondaryMessage': "We hope all is well!",
      },
      'Confused': {
        'moodIcon': 'images/confused_emoji.png',
        'mainMessage': "No worries, we would be happy to help",
        'secondaryMessage': "We hope all is well!",
      },
      'Angry': {
        'moodIcon': 'images/angry_emoji.png',
        'mainMessage': "Things are tough right now, but we're here",
        'secondaryMessage': "We hope all is well!",
      },
      'Scared': {
        'moodIcon': 'images/scared_emoji.png',
        'mainMessage': "No worries, we would be happy to help",
        'secondaryMessage': "We hope all is well!",
      },
    };
    return Scaffold(
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

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 100,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width - 40,
                      child: Text(
                        'How do you feel today, $firstname?',
                        textAlign: TextAlign.center,
                        softWrap: true,
                        maxLines: 2,
                        style: TextStyle(
                            fontFamily: 'Proza Libre',
                            fontWeight: FontWeight.w900,
                            fontSize: 40,
                            color: primaryBlue),
                      ),
                    ),
                    SizedBox(
                      height: 100,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Text(
                        "It's good to share how you're feeling",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: 'Asap',
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MoodCardWidget(
                          moodName: "Happy",
                          moodInfo: moodMessageList['Happy'],
                          onTap: () {
                            moodController.logMood(MoodId.HAPPY.index);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: ((context) => HappyMoodPage(
                                      moodName: "Happy",
                                      moodInfo: moodMessageList['Happy'],
                                      onTap: () {},
                                    )),
                              ),
                            );
                          },
                        ),
                        MoodCardWidget(
                          moodName: "Sad",
                          moodInfo: moodMessageList['Sad'],
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: ((context) => SadMoodPage(
                                      moodName: "Sad",
                                      moodInfo: moodMessageList['Sad'],
                                      onTap: () {},
                                    )),
                              ),
                            );
                          },
                        ),
                        MoodCardWidget(
                          moodName: "Confused",
                          moodInfo: moodMessageList['Confused'],
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: ((context) => MoodIntroPage(
                                      moodName: "Confused",
                                      moodInfo: moodMessageList['Confused'],
                                      onTap: () {},
                                    )),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MoodCardWidget(
                          moodName: "Angry",
                          moodInfo: moodMessageList['Angry'],
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: ((context) => MoodIntroPage(
                                      moodName: "Angry",
                                      moodInfo: moodMessageList['Angry'],
                                      onTap: () {},
                                    )),
                              ),
                            );
                          },
                        ),
                        MoodCardWidget(
                          moodName: "Scared",
                          moodInfo: moodMessageList['Scared'],
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: ((context) => MoodIntroPage(
                                      moodName: "Scared",
                                      moodInfo: moodMessageList['Scared'],
                                      onTap: () {},
                                    )),
                              ),
                            );
                          },
                        ),
                      ],
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

class MoodCardWidget extends StatelessWidget {
  final String moodName;
  Map<String, String>? moodInfo;
  final VoidCallback onTap;

  MoodCardWidget({
    super.key,
    required this.moodName,
    required this.moodInfo,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    String moodIcon = moodInfo!['moodIcon'] ?? 'images/missing.png';
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        onTap();
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 15.0),
        child: SizedBox(
          width: 130,
          height: 150,
          child: Card(
            elevation: 1.0,
            surfaceTintColor: Colors.grey,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: 100,
                    height: 100,
                    child: Image.asset(
                      moodIcon,
                    ),
                  ),
                ),
                Text(
                  moodName,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MoodIntroPage extends StatelessWidget {
  final String moodName;
  Map<String, String>? moodInfo;
  final VoidCallback onTap;

  MoodIntroPage({
    super.key,
    required this.moodName,
    required this.moodInfo,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    String moodIcon = moodInfo!['moodIcon'] ?? 'images/missing.png';
    String mainMessage = moodInfo!['mainMessage'] ?? 'UNKNOWN';
    String secondaryMessage = moodInfo!['secondaryMessage'] ?? 'UNKNOWN';
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        onTap();
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: ((context) => DashboardPage()),
          ),
        );
      },
      child: Scaffold(
        body: Container(
          color: backgroundColor,
          child: Column(
            children: [
              SizedBox(
                height: 180,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 300,
                    child: Image.asset(
                      moodIcon,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width - 60,
                  child: Text(
                    mainMessage,
                    maxLines: 3,
                    softWrap: true,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: primaryBlue,
                      fontFamily: 'Proza Libre',
                      fontWeight: FontWeight.w700,
                      fontSize: 30,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width - 60,
                  child: Text(
                    secondaryMessage,
                    maxLines: 3,
                    softWrap: true,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: primaryBlue,
                      fontFamily: 'Open Sans',
                      fontWeight: FontWeight.w700,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SadMoodPage extends StatelessWidget {
  final String moodName;
  Map<String, String>? moodInfo;
  final VoidCallback onTap;

  SadMoodPage({
    super.key,
    required this.moodName,
    required this.moodInfo,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    String moodIcon = moodInfo!['moodIcon'] ?? 'images/missing.png';
    String mainMessage = moodInfo!['mainMessage'] ?? 'UNKNOWN';
    String secondaryMessage = moodInfo!['secondaryMessage'] ?? 'UNKNOWN';
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        onTap();
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: ((context) => DashboardPage()),
          ),
        );
      },
      child: Scaffold(
        body: Container(
          color: backgroundColor,
          child: Column(
            children: [
              SizedBox(
                height: 100,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width - 60,
                  child: Text(
                    mainMessage,
                    maxLines: 3,
                    softWrap: true,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: primaryBlue,
                      fontFamily: 'Proza Libre',
                      fontWeight: FontWeight.w700,
                      fontSize: 30,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 300,
                    child: Image.asset(
                      moodIcon,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: SizedBox(
                  width: MediaQuery.sizeOf(context).width - 150,
                  child: Text(
                    "Would you like to tell us more about it?",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Open Sans',
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black54,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 50),
              FilledButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: ((context) => DashboardPage()),
                    ),
                  );
                },
                style: ButtonStyle(
                    minimumSize: MaterialStateProperty.all<Size>(Size(200, 50)),
                    backgroundColor:
                        MaterialStateProperty.all<Color>(primaryLightBlue)),
                child: Text(
                  'YES',
                  style: TextStyle(
                      fontFamily: 'Open Sans', fontWeight: FontWeight.bold),
                ),
              ),
              TextButton(
                child: Text(
                  'No Thanks',
                  style: TextStyle(
                      fontFamily: 'Open Sans',
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: ((context) => DashboardPage()),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HappyMoodPage extends StatelessWidget {
  final String moodName;
  Map<String, String>? moodInfo;
  final VoidCallback onTap;

  HappyMoodPage({
    super.key,
    required this.moodName,
    required this.moodInfo,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    String moodIcon = moodInfo!['moodIcon'] ?? 'images/missing.png';
    String mainMessage = moodInfo!['mainMessage'] ?? 'UNKNOWN';
    String secondaryMessage = moodInfo!['secondaryMessage'] ?? 'UNKNOWN';
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        onTap();
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: ((context) => DashboardPage()),
          ),
        );
      },
      child: Scaffold(
        body: Container(
          color: backgroundColor,
          child: Column(
            children: [
              SizedBox(
                height: 100,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width - 60,
                  child: Text(
                    mainMessage,
                    maxLines: 3,
                    softWrap: true,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: primaryBlue,
                      fontFamily: 'Proza Libre',
                      fontWeight: FontWeight.w700,
                      fontSize: 30,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 300,
                    child: Image.asset(
                      moodIcon,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              SizedBox(
                width: MediaQuery.sizeOf(context).width - 150,
                child: Row(
                  children: [
                    Text(
                      "Would you like to be a  ",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Open Sans',
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black54,
                      ),
                    ),
                    Text(
                      "volunteer?",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Open Sans',
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryBlue,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 50),
              FilledButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: ((context) => MembershipIntroPage()),
                    ),
                  );
                },
                style: ButtonStyle(
                    minimumSize: MaterialStateProperty.all<Size>(Size(200, 50)),
                    backgroundColor:
                        MaterialStateProperty.all<Color>(primaryLightBlue)),
                child: Text(
                  'YES',
                  style: TextStyle(
                      fontFamily: 'Open Sans', fontWeight: FontWeight.bold),
                ),
              ),
              TextButton(
                child: Text(
                  'No Thanks',
                  style: TextStyle(
                      fontFamily: 'Open Sans',
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: ((context) => DashboardPage()),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
