import 'package:flutter/material.dart';

// Local import
import 'package:flutter_intro/ui_views/youtube_player.dart';
import 'package:flutter_intro/ui_views/community_views.dart';

// Third-party
import 'package:flutter_intro/utils/colors_scheme.dart';
import 'package:url_launcher/url_launcher.dart';

class TalkToUsIntroPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: ((context) => DashboardPage()),
        //   ),
        // );
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          child: Column(
            children: [
              SizedBox(height: 80),
              Image.asset(
                'images/therapy_logo.png',
                width: 300,
                fit: BoxFit.fitWidth,
                height: 400,
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Talk to Us',
                    style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 40,
                        fontWeight: FontWeight.w800,
                        color: primaryPurple),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "We'd be happy to listen to you, name",
                    softWrap: true,
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: 'Open Sans',
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87),
                  ),
                ],
              ),
              SizedBox(height: 70),
              FilledButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => TalkToUsPage())));
                },
                style: ButtonStyle(
                    minimumSize: MaterialStateProperty.all<Size>(Size(200, 50)),
                    backgroundColor:
                        MaterialStateProperty.all<Color>(mainBlue)),
                child: Text('GET STARTED'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class EmotionCard extends StatelessWidget {
  final Color custColor;
  final String emotionName;
  final VoidCallback onTap;
  double sizex = 80;
  double sizey = 80;
  double boxsize = 30;

  EmotionCard({
    super.key,
    required this.custColor,
    required this.emotionName,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        onTap();
      },
      child: SizedBox(
        width: sizex + boxsize,
        height: sizex + boxsize,
        child: Card(
          elevation: 0,
          child: Column(
            children: [
              SizedBox(
                height: sizex,
                width: sizey,
                child: Container(
                  //color: Colors.yellow,
                  decoration: BoxDecoration(
                    color: custColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              Text(
                emotionName,
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
    );
  }
}

class TalkToUsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: <Color>[primaryLightBlue, primaryBlue]),
          ),
        ),
        toolbarHeight: 60,
        leading: SizedBox(
          width: 20,
          height: 20,
          child: Padding(
            padding: EdgeInsets.only(bottom: 3.0, left: 11.0),
            child: IconButton(
              icon: const Icon(
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
        title: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Text(
            'TALK TO US',
            style: TextStyle(
                fontFamily: 'Proza Libre',
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white),
          ),
        ),
      ),
      body: Container(
        child: ListView(
          children: [
            Column(children: [
              Padding(
                padding: const EdgeInsets.only(top: 30.0, left: 15.0),
                child: SizedBox(
                  width: MediaQuery.sizeOf(context).width,
                  child: Text(
                    'Tell us how you feel right now, {name}',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      color: primaryGrey,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Asap',
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
              Divider(),
              Padding(
                padding: const EdgeInsets.only(top: 5.0, left: 25.0),
                child: SizedBox(
                  width: MediaQuery.sizeOf(context).width,
                  child: Text(
                    'Please select one of the following emotions',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      color: primaryGrey,
                      //fontWeight: FontWeight.bold,
                      fontFamily: 'Asap',
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  EmotionCard(
                    custColor: Colors.yellow,
                    emotionName: 'Happy',
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: ((context) => GenericEmotionSurveyPage(
                                    choice0:
                                        "I feel happy because I got together with my friends",
                                    choice1: "I got promoted from work",
                                    choice2: "I just got a new pet",
                                    choice3: "I passed the exam",
                                  ))));
                    },
                  ),
                  EmotionCard(
                    custColor: Colors.yellow.shade300,
                    emotionName: 'Hopeful',
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: ((context) => GenericEmotionSurveyPage(
                                    choice0: "I'll finish the task given to me",
                                    choice1:
                                        "My mental wellbeing is going to be okay",
                                    choice2: "My confidence is improving",
                                    choice3: "I can achieve a healthy body",
                                  ))));
                    },
                  ),
                  EmotionCard(
                    custColor: Colors.pink.shade50,
                    emotionName: 'Love',
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: ((context) => GenericEmotionSurveyPage(
                                    choice0: "I feel loved today",
                                    choice1:
                                        "My childhood friend confessed love to me",
                                    choice2: "I received gift from my parents",
                                    choice3:
                                        "My friends surprised me on my birthday",
                                  ))));
                    },
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  EmotionCard(
                    custColor: Colors.lightGreen.shade400,
                    emotionName: 'Excited',
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: ((context) => GenericEmotionSurveyPage(
                                    choice0: "I just got a new phone",
                                    choice1:
                                        "I'm going to a trip with my family",
                                    choice2: "I'm graduating this year",
                                    choice3:
                                        "I'm going to receive my order from a seller this week",
                                  ))));
                    },
                  ),
                  EmotionCard(
                    custColor: Colors.green,
                    emotionName: 'Growth',
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: ((context) => GenericEmotionSurveyPage(
                                    choice0: "I learned a new talent",
                                    choice1: "I overcame my sadness",
                                    choice2: "I'm not insecure anymore",
                                    choice3:
                                        "I forgave someone I hated for so long",
                                  ))));
                    },
                  ),
                  EmotionCard(
                    custColor: Colors.green.shade300,
                    emotionName: 'Proud',
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: ((context) => GenericEmotionSurveyPage(
                                    choice0: "I got high grades",
                                    choice1: "Got out of my comfort zone",
                                    choice2:
                                        "I fixed my laptop without help from others",
                                    choice3:
                                        "I achieved the goal I want this month",
                                  ))));
                    },
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  EmotionCard(
                    custColor: Colors.red,
                    emotionName: 'Angry',
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: ((context) => GenericEmotionSurveyPage(
                                    choice0: "Why am I so angry",
                                    choice1: "I hate my life",
                                    choice2: "I don't like my friends",
                                    choice3:
                                        "I feel disrespected by other people",
                                  ))));
                    },
                  ),
                  EmotionCard(
                    custColor: Colors.pink.shade300,
                    emotionName: 'Hurt',
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: ((context) => GenericEmotionSurveyPage(
                                    choice0: "I don't want to feel like this",
                                    choice1: "I'm feeling burnout",
                                    choice2: "My partner left me",
                                    choice3:
                                        "My expectation didn't reach my goal",
                                  ))));
                    },
                  ),
                  EmotionCard(
                    custColor: Colors.red.shade800,
                    emotionName: 'Confused',
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: ((context) => GenericEmotionSurveyPage(
                                    choice0:
                                        "Why can't people just leave me alone",
                                    choice1: "Am I really what they say I am",
                                    choice2:
                                        "My body is changing it's confusing",
                                    choice3:
                                        "I feel disrespected by other people",
                                  ))));
                    },
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  EmotionCard(
                    custColor: Colors.blue.shade100,
                    emotionName: 'Sad',
                    onTap: () {},
                  ),
                  EmotionCard(
                    custColor: Colors.blue.shade300,
                    emotionName: 'Shy',
                    onTap: () {},
                  ),
                  EmotionCard(
                    custColor: Colors.blue.shade900,
                    emotionName: 'Worried',
                    onTap: () {},
                  ),
                ],
              ),
            ]),
          ],
        ),
      ),
    );
  }
}

class GenericEmotionSurveyPage extends StatefulWidget {
  final String choice0;
  final String choice1;
  final String choice2;
  final String choice3;

  const GenericEmotionSurveyPage({
    super.key,
    required this.choice0,
    required this.choice1,
    required this.choice2,
    required this.choice3,
  });
  @override
  State<GenericEmotionSurveyPage> createState() =>
      _GenericEmotionSurveyPageState(
          choice0: choice0,
          choice1: choice1,
          choice2: choice2,
          choice3: choice3);
}

class _GenericEmotionSurveyPageState extends State<GenericEmotionSurveyPage> {
  final String choice0;
  final String choice1;
  final String choice2;
  final String choice3;

  _GenericEmotionSurveyPageState({
    required this.choice0,
    required this.choice1,
    required this.choice2,
    required this.choice3,
  });

  int? choiceValue;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: <Color>[primaryLightBlue, primaryBlue]),
          ),
        ),
        toolbarHeight: 60,
        leading: SizedBox(
          width: 20,
          height: 20,
          child: Padding(
            padding: EdgeInsets.only(bottom: 3.0, left: 11.0),
            child: IconButton(
              icon: const Icon(
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
        title: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Text(
            'TALK TO US',
            style: TextStyle(
                fontFamily: 'Proza Libre',
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white),
          ),
        ),
      ),
      body: Container(
        child: ListView(
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 30.0, left: 15.0),
                  child: SizedBox(
                    width: MediaQuery.sizeOf(context).width,
                    child: Text(
                      'Tell us how you feel right now, {name}',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        color: primaryGrey,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Asap',
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
                Divider(
                  thickness: 2,
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(top: 10.0, left: 25, right: 10.0),
                  child: SizedBox(
                    width: MediaQuery.sizeOf(context).width,
                    child: Text(
                      "If you're struggling to open up to those around you. Please give on of the below to try",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        color: primaryGrey,
                        //fontWeight: FontWeight.bold,
                        fontFamily: 'Asap',
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                  child: ChoiceChip(
                    label: Container(
                      width: MediaQuery.sizeOf(context).width - 80,
                      //height: 40,
                      child: Text(
                        choice0,
                        softWrap: true,
                        maxLines: 2,
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                    ),
                    selected: choiceValue == 0,
                    onSelected: (bool selected) {
                      setState(() {
                        choiceValue = selected ? 0 : null;
                      });
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                  child: ChoiceChip(
                    label: Container(
                      width: MediaQuery.sizeOf(context).width - 80,
                      //height: 40,
                      child: Text(
                        choice1,
                        softWrap: true,
                        maxLines: 2,
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                    ),
                    selected: choiceValue == 1,
                    onSelected: (bool selected) {
                      setState(() {
                        choiceValue = selected ? 1 : null;
                      });
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                  child: ChoiceChip(
                    label: Container(
                      width: MediaQuery.sizeOf(context).width - 80,
                      //height: 40,
                      child: Text(
                        choice2,
                        softWrap: true,
                        maxLines: 2,
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                    ),
                    selected: choiceValue == 2,
                    onSelected: (bool selected) {
                      setState(() {
                        choiceValue = selected ? 2 : null;
                      });
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                  child: ChoiceChip(
                    label: Container(
                      width: MediaQuery.sizeOf(context).width - 80,
                      //height: 40,
                      child: Text(
                        choice3,
                        softWrap: true,
                        maxLines: 2,
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                    ),
                    selected: choiceValue == 3,
                    onSelected: (bool selected) {
                      setState(() {
                        choiceValue = selected ? 3 : null;
                      });
                    },
                  ),
                ),
                SizedBox(height: 50),
                Divider(
                  thickness: 2,
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(top: 20.0, left: 25.0, right: 25.0),
                  child: SizedBox(
                    width: MediaQuery.sizeOf(context).width,
                    child: Text(
                      'Would you like to tell us more about it Yoso?',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: mainLightGreen,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Asap',
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    FilledButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: ((context) => DiscoverMainPage())));
                      },
                      style: ButtonStyle(
                          minimumSize:
                              MaterialStateProperty.all<Size>(Size(150, 40)),
                          backgroundColor: MaterialStateProperty.all<Color>(
                              primaryLightBlue)),
                      child: Text('YES'),
                    ),
                    FilledButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: ((context) => CommunityIntroPage())));
                      },
                      style: ButtonStyle(
                          minimumSize:
                              MaterialStateProperty.all<Size>(Size(150, 40)),
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.grey)),
                      child: Text('No Thanks'),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class DiscoverIntroPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: ((context) => DashboardPage()),
        //   ),
        // );
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          child: Column(
            children: [
              SizedBox(height: 80),
              Image.asset(
                'images/therapy_logo.png',
                width: 300,
                fit: BoxFit.fitWidth,
                height: 400,
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Discover',
                    style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 40,
                        fontWeight: FontWeight.w800,
                        color: primaryPurple),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: MediaQuery.sizeOf(context).width,
                    child: Text(
                      "Discover articles, videos and infographics about mental health and mental wellbeing",
                      softWrap: true,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: 'Open Sans',
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 70),
              FilledButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => DiscoverMainPage())));
                },
                style: ButtonStyle(
                    minimumSize: MaterialStateProperty.all<Size>(Size(200, 50)),
                    backgroundColor:
                        MaterialStateProperty.all<Color>(mainBlue)),
                child: Text('GET STARTED'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DiscoverMainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: <Color>[primaryLightBlue, primaryBlue]),
          ),
        ),
        toolbarHeight: 60,
        leading: SizedBox(
          width: 20,
          height: 20,
          child: Padding(
            padding: EdgeInsets.only(bottom: 3.0, left: 11.0),
            child: IconButton(
              icon: const Icon(
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
        title: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Text(
            'DISCOVER',
            style: TextStyle(
                fontFamily: 'Proza Libre',
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white),
          ),
        ),
      ),
      body: Container(
        child: ListView(
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 30.0, left: 20.0),
                  child: SizedBox(
                    width: MediaQuery.sizeOf(context).width,
                    child: Text(
                      'Please select the topic that you like',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        color: primaryGrey,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Asap',
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
                Divider(),
                TopicCardWidget(
                  imageLoc: 'images/doc_logo.png',
                  title: 'Mental Health Issues',
                  desc:
                      "Learn about the different types of mental health issues facing the society today",
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => MentalHealthIssuesPage())),
                    );
                  },
                ),
                TopicCardWidget(
                  imageLoc: 'images/video_logo.png',
                  title: 'Understanding the self',
                  desc:
                      "Find and figure out who you really are and develop yourself",
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => UnderstandingSelfPage())),
                    );
                  },
                ),
                TopicCardWidget(
                  imageLoc: 'images/wheel_logo.png',
                  title: 'What is depression',
                  desc:
                      "Understand what causes and symptoms of depression and how to overcome it",
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => WhatIsDepressionPage())),
                    );
                  },
                ),
                TopicCardWidget(
                  imageLoc: 'images/video_logo.png',
                  title: 'Self Confidence',
                  desc:
                      "Build your self esteem so you can unlock your potential as a person",
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => SelfConfidencePage())),
                    );
                  },
                ),
                TopicCardWidget(
                  imageLoc: 'images/video_logo.png',
                  title: 'Breaking a bad Habit',
                  desc:
                      "Know where does a habit start and how you can stop your bad habits",
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => BreakingBadHabitPage())),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class TopicCardWidget extends StatelessWidget {
  final String imageLoc;
  final String title;
  final String desc;
  final VoidCallback onTap;

  const TopicCardWidget({
    super.key,
    required this.imageLoc,
    required this.title,
    required this.desc,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    double iconSize = 100;
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        onTap();
      },
      child: Card(
        elevation: 1,
        surfaceTintColor: unselectedGray,
        child: Row(
          children: [
            SizedBox(
              width: iconSize,
              height: iconSize,
              child: Image.asset(
                imageLoc,
              ),
            ),
            SizedBox(
              width: MediaQuery.sizeOf(context).width - iconSize - 20,
              child: Column(
                children: [
                  SizedBox(
                    width: MediaQuery.sizeOf(context).width - iconSize - 20,
                    child: Text(
                      title,
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontFamily: 'Open Sans',
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: primaryBlue,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.sizeOf(context).width - iconSize - 20,
                    child: Text(
                      desc,
                      //textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: Colors.black54,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class UnderstandingSelfPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        toolbarHeight: 60,
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
      body: Container(
        child: ListView(
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      top: 0.0, bottom: 0.0, left: 20, right: 10),
                  child: SizedBox(
                    width: MediaQuery.sizeOf(context).width,
                    child: Text(
                      "Discover",
                      style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: mainBlue),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 0.0, bottom: 10.0, left: 20, right: 10),
                  child: SizedBox(
                    width: MediaQuery.sizeOf(context).width,
                    child: Text(
                      "Videos that may help you",
                      style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: primaryGrey),
                    ),
                  ),
                ),
                Divider(
                  color: mainLightBlue,
                  thickness: 2,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 20.0, bottom: 10.0, left: 20, right: 10),
                  child: SizedBox(
                    width: MediaQuery.sizeOf(context).width,
                    child: Text(
                      "Understanding the Self",
                      style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 20.0, right: 10, bottom: 10),
                  child: SizedBox(
                    width: MediaQuery.sizeOf(context).width,
                    child: Text(
                      "A video essay on how one can help to understand yourself",
                      style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 15,
                          fontWeight: FontWeight.normal,
                          color: primaryGrey),
                    ),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.sizeOf(context).width,
                  child: YoutubeApp(videoId: '5lo3c5u73vw'),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 20.0, bottom: 10.0, left: 20, right: 10),
                  child: SizedBox(
                    width: MediaQuery.sizeOf(context).width,
                    child: Text(
                      "How to Know Yourself",
                      style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 20.0, right: 10, bottom: 10),
                  child: SizedBox(
                    width: MediaQuery.sizeOf(context).width,
                    child: Text(
                      "How do you really know oneself?",
                      style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 15,
                          fontWeight: FontWeight.normal,
                          color: primaryGrey),
                    ),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.sizeOf(context).width,
                  child: YoutubeApp(videoId: '4lTbWQ8zD3w'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class SelfConfidencePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        toolbarHeight: 60,
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
      body: Container(
        child: ListView(
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      top: 0.0, bottom: 0.0, left: 20, right: 10),
                  child: SizedBox(
                    width: MediaQuery.sizeOf(context).width,
                    child: Text(
                      "Discover",
                      style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: mainBlue),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 0.0, bottom: 10.0, left: 20, right: 10),
                  child: SizedBox(
                    width: MediaQuery.sizeOf(context).width,
                    child: Text(
                      "Videos that may help you",
                      style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: primaryGrey),
                    ),
                  ),
                ),
                Divider(
                  color: mainLightBlue,
                  thickness: 2,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 20.0, bottom: 10.0, left: 20, right: 10),
                  child: SizedBox(
                    width: MediaQuery.sizeOf(context).width,
                    child: Text(
                      "3 Tips to boost your confidence",
                      style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 20.0, right: 10, bottom: 10),
                  child: SizedBox(
                    width: MediaQuery.sizeOf(context).width,
                    child: Text(
                      "A video that will help you gain your confidence",
                      style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 15,
                          fontWeight: FontWeight.normal,
                          color: primaryGrey),
                    ),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.sizeOf(context).width,
                  child: YoutubeApp(videoId: 'l_NYrWqUR40'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class BreakingBadHabitPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        toolbarHeight: 60,
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
      body: Container(
        child: ListView(
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      top: 0.0, bottom: 0.0, left: 20, right: 10),
                  child: SizedBox(
                    width: MediaQuery.sizeOf(context).width,
                    child: Text(
                      "Discover",
                      style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: mainBlue),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 0.0, bottom: 10.0, left: 20, right: 10),
                  child: SizedBox(
                    width: MediaQuery.sizeOf(context).width,
                    child: Text(
                      "Videos that may help you",
                      style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: primaryGrey),
                    ),
                  ),
                ),
                Divider(
                  color: mainLightBlue,
                  thickness: 2,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 20.0, bottom: 10.0, left: 20, right: 10),
                  child: SizedBox(
                    width: MediaQuery.sizeOf(context).width,
                    child: Text(
                      "How To Change Your Bad Habits - The Easiest Way",
                      style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 20.0, right: 10, bottom: 10),
                  child: SizedBox(
                    width: MediaQuery.sizeOf(context).width,
                    child: Text(
                      "A short video providing ways to break your bad habits",
                      style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 15,
                          fontWeight: FontWeight.normal,
                          color: primaryGrey),
                    ),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.sizeOf(context).width,
                  child: YoutubeApp(videoId: 'y7HT2EgMvLo'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class MentalHealthIssuesPage extends StatelessWidget {
  final Uri articleUrl = Uri(
      scheme: 'https',
      path:
          "www.who.int/news-room/fact-sheets/detail/mental-disorders/?gclid=EAIaIQobChMInaW_lbzKgQMVxnQrCh0s6gKFEAAYASAAEgI_WPD_BwE");
  final articleUri = Uri.parse(
      "https://www.who.int/news-room/fact-sheets/detail/mental-disorders/?gclid=EAIaIQobChMInaW_lbzKgQMVxnQrCh0s6gKFEAAYASAAEgI_WPD_BwE");

  Future<void> _launchUrl() async {
    if (!await launchUrl(articleUri)) {
      throw Exception('Could not launch $articleUri');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        toolbarHeight: 60,
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
      body: Container(
        child: ListView(
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      top: 0.0, bottom: 0.0, left: 20, right: 10),
                  child: SizedBox(
                    width: MediaQuery.sizeOf(context).width,
                    child: Text(
                      "Discover",
                      style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: mainBlue),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 0.0, bottom: 10.0, left: 20, right: 10),
                  child: SizedBox(
                    width: MediaQuery.sizeOf(context).width,
                    child: Text(
                      "Articles that may help you",
                      style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: primaryGrey),
                    ),
                  ),
                ),
                Divider(
                  color: mainLightBlue,
                  thickness: 2,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 20.0, bottom: 10.0, left: 20, right: 10),
                  child: SizedBox(
                    width: MediaQuery.sizeOf(context).width,
                    child: Text(
                      "Mental Disorders",
                      style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 20.0, right: 10, bottom: 10),
                  child: SizedBox(
                    width: MediaQuery.sizeOf(context).width,
                    child: Text(
                      "This article discusses facts about different types of mental disorders. Click on the link below",
                      style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 15,
                          fontWeight: FontWeight.normal,
                          color: primaryGrey),
                    ),
                  ),
                ),
                // SizedBox(
                //   width: MediaQuery.sizeOf(context).width,
                //   child: YoutubeApp(videoId: 'y7HT2EgMvLo'),
                // ),
                //URLLauncherApp(uriString: articleUrl),
                // Link(
                //     uri: articleUri,
                //     target: LinkTarget.defaultTarget,
                //     builder: (context, openLink) => TextButton(
                //           onPressed: openLink,
                //           child: Text(articleUri.toString()),
                //         )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class WhatIsDepressionPage extends StatelessWidget {
  final Uri articleUrl = Uri(
      scheme: 'https',
      path:
          "workplacementalhealth.org/employer-resources/infographics/infographic-depression");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        toolbarHeight: 60,
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
      body: Container(
        child: ListView(
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      top: 0.0, bottom: 0.0, left: 20, right: 10),
                  child: SizedBox(
                    width: MediaQuery.sizeOf(context).width,
                    child: Text(
                      "Discover",
                      style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: mainBlue),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 0.0, bottom: 10.0, left: 20, right: 10),
                  child: SizedBox(
                    width: MediaQuery.sizeOf(context).width,
                    child: Text(
                      "Articles that may help you",
                      style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: primaryGrey),
                    ),
                  ),
                ),
                Divider(
                  color: mainLightBlue,
                  thickness: 2,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 20.0, bottom: 10.0, left: 20, right: 10),
                  child: SizedBox(
                    width: MediaQuery.sizeOf(context).width,
                    child: Text(
                      "Depression is more common than you think",
                      style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 20.0, right: 10, bottom: 10),
                  child: SizedBox(
                    width: MediaQuery.sizeOf(context).width,
                    child: Text(
                      "A detailed infographic about depression",
                      style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 15,
                          fontWeight: FontWeight.normal,
                          color: primaryGrey),
                    ),
                  ),
                ),
                // SizedBox(
                //   width: MediaQuery.sizeOf(context).width,
                //   child: YoutubeApp(videoId: 'y7HT2EgMvLo'),
                // ),
                //URLLauncherApp(uriString: articleUrl),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
