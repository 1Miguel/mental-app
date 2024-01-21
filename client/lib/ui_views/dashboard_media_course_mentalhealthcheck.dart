import 'package:flutter/material.dart';
import 'package:flutter_intro/ui_views/dashboard_views.dart';
import 'package:flutter_intro/utils/colors_scheme.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

enum SurveyPoints { no, yes, sometimes }

class CourseMentalHealthCheckSurvey extends StatefulWidget {
  const CourseMentalHealthCheckSurvey({super.key});

  @override
  State<CourseMentalHealthCheckSurvey> createState() =>
      _CourseMentalHealthCheckSurveyState();
}

class _CourseMentalHealthCheckSurveyState
    extends State<CourseMentalHealthCheckSurvey> {
  final _formKey = GlobalKey<FormState>();
  int totalPoints = 0;
  SurveyPoints? _q1;
  SurveyPoints? _q2;
  SurveyPoints? _q3;
  SurveyPoints? _q4;
  SurveyPoints? _q5;

  void printAnswers() {
    print("Q1: $_q1");
    print("Q2: $_q2");
    print("Q3: $_q3");
    print("Q4: $_q4");
    print("Q5: $_q5");
  }

  bool validateForm() {
    if (_q1 == null) {
      return false;
    }
    if (_q2 == null) {
      return false;
    }
    if (_q3 == null) {
      return false;
    }
    if (_q4 == null) {
      return false;
    }
    if (_q5 == null) {
      return false;
    }

    return true;
  }

  int getValue(SurveyPoints? value) {
    if (value == SurveyPoints.no) {
      return 0;
    } else if (value == SurveyPoints.yes) {
      return 1;
    }
    return 2;
  }

  void calculateForm() {
    int subTotal = 0;

    subTotal += getValue(_q1);
    subTotal += getValue(_q2);
    subTotal += getValue(_q3);
    subTotal += getValue(_q4);
    subTotal += getValue(_q5);

    setState(() {
      totalPoints = subTotal;
      printAnswers();
      print("Total Points: $totalPoints");
    });
  }

  _showErrorDialog(context, errorMessage) {
    Alert(
      context: context,
      //style: alertStyle,
      type: AlertType.error,
      title: "Error",
      desc: errorMessage,
      buttons: [
        DialogButton(
          child: Text(
            "OK",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => {
            Navigator.of(context, rootNavigator: true).pop(),
          },
          color: Colors.redAccent,
          radius: BorderRadius.circular(0.0),
        ),
      ],
    ).show();
  }

  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraint) {
      const double appBarHeight = 80;
      double bodyHeight = constraint.maxHeight - appBarHeight;
      return PopScope(
        canPop: true,
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
            title: Text("Mental Health Check",
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.w900)),
            centerTitle: true,
          ),
          body: Form(
            key: _formKey,
            child: Container(
              width: constraint.maxWidth,
              height: constraint.maxHeight,
              child: ListView(
                children: [
                  Container(
                    width: constraint.maxWidth - 40,
                    height: (constraint.maxHeight / 6) / 2,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: SizedBox(
                            height: (constraint.maxHeight / 6) / 2,
                            width: constraint.maxWidth - 40,
                            child: Text(
                                'This month, how often have you been bothered by any of the following problems?',
                                softWrap: true,
                                maxLines: 2,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.lightGreen, fontSize: 18)),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: constraint.maxWidth,
                    height: (constraint.maxHeight / 7),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 20.0),
                              child: SizedBox(
                                width: constraint.maxWidth - 80,
                                child: Text(
                                    'Little interest or pleasure in doing things',
                                    softWrap: true,
                                    maxLines: 2,
                                    style: TextStyle(
                                        color: Colors.black54,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold)),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 30,
                              child: Text('No'),
                            ),
                            SizedBox(
                              width: 50,
                              child: Radio<SurveyPoints>(
                                value: SurveyPoints.no,
                                groupValue: _q1,
                                onChanged: (SurveyPoints? value) {
                                  setState(() {
                                    _q1 = value;
                                    printAnswers();
                                  });
                                },
                              ),
                            ),
                            SizedBox(
                              width: 30,
                              child: Text('Yes'),
                            ),
                            SizedBox(
                              width: 50,
                              child: Radio<SurveyPoints>(
                                value: SurveyPoints.yes,
                                groupValue: _q1,
                                onChanged: (SurveyPoints? value) {
                                  setState(() {
                                    _q1 = value;
                                    printAnswers();
                                  });
                                },
                              ),
                            ),
                            SizedBox(
                              width: 80,
                              child: Text('Sometimes'),
                            ),
                            SizedBox(
                              width: 50,
                              child: Radio<SurveyPoints>(
                                value: SurveyPoints.sometimes,
                                groupValue: _q1,
                                onChanged: (SurveyPoints? value) {
                                  setState(() {
                                    _q1 = value;
                                    printAnswers();
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: constraint.maxWidth,
                    height: (constraint.maxHeight / 7),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 20.0),
                              child: SizedBox(
                                width: constraint.maxWidth - 80,
                                child: Text(
                                    'Feeling down, depressed or hopeless',
                                    softWrap: true,
                                    maxLines: 2,
                                    style: TextStyle(
                                        color: Colors.black54,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold)),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 30,
                              child: Text('No'),
                            ),
                            SizedBox(
                              width: 50,
                              child: Radio<SurveyPoints>(
                                value: SurveyPoints.no,
                                groupValue: _q2,
                                onChanged: (SurveyPoints? value) {
                                  setState(() {
                                    _q2 = value;
                                    printAnswers();
                                  });
                                },
                              ),
                            ),
                            SizedBox(
                              width: 30,
                              child: Text('Yes'),
                            ),
                            SizedBox(
                              width: 50,
                              child: Radio<SurveyPoints>(
                                value: SurveyPoints.yes,
                                groupValue: _q2,
                                onChanged: (SurveyPoints? value) {
                                  setState(() {
                                    _q2 = value;
                                    printAnswers();
                                  });
                                },
                              ),
                            ),
                            SizedBox(
                              width: 80,
                              child: Text('Sometimes'),
                            ),
                            SizedBox(
                              width: 50,
                              child: Radio<SurveyPoints>(
                                value: SurveyPoints.sometimes,
                                groupValue: _q2,
                                onChanged: (SurveyPoints? value) {
                                  setState(() {
                                    _q2 = value;
                                    printAnswers();
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: constraint.maxWidth,
                    height: (constraint.maxHeight / 7),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 20.0),
                              child: SizedBox(
                                width: constraint.maxWidth - 80,
                                child: Text(
                                    'Trouble falling or staying asleep, or sleeping too much',
                                    softWrap: true,
                                    maxLines: 2,
                                    style: TextStyle(
                                        color: Colors.black54,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold)),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 30,
                              child: Text('No'),
                            ),
                            SizedBox(
                              width: 50,
                              child: Radio<SurveyPoints>(
                                value: SurveyPoints.no,
                                groupValue: _q3,
                                onChanged: (SurveyPoints? value) {
                                  setState(() {
                                    _q3 = value;
                                    printAnswers();
                                  });
                                },
                              ),
                            ),
                            SizedBox(
                              width: 30,
                              child: Text('Yes'),
                            ),
                            SizedBox(
                              width: 50,
                              child: Radio<SurveyPoints>(
                                value: SurveyPoints.yes,
                                groupValue: _q3,
                                onChanged: (SurveyPoints? value) {
                                  setState(() {
                                    _q3 = value;
                                    printAnswers();
                                  });
                                },
                              ),
                            ),
                            SizedBox(
                              width: 80,
                              child: Text('Sometimes'),
                            ),
                            SizedBox(
                              width: 50,
                              child: Radio<SurveyPoints>(
                                value: SurveyPoints.sometimes,
                                groupValue: _q3,
                                onChanged: (SurveyPoints? value) {
                                  setState(() {
                                    _q3 = value;
                                    printAnswers();
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: constraint.maxWidth,
                    height: (constraint.maxHeight / 8),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 20.0),
                              child: SizedBox(
                                width: constraint.maxWidth - 80,
                                child: Text(
                                    'Feeling tired or having little energy',
                                    softWrap: true,
                                    maxLines: 2,
                                    style: TextStyle(
                                        color: Colors.black54,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold)),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 30,
                              child: Text('No'),
                            ),
                            SizedBox(
                              width: 50,
                              child: Radio<SurveyPoints>(
                                value: SurveyPoints.no,
                                groupValue: _q4,
                                onChanged: (SurveyPoints? value) {
                                  setState(() {
                                    _q4 = value;
                                    printAnswers();
                                  });
                                },
                              ),
                            ),
                            SizedBox(
                              width: 30,
                              child: Text('Yes'),
                            ),
                            SizedBox(
                              width: 50,
                              child: Radio<SurveyPoints>(
                                value: SurveyPoints.yes,
                                groupValue: _q4,
                                onChanged: (SurveyPoints? value) {
                                  setState(() {
                                    _q4 = value;
                                    printAnswers();
                                  });
                                },
                              ),
                            ),
                            SizedBox(
                              width: 80,
                              child: Text('Sometimes'),
                            ),
                            SizedBox(
                              width: 50,
                              child: Radio<SurveyPoints>(
                                value: SurveyPoints.sometimes,
                                groupValue: _q4,
                                onChanged: (SurveyPoints? value) {
                                  setState(() {
                                    _q4 = value;
                                    printAnswers();
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: constraint.maxWidth,
                    height: (constraint.maxHeight / 8),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 20.0),
                              child: SizedBox(
                                width: constraint.maxWidth - 80,
                                child: Text('Poor appetite or overeating',
                                    softWrap: true,
                                    maxLines: 2,
                                    style: TextStyle(
                                        color: Colors.black54,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold)),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 30,
                              child: Text('No'),
                            ),
                            SizedBox(
                              width: 50,
                              child: Radio<SurveyPoints>(
                                value: SurveyPoints.no,
                                groupValue: _q5,
                                onChanged: (SurveyPoints? value) {
                                  setState(() {
                                    _q5 = value;
                                    printAnswers();
                                  });
                                },
                              ),
                            ),
                            SizedBox(
                              width: 30,
                              child: Text('Yes'),
                            ),
                            SizedBox(
                              width: 50,
                              child: Radio<SurveyPoints>(
                                value: SurveyPoints.yes,
                                groupValue: _q5,
                                onChanged: (SurveyPoints? value) {
                                  setState(() {
                                    _q5 = value;
                                    printAnswers();
                                  });
                                },
                              ),
                            ),
                            SizedBox(
                              width: 80,
                              child: Text('Sometimes'),
                            ),
                            SizedBox(
                              width: 50,
                              child: Radio<SurveyPoints>(
                                value: SurveyPoints.sometimes,
                                groupValue: _q5,
                                onChanged: (SurveyPoints? value) {
                                  setState(() {
                                    _q5 = value;
                                    printAnswers();
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: constraint.maxWidth,
                    height: (constraint.maxHeight / 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 20.0),
                          child: FilledButton(
                            onPressed: () {
                              if (validateForm() == false) {
                                _showErrorDialog(context,
                                    "Kindly answer all the survey questions to proceed");
                              } else {
                                calculateForm();
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: ((context) => MoodSurvey2Page(
                                            subTotal: totalPoints))));
                              }
                            },
                            style: ButtonStyle(
                              minimumSize: MaterialStateProperty.all<Size>(
                                  Size(120, 40)),
                              backgroundColor:
                                  MaterialStateProperty.all<Color>(Colors.teal),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                  side: BorderSide(
                                      width: 2.0, color: loginDarkTeal),
                                ),
                              ),
                            ),
                            child: Text(
                              'NEXT',
                              style: TextStyle(
                                  fontFamily: 'Open Sans',
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}

class MoodSurvey2Page extends StatefulWidget {
  final int subTotal;
  const MoodSurvey2Page({super.key, required this.subTotal});
  @override
  _MoodSurveyState2 createState() {
    return _MoodSurveyState2(subTotal: subTotal);
  }
}

class _MoodSurveyState2 extends State<MoodSurvey2Page> {
  final int subTotal;
  final _formKey = GlobalKey<FormState>();
  int totalPoints = 0;
  SurveyPoints? _q1;
  SurveyPoints? _q2;
  SurveyPoints? _q3;
  SurveyPoints? _q4;

  _MoodSurveyState2({required this.subTotal});

  void printAnswers() {
    print("Q1: $_q1");
    print("Q2: $_q2");
    print("Q3: $_q3");
    print("Q4: $_q4");
  }

  bool validateForm() {
    if (_q1 == null) {
      return false;
    }
    if (_q2 == null) {
      return false;
    }
    if (_q3 == null) {
      return false;
    }
    if (_q4 == null) {
      return false;
    }

    return true;
  }

  int getValue(SurveyPoints? value) {
    if (value == SurveyPoints.no) {
      return 0;
    } else if (value == SurveyPoints.yes) {
      return 1;
    }
    return 2;
  }

  void calculateForm() {
    int formTotal = 0;

    formTotal += getValue(_q1);
    formTotal += getValue(_q2);
    formTotal += getValue(_q3);
    formTotal += getValue(_q4);

    setState(() {
      totalPoints = subTotal + formTotal;
      printAnswers();
      print("Total Points: $totalPoints");
    });
  }

  _showErrorDialog(context, errorMessage) {
    Alert(
      context: context,
      //style: alertStyle,
      type: AlertType.error,
      title: "Error",
      desc: errorMessage,
      buttons: [
        DialogButton(
          child: Text(
            "OK",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => {
            Navigator.of(context, rootNavigator: true).pop(),
          },
          color: Colors.redAccent,
          radius: BorderRadius.circular(0.0),
        ),
      ],
    ).show();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraint) {
      const double appBarHeight = 80;
      double bodyHeight = constraint.maxHeight - appBarHeight;
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
            title: Text("Mental Health Check",
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.w900)),
            centerTitle: true,
          ),
          body: Form(
            key: _formKey,
            child: Container(
              width: constraint.maxWidth,
              height: constraint.maxHeight,
              child: ListView(
                children: [
                  Container(
                    width: constraint.maxWidth,
                    height: (constraint.maxHeight / 6),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 20.0),
                              child: SizedBox(
                                width: constraint.maxWidth - 80,
                                child: Text(
                                    'Feeling bad about yourself, or that you are a failure or have let yourself or your family down',
                                    softWrap: true,
                                    maxLines: 3,
                                    style: TextStyle(
                                        color: Colors.black54,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold)),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 30,
                              child: Text('No'),
                            ),
                            SizedBox(
                              width: 50,
                              child: Radio<SurveyPoints>(
                                value: SurveyPoints.no,
                                groupValue: _q1,
                                onChanged: (SurveyPoints? value) {
                                  setState(() {
                                    _q1 = value;
                                    printAnswers();
                                  });
                                },
                              ),
                            ),
                            SizedBox(
                              width: 30,
                              child: Text('Yes'),
                            ),
                            SizedBox(
                              width: 50,
                              child: Radio<SurveyPoints>(
                                value: SurveyPoints.yes,
                                groupValue: _q1,
                                onChanged: (SurveyPoints? value) {
                                  setState(() {
                                    _q1 = value;
                                    printAnswers();
                                  });
                                },
                              ),
                            ),
                            SizedBox(
                              width: 80,
                              child: Text('Sometimes'),
                            ),
                            SizedBox(
                              width: 50,
                              child: Radio<SurveyPoints>(
                                value: SurveyPoints.sometimes,
                                groupValue: _q1,
                                onChanged: (SurveyPoints? value) {
                                  setState(() {
                                    _q1 = value;
                                    printAnswers();
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: constraint.maxWidth,
                    height: (constraint.maxHeight / 6),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 20.0),
                              child: SizedBox(
                                width: constraint.maxWidth - 80,
                                child: Text(
                                    'Trouble concentrating on things, such as reading the newspaper or watching television',
                                    softWrap: true,
                                    maxLines: 3,
                                    style: TextStyle(
                                        color: Colors.black54,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold)),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 30,
                              child: Text('No'),
                            ),
                            SizedBox(
                              width: 50,
                              child: Radio<SurveyPoints>(
                                value: SurveyPoints.no,
                                groupValue: _q2,
                                onChanged: (SurveyPoints? value) {
                                  setState(() {
                                    _q2 = value;
                                    printAnswers();
                                  });
                                },
                              ),
                            ),
                            SizedBox(
                              width: 30,
                              child: Text('Yes'),
                            ),
                            SizedBox(
                              width: 50,
                              child: Radio<SurveyPoints>(
                                value: SurveyPoints.yes,
                                groupValue: _q2,
                                onChanged: (SurveyPoints? value) {
                                  setState(() {
                                    _q2 = value;
                                    printAnswers();
                                  });
                                },
                              ),
                            ),
                            SizedBox(
                              width: 80,
                              child: Text('Sometimes'),
                            ),
                            SizedBox(
                              width: 50,
                              child: Radio<SurveyPoints>(
                                value: SurveyPoints.sometimes,
                                groupValue: _q2,
                                onChanged: (SurveyPoints? value) {
                                  setState(() {
                                    _q2 = value;
                                    printAnswers();
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: constraint.maxWidth,
                    height: (constraint.maxHeight / 5),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 20.0),
                              child: SizedBox(
                                width: constraint.maxWidth - 80,
                                child: Text(
                                    'Moving or speaking so slowly that other people could have noticed? Or the opposite being so fidgety or restless that you have been moving around a lot more than usual',
                                    softWrap: true,
                                    maxLines: 4,
                                    style: TextStyle(
                                        color: Colors.black54,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold)),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 30,
                              child: Text('No'),
                            ),
                            SizedBox(
                              width: 50,
                              child: Radio<SurveyPoints>(
                                value: SurveyPoints.no,
                                groupValue: _q3,
                                onChanged: (SurveyPoints? value) {
                                  setState(() {
                                    _q3 = value;
                                    printAnswers();
                                  });
                                },
                              ),
                            ),
                            SizedBox(
                              width: 30,
                              child: Text('Yes'),
                            ),
                            SizedBox(
                              width: 50,
                              child: Radio<SurveyPoints>(
                                value: SurveyPoints.yes,
                                groupValue: _q3,
                                onChanged: (SurveyPoints? value) {
                                  setState(() {
                                    _q3 = value;
                                    printAnswers();
                                  });
                                },
                              ),
                            ),
                            SizedBox(
                              width: 80,
                              child: Text('Sometimes'),
                            ),
                            SizedBox(
                              width: 50,
                              child: Radio<SurveyPoints>(
                                value: SurveyPoints.sometimes,
                                groupValue: _q3,
                                onChanged: (SurveyPoints? value) {
                                  setState(() {
                                    _q3 = value;
                                    printAnswers();
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: constraint.maxWidth,
                    height: (constraint.maxHeight / 6),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 20.0),
                              child: SizedBox(
                                width: constraint.maxWidth - 80,
                                child: Text(
                                    'Thoughts that you would be better off dead or hurting yourself in some way',
                                    softWrap: true,
                                    maxLines: 3,
                                    style: TextStyle(
                                        color: Colors.black54,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold)),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 30,
                              child: Text('No'),
                            ),
                            SizedBox(
                              width: 50,
                              child: Radio<SurveyPoints>(
                                value: SurveyPoints.no,
                                groupValue: _q4,
                                onChanged: (SurveyPoints? value) {
                                  setState(() {
                                    _q4 = value;
                                    printAnswers();
                                  });
                                },
                              ),
                            ),
                            SizedBox(
                              width: 30,
                              child: Text('Yes'),
                            ),
                            SizedBox(
                              width: 50,
                              child: Radio<SurveyPoints>(
                                value: SurveyPoints.yes,
                                groupValue: _q4,
                                onChanged: (SurveyPoints? value) {
                                  setState(() {
                                    _q4 = value;
                                    printAnswers();
                                  });
                                },
                              ),
                            ),
                            SizedBox(
                              width: 80,
                              child: Text('Sometimes'),
                            ),
                            SizedBox(
                              width: 50,
                              child: Radio<SurveyPoints>(
                                value: SurveyPoints.sometimes,
                                groupValue: _q4,
                                onChanged: (SurveyPoints? value) {
                                  setState(() {
                                    _q4 = value;
                                    printAnswers();
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: constraint.maxWidth,
                    height: (constraint.maxHeight / 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 20.0),
                          child: FilledButton(
                            onPressed: () {
                              if (validateForm() == false) {
                                _showErrorDialog(context,
                                    "Kindly answer all the survey questions to proceed");
                              } else {
                                calculateForm();
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: ((context) =>
                                            MoodSurveyResultsPage(
                                                totalPoints: totalPoints))));
                              }
                            },
                            style: ButtonStyle(
                              minimumSize: MaterialStateProperty.all<Size>(
                                  Size(120, 40)),
                              backgroundColor:
                                  MaterialStateProperty.all<Color>(Colors.teal),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                  side: BorderSide(
                                      width: 2.0, color: loginDarkTeal),
                                ),
                              ),
                            ),
                            child: Text(
                              'DONE',
                              style: TextStyle(
                                  fontFamily: 'Open Sans',
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}

class MoodSurveyResultsPage extends StatelessWidget {
  final int totalPoints;

  const MoodSurveyResultsPage({super.key, required this.totalPoints});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraint) {
      const double appBarHeight = 80;
      double bodyHeight = constraint.maxHeight - appBarHeight;
      return PopScope(
        canPop: false,
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: ((context) => MoodSurveyOutroPage())));
          },
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
              title: Text("Mood Assessment",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w900)),
              centerTitle: true,
            ),
            body: Container(
              width: constraint.maxWidth,
              height: bodyHeight,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0, top: 30.0),
                    child: SizedBox(
                        width: constraint.maxWidth - 20,
                        child: Text(
                          'POINTS\nno- 0\nyes- 1\nsometimes- 2',
                          softWrap: true,
                          maxLines: 4,
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0, top: 20.0),
                    child: SizedBox(
                        width: constraint.maxWidth - 20,
                        child: Text(
                          'Your Total Points: $totalPoints',
                          style: TextStyle(
                              color: Colors.lightGreen,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 20.0, top: 20.0, right: 20.0),
                    child: SizedBox(
                        width: constraint.maxWidth - 20,
                        child: Text(
                          '0-5 mild',
                          style: TextStyle(color: Colors.black54, fontSize: 16),
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 20.0, top: 20.0, right: 20.0),
                    child: SizedBox(
                      width: constraint.maxWidth - 20,
                      child: Text(
                        '6-10 moderate.',
                        softWrap: true,
                        maxLines: 4,
                        style: TextStyle(color: Colors.black54, fontSize: 16),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 20.0, top: 20.0, right: 20.0),
                    child: SizedBox(
                      width: constraint.maxWidth - 20,
                      child: Text(
                        '11-15 moderately severe.',
                        softWrap: true,
                        maxLines: 8,
                        style: TextStyle(color: Colors.black54, fontSize: 16),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 20.0, top: 20.0, right: 20.0),
                    child: SizedBox(
                      width: constraint.maxWidth - 20,
                      child: Text(
                        '16-20 severe depression',
                        softWrap: true,
                        maxLines: 3,
                        style: TextStyle(color: Colors.black54, fontSize: 16),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}

class MoodSurveyOutroPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraint) {
      const double appBarHeight = 80;
      double bodyHeight = constraint.maxHeight - appBarHeight;
      return PopScope(
        canPop: false,
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: ((context) => DashboardPage())));
          },
          child: Scaffold(
            body: ListView(
              children: [
                SizedBox(height: 100),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                        padding: const EdgeInsets.only(bottom: 15.0),
                        child: Text('Thank You!',
                            style: TextStyle(
                                color: Colors.teal,
                                fontSize: 40,
                                fontWeight: FontWeight.w900)))
                  ],
                ),
                Image.asset(
                  'images/welcome_logo.png',
                  fit: BoxFit.fitHeight,
                  height: 400,
                ),
                SizedBox(height: 80),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                        padding: const EdgeInsets.only(bottom: 15.0),
                        child: Text('We hope you\n have a great day!',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.teal,
                              fontSize: 30,
                              fontWeight: FontWeight.w700,
                            )))
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
