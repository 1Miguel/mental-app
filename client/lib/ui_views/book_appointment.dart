import 'package:flutter/material.dart';
import 'package:flutter_intro/utils/colors_scheme.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:intl/intl.dart';
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
    double newSize = 30;
    if (title.length > 40) {
      newSize = 18;
    } else if (newSize > 20 && newSize <= 40) {
      newSize = 25;
    }
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

class MainHeadingText extends StatelessWidget {
  final String title;
  final bool isOverflow;
  final bool isHeavy;
  final Color customColor;

  const MainHeadingText({
    super.key,
    required this.title,
    required this.isOverflow,
    required this.isHeavy,
    required this.customColor,
  });

  @override
  Widget build(BuildContext context) {
    double newSize = isOverflow ? 20 : 40;
    //Overwrite size based on length
    newSize = (title.length > 20) ? 25 : 30;
    FontWeight newWeight = isHeavy ? FontWeight.w900 : FontWeight.bold;
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

class SubHeadingText extends StatelessWidget {
  final String title;
  final bool isOverflow;
  final bool isHeavy;
  final Color customColor;

  const SubHeadingText({
    super.key,
    required this.title,
    required this.isOverflow,
    required this.isHeavy,
    required this.customColor,
  });

  @override
  Widget build(BuildContext context) {
    double newSize = isOverflow ? 10 : 20;
    //Overwrite size based on length
    newSize = (title.length > 20) ? 12 : 20;
    FontWeight newWeight = isHeavy ? FontWeight.w900 : FontWeight.bold;
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

class HeaderContentText extends StatelessWidget {
  final String title;
  final bool isOverflow;
  final bool isHeavy;
  final Color customColor;

  const HeaderContentText({
    super.key,
    required this.title,
    required this.isOverflow,
    required this.isHeavy,
    required this.customColor,
  });

  @override
  Widget build(BuildContext context) {
    double newSize = isOverflow ? 18 : 22;
    FontWeight newWeight = isHeavy ? FontWeight.w900 : FontWeight.bold;
    return Text(
      title,
      textAlign: TextAlign.center,
      softWrap: true,
      maxLines: 5,
      style: TextStyle(
        color: customColor,
        fontFamily: 'Open Sans',
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
      isEnabled: true,
      selectedColor: primaryBlue,
      onSelected: (bool selected) {},
    );
  }
}

class BookIconBox extends StatelessWidget {
  final String title;

  const BookIconBox({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 170,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          title,
          textAlign: TextAlign.center,
          softWrap: true,
          maxLines: 2,
          style: TextStyle(
            color: primaryBlue,
            fontWeight: FontWeight.bold,
            fontFamily: 'Roboto',
            fontSize: 20,
          ),
        ),
      ),
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
                      color: mainDarkBlue),
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'We will continue to enhance\nindividual and collective well-being\nfor a mentally healthy Philippines!',
                  softWrap: true,
                  maxLines: 3,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: 'Open Sans',
                      fontSize: 18,
                      color: mainLightPurple),
                ),
              ],
            ),
            SizedBox(height: 50),
            FilledButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: ((context) => BookAppointmentPage())));
              },
              style: ButtonStyle(
                  minimumSize: MaterialStateProperty.all<Size>(Size(200, 50)),
                  backgroundColor: MaterialStateProperty.all<Color>(mainBlue)),
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
    contact_number: "",
  );

  getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString('user_data') ?? jsonEncode(emptyUser).toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                fontFamily: 'ProzaLibre',
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white),
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 30.0, top: 30.0),
            child: Text(
              "Please select the service you want",
              textAlign: TextAlign.left,
              style: TextStyle(
                color: primaryGrey,
                fontSize: 20,
                fontFamily: 'Asap',
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
          SizedBox(
            height: 50,
          ),
          ServiceIcons(),
        ],
      ),
    );
  }
}

class ServiceIcons extends StatefulWidget {
  const ServiceIcons({super.key});

  @override
  State<ServiceIcons> createState() => _ServiceIconsState();
}

class _ServiceIconsState extends State<ServiceIcons> {
  bool mainButtonSelected = false;
  bool psychSelected = false;
  bool occTherapySelected = false;
  bool counselingSelected = false;
  bool assesmentSelected = false;

  resetStates() {
    if (psychSelected) {
      setState(() {
        psychSelected = false;
      });
    } else if (occTherapySelected) {
      setState(() {
        occTherapySelected = false;
      });
    } else if (counselingSelected) {
      setState(() {
        counselingSelected = false;
      });
    } else if (assesmentSelected) {
      setState(() {
        assesmentSelected = false;
      });
    }
  }

  setStateValue(ConsulationServices service, bool typeState, bool memberState) {
    if (service == ConsulationServices.consultation) {
      setState(() {
        psychSelected = typeState;
        mainButtonSelected = memberState;
      });
    } else if (service == ConsulationServices.therapy) {
      setState(() {
        occTherapySelected = typeState;
        mainButtonSelected = memberState;
      });
    } else if (service == ConsulationServices.counseling) {
      setState(() {
        counselingSelected = typeState;
        mainButtonSelected = memberState;
      });
    } else if (service == ConsulationServices.assessment) {
      setState(() {
        assesmentSelected = typeState;
        mainButtonSelected = memberState;
      });
    }
  }

  setServiceState(ConsulationServices service, bool selectedValue) {
    print(service);
    printStates();

    if (selectedValue == true && mainButtonSelected == true) {
      setStateValue(service, false, false);
    } else if (selectedValue == false && mainButtonSelected == false) {
      setStateValue(service, true, true);
    } else if (selectedValue == false && mainButtonSelected == true) {
      resetStates();
      setStateValue(service, true, true);
    }
  }

  printStates() {
    print('Psychselected $psychSelected');
    print('occTherapySelected: $occTherapySelected');
    print('counselingSelected: $counselingSelected');
    print('assesmentSelected: $assesmentSelected');
    print('mainButtonSelected: $mainButtonSelected');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 30.0),
            child: Row(
              children: [
                SizedBox(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 70,
                          backgroundColor:
                              psychSelected ? mainBlue : unselectedGray,
                          child: IconButton(
                            icon: Icon(
                              Icons.supervisor_account,
                              size: 70,
                              color:
                                  psychSelected ? Colors.white : Colors.black54,
                            ),
                            onPressed: () {
                              print('PsychSelected');
                              printStates();
                              setServiceState(ConsulationServices.consultation,
                                  psychSelected);
                            },
                          ),
                        ),
                        BookIconBox(title: "Psychiatric Consultation"),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 70,
                        backgroundColor:
                            occTherapySelected ? mainBlue : unselectedGray,
                        child: IconButton(
                          icon: Icon(
                            Icons.diversity_1,
                            size: 70,
                            color: occTherapySelected
                                ? Colors.white
                                : Colors.black54,
                          ),
                          onPressed: () {
                            print('OccTherapySelected');
                            printStates();
                            setServiceState(ConsulationServices.therapy,
                                occTherapySelected);
                          },
                        ),
                      ),
                      BookIconBox(title: "Occupational Therapy"),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30.0),
            child: Row(
              children: [
                SizedBox(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 70,
                          backgroundColor:
                              counselingSelected ? mainBlue : unselectedGray,
                          child: IconButton(
                            icon: Icon(
                              Icons.handshake,
                              size: 70,
                              color: counselingSelected
                                  ? Colors.white
                                  : Colors.black54,
                            ),
                            onPressed: () {
                              print('counselingSelected');
                              printStates();
                              setServiceState(ConsulationServices.counseling,
                                  counselingSelected);
                            },
                          ),
                        ),
                        BookIconBox(title: "Counseling\n"),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 70,
                        backgroundColor:
                            assesmentSelected ? mainBlue : unselectedGray,
                        child: IconButton(
                          icon: Icon(
                            Icons.psychology,
                            size: 70,
                            color: assesmentSelected
                                ? Colors.white
                                : Colors.black54,
                          ),
                          onPressed: () {
                            print('assesmentSelected');
                            printStates();
                            setServiceState(ConsulationServices.assessment,
                                assesmentSelected);
                          },
                        ),
                      ),
                      BookIconBox(title: "Psychological Assessment"),
                    ],
                  ),
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
                  onPressed: () {
                    if (mainButtonSelected == false) {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return SimpleDialog(
                              title: Text('Service unselected'),
                              contentPadding: EdgeInsets.all(20),
                              children: [
                                Text('Kindly select a service to proceed.')
                              ],
                            );
                          });
                    } else if (psychSelected) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: ((context) => GenericConsultationPage(
                                    service: ConsulationServices.consultation,
                                  ))));
                    } else if (occTherapySelected) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: ((context) => GenericConsultationPage(
                                    service: ConsulationServices.therapy,
                                  ))));
                    } else if (counselingSelected) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: ((context) => GenericConsultationPage(
                                    service: ConsulationServices.counseling,
                                  ))));
                    } else if (assesmentSelected) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: ((context) => GenericConsultationPage(
                                    service: ConsulationServices.assessment,
                                  ))));
                    }
                  },
                  style: ButtonStyle(
                      minimumSize:
                          MaterialStateProperty.all<Size>(Size(200, 50)),
                      backgroundColor:
                          MaterialStateProperty.all<Color>(mainBlue)),
                  child: Text('SELECT'),
                ),
              ],
            ),
          ),
        ],
      ),
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
                                isHeavy: false,
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
          ButtonBookIcon(),
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

class ButtonBookIcon extends StatefulWidget {
  const ButtonBookIcon({super.key});

  @override
  State<ButtonBookIcon> createState() => _ButtonBookIconState();
}

class _ButtonBookIconState extends State<ButtonBookIcon> {
  bool isSelected = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isSelected = !isSelected;
        });
      },
      child: Container(
        height: 140,
        width: 140,
        margin: EdgeInsets.all(8),
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            border: Border.all(
                width: 14, color: isSelected ? Colors.blue : Colors.grey)),
        child: SizedBox(
          height: 120,
          width: 120,
          child: Image.asset(
            'images/membership_logo.png',
          ),
        ),
      ),
    );
  }
}

// occupational therapy: Icons.diversity_1,

class BookIconSimple extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 30,
      backgroundColor: Colors.greenAccent, //<-- SEE HERE
      child: IconButton(
        icon: Icon(
          Icons.supervisor_account,
          color: Colors.black,
        ),
        onPressed: () {},
      ),
    );
  }
}

class GenericConsultationPage extends StatelessWidget {
  final ConsulationServices service;
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

  GenericConsultationPage({
    super.key,
    required this.service,
  });

  getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString('user_data') ?? jsonEncode(emptyUser).toString();
  }

  @override
  Widget build(BuildContext context) {
    var title = "Psychiatric Consultation";
    var subheading =
        "A comprehensive evaluation of the psychological, biological, medical and social causes of emotional distress.";
    var icon = Icons.supervisor_account;
    if (service == ConsulationServices.therapy) {
      title = "Occupational Therapy";
      subheading =
          "Helps patients develop, recover, improve, as well as maintain the skills needed for daily living and working.";
      icon = Icons.diversity_1;
    } else if (service == ConsulationServices.counseling) {
      title = "Counseling";
      subheading =
          "Learn about your condition and your moods, feelings, thoughts, and behaviors.";
      icon = Icons.handshake;
    } else if (service == ConsulationServices.assessment) {
      title = "Psychological Assesment";
      subheading =
          "To understand a person's strengths, and weaknesses, identify potential problem with cognitions, emotional reactivity, and make recommendations for treatment/remediation.";
      icon = Icons.psychology;
    }
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
            'BOOK APPOINTMENT',
            style: TextStyle(
                fontFamily: 'Proza Libre',
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white),
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 80),
          Padding(
            padding: const EdgeInsets.only(top: 30.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 70,
                  backgroundColor: mainBlue,
                  child: IconButton(
                    icon: Icon(
                      icon,
                      size: 70,
                      color: Colors.white,
                    ),
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: SizedBox(
              width: MediaQuery.sizeOf(context).width,
              child: SizedBox(
                width: 170,
                child: Center(
                  child: Text(
                    title,
                    textAlign: TextAlign.center,
                    softWrap: true,
                    maxLines: 2,
                    style: TextStyle(
                      color: primaryBlue,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Roboto',
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
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
                color: primaryBlue,
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
                      backgroundColor:
                          MaterialStateProperty.all<Color>(mainBlue)),
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

class BookSchedulePage extends StatefulWidget {
  const BookSchedulePage({super.key});

  @override
  State<BookSchedulePage> createState() => _BookSchedulePageState();
}

class _BookSchedulePageState extends State<BookSchedulePage> {
  int? scheduleValue = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            'SCHEDULE APPOINTMENT',
            style: TextStyle(
                fontFamily: 'Proza Libre',
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white),
          ),
        ),
      ),
      body: Column(
        children: [
          SizedBox(height: 60),
          SizedBox(
            width: MediaQuery.sizeOf(context).width,
            height: 380,
            child: SfDateRangePicker(
              showTodayButton: false,
              enablePastDates: false,
              selectionShape: DateRangePickerSelectionShape.rectangle,
              selectionColor: primaryLightBlue,
              headerHeight: 80,
              monthViewSettings: DateRangePickerMonthViewSettings(
                blackoutDates: [DateTime(2023, 10, 20), DateTime(2023, 10, 21)],
                viewHeaderStyle: DateRangePickerViewHeaderStyle(
                    backgroundColor: calendarHeaderBgLightTeal),
              ),
              monthCellStyle: DateRangePickerMonthCellStyle(
                cellDecoration: BoxDecoration(
                    color: calendarCellUnselectedBgWhite,
                    // border:
                    //     Border.all(color: const Color(0xFFF44436), width: 1),
                    shape: BoxShape.rectangle),
                blackoutDatesDecoration: BoxDecoration(
                    color: Colors.red,
                    border:
                        Border.all(color: const Color(0xFFF44436), width: 1),
                    shape: BoxShape.rectangle),
                disabledDatesDecoration: BoxDecoration(
                    color: unselectedGray,
                    border: Border.all(color: unselectedGray, width: 1),
                    shape: BoxShape.rectangle),
                specialDatesDecoration: BoxDecoration(
                    color: Colors.green,
                    border:
                        Border.all(color: const Color(0xFF2B732F), width: 1),
                    shape: BoxShape.circle),
              ),
              headerStyle: DateRangePickerHeaderStyle(
                  backgroundColor: calendarHeaderMainLightBlue,
                  textAlign: TextAlign.center,
                  textStyle: TextStyle(
                    fontStyle: FontStyle.normal,
                    fontSize: 25,
                    letterSpacing: 5,
                    color: backgroundColor,
                  )),
            ),
          ),
          Container(
            height: 8,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: <Color>[mainLightBlue, primaryBlue]),
            ),
          ),
          SizedBox(height: 20),
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
                  color: primaryBlue,
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ChoiceChip(
                label: Text('9:00-10:00'),
                selected: scheduleValue == 0,
                onSelected: (bool selected) {
                  setState(() {
                    scheduleValue = selected ? 0 : null;
                  });
                },
              ),
              ChoiceChip(
                label: Text('10:00-11:00'),
                selected: scheduleValue == 1,
                onSelected: (bool selected) {
                  setState(() {
                    scheduleValue = selected ? 1 : null;
                  });
                },
              ),
              ChoiceChip(
                label: Text('11:00-12:00'),
                selected: scheduleValue == 2,
                onSelected: (bool selected) {
                  setState(() {
                    scheduleValue = selected ? 2 : null;
                  });
                },
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ChoiceChip(
                label: Text('1:00-2:00'),
                selected: scheduleValue == 3,
                onSelected: (bool selected) {
                  setState(() {
                    scheduleValue = selected ? 3 : null;
                  });
                },
              ),
              ChoiceChip(
                label: Text('2:00-3:00'),
                selected: scheduleValue == 4,
                onSelected: (bool selected) {
                  setState(() {
                    scheduleValue = selected ? 4 : null;
                  });
                },
              ),
              ChoiceChip(
                label: Text('3:00-4:00'),
                selected: scheduleValue == 5,
                onSelected: (bool selected) {
                  setState(() {
                    scheduleValue = selected ? 5 : null;
                  });
                },
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
                            builder: ((context) => BookScheduleSuccessPage())));
                  },
                  style: ButtonStyle(
                      minimumSize:
                          MaterialStateProperty.all<Size>(Size(200, 50)),
                      backgroundColor:
                          MaterialStateProperty.all<Color>(primaryLightBlue)),
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

class BookScheduleSuccessPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: ((context) => DashboardPage())));
        },
        child: Container(
          color: backgroundColor,
          child: Column(
            children: [
              SizedBox(height: 100),
              Image.asset(
                'images/welcome_logo.png',
                fit: BoxFit.fitHeight,
                height: 300,
              ),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 15.0),
                    child: MainHeadingText(
                        title: "October 15, 2023",
                        isOverflow: false,
                        isHeavy: true,
                        customColor: mainLightGreen),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 15.0),
                    child: SubHeadingText(
                        title: "Friday (1:00 - 2:00)",
                        isOverflow: false,
                        isHeavy: true,
                        customColor: Colors.black),
                  )
                ],
              ),
              SizedBox(height: 50),
              SizedBox(
                width: MediaQuery.sizeOf(context).width - 80,
                child: HeaderContentText(
                    title:
                        'Your appointment request has been submitted. Please wait for our call(09362855204) between 2-3 business days for confirmation of booking appointment.',
                    isOverflow: true,
                    isHeavy: true,
                    customColor: Colors.black87),
              ),
              SizedBox(height: 70),
              FilledButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => DashboardPage())));
                },
                style: ButtonStyle(
                    minimumSize: MaterialStateProperty.all<Size>(Size(200, 50)),
                    backgroundColor:
                        MaterialStateProperty.all<Color>(primaryLightBlue)),
                child: Text('CONFIRM'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
