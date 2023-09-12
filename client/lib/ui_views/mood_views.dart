import 'package:flutter/material.dart';
import 'package:flutter_intro/ui_views/dashboard_views.dart';

class MoodModalPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final moodMessageList = {
      'Good': {
        'moodIcon': 'images/mood_good_logo.png',
        'mainMessage': "Glad to hear that you're feeling good",
        'secondaryMessage': "We hope all is well!",
      },
      'Unwell': {
        'moodIcon': 'images/mood_unwell_logo.png',
        'mainMessage': "Things are tough right now, but we're here",
        'secondaryMessage': "We hope all is well!",
      },
      'Unsure': {
        'moodIcon': 'images/mood_unsure_logo.png',
        'mainMessage': "No worries, we would be happy to help",
        'secondaryMessage': "We hope all is well!",
      },
    };
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 50,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Text(
              'Share how you',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w900,
                  fontSize: 40,
                  color: Colors.deepPurple),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Text(
              'feel daily.',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w900,
                  fontSize: 40,
                  color: Colors.deepPurple),
            ),
          ),
          SizedBox(
            height: 180,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Text(
              'How are you feeling today?',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  color: Colors.black),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MoodCardWidget(
                moodName: "Good",
                moodInfo: moodMessageList['Good'],
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: ((context) => MoodIntroPage(
                            moodName: "Good",
                            moodInfo: moodMessageList['Good'],
                            onTap: () {},
                          )),
                    ),
                  );
                },
              ),
              MoodCardWidget(
                moodName: "Unwell",
                moodInfo: moodMessageList['Unwell'],
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: ((context) => MoodIntroPage(
                            moodName: "Unwell",
                            moodInfo: moodMessageList['Unwell'],
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
                moodName: "Unsure",
                moodInfo: moodMessageList['Unsure'],
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: ((context) => MoodIntroPage(
                            moodName: "Unsure",
                            moodInfo: moodMessageList['Unsure'],
                            onTap: () {},
                          )),
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
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
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Pressed Follow on $moodName button"),
            duration: const Duration(seconds: 1),
          ),
        );
        onTap();
      },
      child: SizedBox(
        width: 180,
        height: 180,
        child: Card(
          elevation: 5.0,
          surfaceTintColor: Colors.grey,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: 130,
                  height: 130,
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
                  color: Colors.white,
                ),
              ),
            ],
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
        body: Column(
          children: [
            SizedBox(
              height: 100,
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
            Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10.0),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 220,
                child: Text(
                  mainMessage,
                  maxLines: 3,
                  softWrap: true,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.deepPurple,
                    fontWeight: FontWeight.w900,
                    fontSize: 50,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                secondaryMessage,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 20,
                  color: Colors.blue,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
