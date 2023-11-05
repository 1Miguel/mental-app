import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
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
                            print(MoodId.HAPPY.index);
                            moodController.logMood(MoodId.HAPPY.index, "");
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
                            moodController.logMood(MoodId.SAD.index, "");
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
                            moodController.logMood(MoodId.CONFUSED.index, "");
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
                            print(MoodId.ANGRY.index);
                            moodController.logMood(MoodId.ANGRY.index, "");
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
                            moodController.logMood(MoodId.SCARED.index, "");
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
  late Future<List> futureMoodSummary;
  MoodController moodController = Get.put(MoodController());

  MonthlyMoodSummary({
    super.key,
  });

  Future<List> getMoodSummary() async {
    futureMoodSummary = moodController.fetchMoodAverage(DateTime.now());
    print(futureMoodSummary);
    return futureMoodSummary;
  }

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
          SizedBox(
            height: 300,
            child: FutureBuilder<List>(
                future: getMoodSummary(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final moodAve = snapshot.data!;
                    return buildSummary(moodAve);
                  } else {
                    return const Text("No available Data");
                  }
                }),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget buildSummary(List moodAverage) => ListView.builder(
        itemCount: moodAverage.length,
        itemBuilder: (context, index) {
          final average = moodAverage[index];
          String moodLogo = 'images/happy_emoji.png';
          Color moodColor = Colors.pinkAccent;
          String moodName = "HAPPY";

          if (index == 1) {
            moodLogo = 'images/sad_emoji.png';
            moodColor = Colors.blueAccent;
            moodName = "SAD";
          } else if (index == 2) {
            moodLogo = 'images/confused_emoji.png';
            moodColor = Colors.orangeAccent;
            moodName = "CONFUSED";
          } else if (index == 3) {
            moodLogo = 'images/scared_emoji.png';
            moodColor = Colors.redAccent;
            moodName = "SCARED";
          } else if (index == 4) {
            moodLogo = 'images/angry_emoji.png';
            moodColor = Colors.deepPurple;
            moodName = "ANGRY";
          }

          return Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0),
            child: MoodBar(
              moodLogo: moodLogo,
              moodName: moodName,
              moodColor: moodColor,
              moodPercent: '$average%',
            ),
          );
        },
      );
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
  MoodController moodController = Get.put(MoodController());
  late Future<Mood> futureMood;
  final _formKey = GlobalKey<FormState>();

  TodayMoodInfo({
    super.key,
  });

  Future<Mood> getMoodToday() async {
    futureMood = moodController.fetchMoodToday(DateTime.now());
    print(futureMood);
    return futureMood;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomLeft,
              colors: <Color>[primaryLightBlue, primaryBlue]),
          borderRadius: BorderRadius.circular(30),
        ),
        child: FutureBuilder<Mood>(
            future: getMoodToday(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final todayMood = snapshot.data!;
                String moodLogo = 'images/happy_emoji.png';
                String moodName = "HAPPY";

                if (todayMood.mood == 1) {
                  moodLogo = 'images/sad_emoji.png';
                  moodName = "SAD";
                } else if (todayMood.mood == 2) {
                  moodLogo = 'images/confused_emoji.png';
                  moodName = "CONFUSED";
                } else if (todayMood.mood == 3) {
                  moodLogo = 'images/scared_emoji.png';
                  moodName = "SCARED";
                } else if (todayMood.mood == 4) {
                  moodLogo = 'images/angry_emoji.png';
                  moodName = "ANGRY";
                }
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 25.0),
                            child: SizedBox(
                                child: Text("My Mood Today",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18))),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 25.0),
                            child: Row(
                              children: [],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    SizedBox(
                      width: 150,
                      height: 150,
                      child: Image.asset(
                        moodLogo,
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.sizeOf(context).width,
                      child: Text(
                        moodName,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.sizeOf(context).width - 40.0,
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                        child: TextFormField(
                          controller: moodController.noteController,
                          //initialValue: "",
                          maxLines: 3,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: unselectedLightBlue,
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(25.0)),
                            ),
                            hintText: 'Tell us how you feel...',
                          ),
                        ),
                      ),
                    ),
                    FilledButton(
                      onPressed: () {
                        moodController.logMood(
                            todayMood.mood, moodController.noteController.text);
                      },
                      style: ButtonStyle(
                          minimumSize:
                              MaterialStateProperty.all<Size>(Size(200, 50)),
                          backgroundColor: MaterialStateProperty.all<Color>(
                              primaryLightBlue)),
                      child: Text(
                        'SAVE',
                        style: TextStyle(
                            fontFamily: 'Open Sans',
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(height: 30),
                  ],
                );
              } else {
                return const Text("No Mood Data");
              }
            }),
      ),
    );
  }
}

class MoodLogCarouselPage extends StatelessWidget {
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
    return LayoutBuilder(builder: (context, constraint) {
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
                  return Container(
                      width: constraint.maxWidth,
                      height: constraint.maxHeight,
                      child: MoodSlides(name: firstname));
                }
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            }),
      );
    });
  }
}

class MoodSlides extends StatelessWidget {
  final String name;
  const MoodSlides({
    super.key,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraint) {
      return Container(
        height: constraint.maxHeight,
        child: ImageSlideshow(
          indicatorColor: Colors.blue,
          onPageChanged: (value) {
            debugPrint('Page changed: $value');
          },
          isLoop: false,
          children: [
            MoodContext(
              name: name,
              title: 'HAPPY',
              image: 'images/happy_img.png',
              content:
                  "Find wellness, peace, and balance using the app's guided meditation and mindfulness techniques.",
              customColor: moodHappy,
              onTap: () {},
            ),
            MoodContext(
              name: name,
              title: 'SAD',
              image: 'images/sad_img.png',
              content:
                  "We will continue to enhance individual and collective well-being for a mentally healthy Philippines!",
              customColor: moodSad,
              onTap: () {},
            ),
            MoodContext(
              name: name,
              title: 'CONFUSED',
              image: 'images/confused_img.png',
              content:
                  "We will continue to enhance individual and collective well-being for a mentally healthy Philippines!",
              customColor: moodConfused,
              onTap: () {},
            ),
            MoodContext(
              name: name,
              title: 'ANGRY',
              image: 'images/angry_img.png',
              content:
                  "We will continue to enhance individual and collective well-being for a mentally healthy Philippines!",
              customColor: moodAngry,
              onTap: () {},
            ),
            MoodContext(
              name: name,
              title: 'SCARED',
              image: 'images/scared_img.png',
              content:
                  "We will continue to enhance individual and collective well-being for a mentally healthy Philippines!",
              customColor: moodScared,
              onTap: () {},
            ),
          ],
        ),
      );
    });
  }
}

class MoodContext extends StatelessWidget {
  MoodController moodController = Get.put(MoodController());
  final String image;
  final String name;
  final String title;
  final String content;
  final VoidCallback onTap;
  final Color customColor;

  MoodContext({
    super.key,
    required this.name,
    required this.title,
    required this.image,
    required this.content,
    required this.onTap,
    required this.customColor,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraint) {
      return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          print("Clicked $title");
          int index = MoodId.HAPPY.index;
          if (title == "SAD") {
            index = MoodId.SAD.index;
          } else if (title == "CONFUSED") {
            index = MoodId.CONFUSED.index;
          } else if (title == "ANGRY") {
            index = MoodId.ANGRY.index;
          } else if (title == "SCARED") {
            index = MoodId.SCARED.index;
          }
          moodController.logMood(index, "");
          //onTap();
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: ((context) => DashboardPage()),
            ),
          );
        },
        child: Container(
          color: customColor,
          width: constraint.maxWidth,
          height: constraint.maxHeight,
          child: Column(
            //color: Colors.pink,
            // elevation: 0,
            children: <Widget>[
              Container(
                width: constraint.maxWidth,
                height: constraint.maxHeight / 4,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    SizedBox(
                      width: constraint.maxWidth - 50,
                      child: Text(
                        "How do you feel today $name?",
                        softWrap: true,
                        maxLines: 3,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                          fontSize: 40,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: constraint.maxWidth,
                height: (constraint.maxHeight / 4) * 2,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.asset(image),
                ),
              ),
              Container(
                width: constraint.maxWidth,
                height: constraint.maxHeight / 4,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: constraint.maxWidth - 50,
                      child: TextButton(
                        child: Text(
                          'Skip',
                          style: TextStyle(
                              fontFamily: 'Open Sans',
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 15,
                              decoration: TextDecoration.underline),
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: ((context) => DashboardPage())));
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
