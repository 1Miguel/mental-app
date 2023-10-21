import 'package:flutter/material.dart';
import 'dart:convert';

// Local import
import 'package:flutter_intro/controllers/mood_controller.dart';
import 'package:flutter_intro/model/mood.dart';
import 'package:flutter_intro/model/user.dart';
import 'package:flutter_intro/ui_views/dashboard_views.dart';
import 'package:flutter_intro/ui_views/membership_views.dart';
import 'package:flutter_intro/ui_views/mood_timeline.dart';
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
                            moodController.logMood(MoodId.SAD.index);
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
                            moodController.logMood(MoodId.CONFUSED.index);
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
                            moodController.logMood(MoodId.SAD.index);
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
                            moodController.logMood(MoodId.SCARED.index);
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

class MoodHistoryPage extends StatelessWidget {
  MoodController moodController = Get.put(MoodController());
  late Future<List<Mood>?> futureMoodHistory;

  Future<List<Mood>?> getMoodHistory() async {
    futureMoodHistory = moodController.fetchMoodHistory(DateTime.now());
    print('futureMoodHistory');
    print(futureMoodHistory);
    return futureMoodHistory;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 60,
        backgroundColor: Colors.transparent,
        title: Text(
          'Mood History',
          style: TextStyle(
            color: primaryGrey,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: SizedBox(
          width: 20,
          height: 20,
          child: Padding(
            padding: EdgeInsets.only(bottom: 3.0, left: 11.0),
            child: IconButton(
              icon: Icon(
                Icons.arrow_back,
                size: 30,
                color: primaryGrey,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ),
      ),
      body: FutureBuilder(
          future: getMoodHistory(),
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
                List<Mood>? data = snapshot.data;
                print('snapshot data');
                for (var i = 0; i < data!.length; i++) {
                  print(data[i]);
                  print(data[i].mood);
                }

                //String mystring = data.toString();
                // print('myString');
                // print(mystring);
                // Mood moodData = Mood.fromJson(jsonDecode(mystring));
                // print("moodData");
                // print(moodData);

                return Container(
                  color: Colors.white,
                  width: MediaQuery.sizeOf(context).width,
                  child: ListView(
                    children: [
                      Column(
                        children: [
                          SizedBox(height: 20),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 20.0, bottom: 10.0),
                            child: SizedBox(
                              width: MediaQuery.sizeOf(context).width - 20.0,
                              child: Text('October',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 25)),
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.sizeOf(context).width - 20.0,
                            child: MonthlyMoodSummary(),
                          ),
                          SizedBox(height: 30),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 20.0, bottom: 10.0),
                            child: SizedBox(
                              width: MediaQuery.sizeOf(context).width - 20.0,
                              child: Text('Today',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 25)),
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.sizeOf(context).width - 20.0,
                            child: TodayMoodInfo(),
                          ),
                        ],
                      ),
                      SizedBox(height: 50),
                    ],
                  ),
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

class MonthlyMoodSummary extends StatelessWidget {
  const MonthlyMoodSummary({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomLeft,
            colors: <Color>[pastelYellow, pastelYellow]),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 25.0),
                  child: SizedBox(
                      child: Text("This Month's Overview",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18))),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 25.0),
                  child: TextButton(
                    child: Text(
                      'More Info',
                      style: TextStyle(
                          color: solidPurple,
                          decoration: TextDecoration.underline),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: ((context) => MoodTimeline()),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0),
            child: MoodBar(
              moodLogo: 'images/happy_emoji.png',
              moodName: 'Happy',
              moodColor: Colors.pinkAccent,
              moodPercent: '50%',
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0),
            child: MoodBar(
              moodLogo: 'images/sad_emoji.png',
              moodName: 'Sad',
              moodColor: Colors.blueAccent,
              moodPercent: '40%',
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0),
            child: MoodBar(
              moodLogo: 'images/confused_emoji.png',
              moodName: 'Confused',
              moodColor: Colors.orangeAccent,
              moodPercent: '30%',
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0),
            child: MoodBar(
              moodLogo: 'images/angry_emoji.png',
              moodName: 'Angry',
              moodColor: Colors.redAccent,
              moodPercent: '20%',
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0),
            child: MoodBar(
              moodLogo: 'images/scared_emoji.png',
              moodName: 'Scared',
              moodColor: Colors.deepPurpleAccent,
              moodPercent: '10%',
            ),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}

class MoodBar extends StatelessWidget {
  final String moodLogo;
  final String moodName;
  final Color moodColor;
  final String moodPercent;

  const MoodBar({
    super.key,
    required this.moodLogo,
    required this.moodName,
    required this.moodColor,
    required this.moodPercent,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: MediaQuery.sizeOf(context).width - 50.0,
            child: Card(
              elevation: 1,
              surfaceTintColor: moodColor,
              shape: RoundedRectangleBorder(
                borderRadius: const BorderRadius.all(Radius.circular(20)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: SizedBox(
                      width: 40,
                      height: 40,
                      child: Image.asset(
                        moodLogo,
                      ),
                    ),
                  ),
                  Text(moodName),
                  Padding(
                    padding: const EdgeInsets.only(right: 20.0),
                    child: SizedBox(
                        height: 50,
                        width: 50,
                        child: Center(
                            child: Text(moodPercent,
                                style: TextStyle(
                                    fontFamily: 'Roboto',
                                    fontSize: 15,
                                    fontWeight: FontWeight.w900)))),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TodayMoodInfo extends StatelessWidget {
  const TodayMoodInfo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomLeft,
            colors: <Color>[primaryLightBlue, primaryBlue]),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Padding(
                //   padding: const EdgeInsets.only(left: 25.0),
                //   child: SizedBox(
                //       child: Text("My Mood Today",
                //           style: TextStyle(
                //               fontWeight: FontWeight.bold, fontSize: 18))),
                // ),
                // Padding(
                //   padding: const EdgeInsets.only(right: 25.0),
                //   child: Row(
                //     children: [
                //       SizedBox(
                //         child: IconButton(
                //           icon: Icon(
                //             Icons.note,
                //             size: 30,
                //             color: Colors.black87,
                //           ),
                //           onPressed: () {},
                //         ),
                //       ),
                //       // SizedBox(
                //       //   child: IconButton(
                //       //     icon: Icon(
                //       //       Icons.edit,
                //       //       size: 30,
                //       //       color: primaryGrey,
                //       //     ),
                //       //     onPressed: () {},
                //       //   ),
                //       // ),
                //     ],
                //   ),
                // ),
              ],
            ),
          ),
          SizedBox(height: 20),
          SizedBox(
            width: 150,
            height: 150,
            child: Image.asset(
              'images/happy_emoji.png',
            ),
          ),
          SizedBox(
            width: MediaQuery.sizeOf(context).width,
            child: Text(
              'HAPPY',
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            width: MediaQuery.sizeOf(context).width - 40.0,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: TextField(
                maxLines: 3,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: unselectedLightBlue,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(25.0)),
                  ),
                  hintText: 'Tell us how you feel...',
                ),
              ),
            ),
          ),
          SizedBox(height: 30),
        ],
      ),
    );
  }
}
