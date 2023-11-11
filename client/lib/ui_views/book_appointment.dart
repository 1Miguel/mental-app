import 'package:flutter/material.dart';
import 'package:flutter_intro/controllers/appointment_controller.dart';
import 'package:flutter_intro/ui_views/dashboard_messages.dart';
import 'package:flutter_intro/ui_views/dashboard_profile.dart';
import 'package:flutter_intro/utils/colors_scheme.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:flutter_intro/model/appointment.dart' as appModel;
import 'package:flutter/scheduler.dart';
import 'package:intl/intl.dart';
import 'dashboard_views.dart';
import 'dart:convert';
import 'package:get/get.dart';

// Loacl import
import 'package:flutter_intro/model/user.dart';

// Third-party import
import 'package:shared_preferences/shared_preferences.dart';
import 'package:custom_sliding_segmented_control/custom_sliding_segmented_control.dart';

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
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {},
      child: Scaffold(
        backgroundColor: bookMainBg,
        resizeToAvoidBottomInset: false,
        body: Container(
          color: bookMainBg,
          child: Column(
            children: [
              SizedBox(height: 120),
              Image.asset(
                'images/book_intro.png',
                width: 300,
                fit: BoxFit.fitWidth,
                height: 400,
              ),
              SizedBox(height: 20),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: MediaQuery.sizeOf(context).width - 60,
                    child: Text(
                      "We will continue to enhance individual and collective well-being for a mentally healthy Philippines!",
                      softWrap: true,
                      maxLines: 3,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: 'Open Sans',
                          fontSize: 18,
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
                          builder: ((context) => BookSelectionServicePage())));
                },
                style: ButtonStyle(
                  minimumSize: MaterialStateProperty.all<Size>(Size(200, 50)),
                  backgroundColor:
                      MaterialStateProperty.all<Color>(forumButton),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      side: BorderSide(width: 2.0, color: loginDarkTeal),
                    ),
                  ),
                ),
                child: Text(
                  'GET STARTED',
                  style: TextStyle(
                      fontFamily: 'Open Sans', fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BookSelectionServicePage extends StatefulWidget {
  const BookSelectionServicePage({super.key});

  @override
  _BookSelectionServiceState createState() {
    return _BookSelectionServiceState();
  }
}

class _BookSelectionServiceState extends State<BookSelectionServicePage> {
  // _onPagePop(context) {
  //   Navigator.push(
  //       context, MaterialPageRoute(builder: ((context) => DashboardPage())));
  // }

  @override
  Widget build(BuildContext context) {
    const tilePadding = 10.0;
    const headerpadding = 10.0;
    return LayoutBuilder(builder: (context, constraint) {
      return PopScope(
        // onPopInvoked: (value) {
        //   _onPagePop(context);
        // },
        canPop: true,
        child: Scaffold(
          appBar: AppBar(
            toolbarHeight: 80,
            automaticallyImplyLeading: false,
            //backgroundColor: lightBlueBg,
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
            title: Text("BOOK APPOINTMENT",
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.w900)),
            centerTitle: true,
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
          ),
          body: Container(
            width: constraint.maxWidth,
            height: constraint.maxHeight,
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: headerpadding),
                  child: Container(
                    width: constraint.maxWidth - 20,
                    height: (constraint.maxHeight / 6) / 2,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 20.0, top: 10),
                              child: SizedBox(
                                child: Text(
                                  'Available Services',
                                  style: TextStyle(
                                      color: Colors.lightGreen, fontSize: 28),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 20.0),
                              child: SizedBox(
                                child: Text(
                                  'Please select from the following services:',
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 15),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Divider(),
                Padding(
                  padding: const EdgeInsets.only(top: tilePadding),
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: ((context) => GenericBookPage(
                                  service: ConsulationServices.counseling,
                                  serviceDesc:
                                      "Learn about your condition and your moods, feelings, thoughts and behaviors.",
                                  image:
                                      "images/service_select_counseling.png"))));
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: constraint.maxWidth - 30,
                          height: (constraint.maxHeight / 6) - tilePadding + 10,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Image.asset('images/select_counseling.png',
                                fit: BoxFit.fill),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: tilePadding),
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: ((context) => GenericBookPage(
                                  service: ConsulationServices.consultation,
                                  serviceDesc:
                                      "A comprehensive evaluation of the psychological, biological, medical and social causes of emotional distress.",
                                  image:
                                      "images/service_select_consultation.png"))));
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: constraint.maxWidth - 30,
                          height: (constraint.maxHeight / 6) - tilePadding + 10,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Image.asset('images/select_psych.png',
                                fit: BoxFit.fill),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: tilePadding),
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: ((context) => GenericBookPage(
                                  service: ConsulationServices.therapy,
                                  serviceDesc:
                                      "Helps patients develop, recover, improve as well as maintain the skills needed for daily living and working.",
                                  image:
                                      "images/service_select_therapy.png"))));
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: constraint.maxWidth - 30,
                          height: (constraint.maxHeight / 6) - tilePadding + 10,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Image.asset('images/select_occup.png',
                                fit: BoxFit.fill),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: tilePadding),
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: ((context) => GenericBookPage(
                                  service: ConsulationServices.assessment,
                                  serviceDesc:
                                      "To understand a person's strengths and weaknesses, identify potential problem, with cognitions, emotional reactivity, and make recommendations.",
                                  image:
                                      "images/service_select_assesment.png"))));
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: constraint.maxWidth - 30,
                          height: (constraint.maxHeight / 6) - tilePadding + 10,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Image.asset('images/select_assesment.png',
                                fit: BoxFit.fill),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}

class GenericBookPage extends StatefulWidget {
  final ConsulationServices service;
  final String serviceDesc;
  final String image;
  const GenericBookPage(
      {super.key,
      required this.service,
      required this.serviceDesc,
      required this.image});

  @override
  _GenericBookState createState() {
    return _GenericBookState(
        service: service, serviceDesc: serviceDesc, image: image);
  }
}

class _GenericBookState extends State<GenericBookPage> {
  final ConsulationServices service;
  final String serviceDesc;
  final String image;
  AppointmentController appointmentController =
      Get.put(AppointmentController());
  final _formKey = GlobalKey<FormState>();

  _GenericBookState(
      {required this.service, required this.serviceDesc, required this.image});

  String getTitle() {
    String title = "Counseling";
    if (service == ConsulationServices.consultation) {
      title = "Psychiatric Consultation";
    } else if (service == ConsulationServices.therapy) {
      title = "Occupational Therapy";
    } else if (service == ConsulationServices.assessment) {
      title = "Psychological Assesment";
    }
    return title;
  }

  @override
  void dispose() {
    appointmentController.concernController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const descPadding = 40.0;
    const headerpadding = 10.0;
    print("service selected: $service");
    return LayoutBuilder(builder: (context, constraint) {
      return PopScope(
        canPop: true,
        child: Scaffold(
          appBar: AppBar(
            toolbarHeight: 80,
            automaticallyImplyLeading: false,
            //backgroundColor: lightBlueBg,
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
          ),
          body: Form(
            key: _formKey,
            child: Container(
              width: constraint.maxWidth,
              height: constraint.maxHeight,
              child: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: headerpadding),
                    child: Container(
                      width: constraint.maxWidth - 20,
                      height: (constraint.maxHeight / 5),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 20.0, top: 10),
                                child: SizedBox(
                                  child: Text(
                                    getTitle(),
                                    style: TextStyle(
                                        color: forumButton, fontSize: 28),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Divider(),
                          Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 20.0),
                                  child: SizedBox(
                                    width: constraint.maxWidth - descPadding,
                                    child: Text(
                                      serviceDesc,
                                      softWrap: true,
                                      maxLines: 4,
                                      style: TextStyle(
                                          color: primaryGrey, fontSize: 17),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: constraint.maxWidth - 20,
                        height: (constraint.maxHeight / 5) * 2,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.asset(image, fit: BoxFit.fill),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    width: constraint.maxWidth,
                    height: (constraint.maxHeight / 5) * 2,
                    child: Column(children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 30.0, bottom: 5),
                        child: SizedBox(
                            width: constraint.maxWidth - 30,
                            child: Text("Concerns",
                                style: TextStyle(
                                    color: Colors.teal, fontSize: 18))),
                      ),
                      SizedBox(
                        width: constraint.maxWidth - 30,
                        height: ((constraint.maxHeight / 5) * 2) / 3,
                        child: TextFormField(
                          validator: (value) {
                            //String validPattern = '[^ a-zA-Z]';
                            if (value == null || value.isEmpty) {
                              return 'Please enter your concern first';
                            }
                            // if (value.contains(RegExp(validPattern))) {
                            //   return 'Must not contain invalid characters';
                            // }
                            if (value.length > 128) {
                              return 'Invalid length.';
                            }
                            return null;
                          },
                          controller: appointmentController.concernController,
                          maxLines: 3,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: unselectedLightBlue,
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(25.0)),
                            ),
                            hintText: 'Please note your concerns here...',
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 15.0),
                            child: TextButton(
                              child: Text(
                                'Next',
                                style: TextStyle(
                                    fontFamily: 'Open Sans',
                                    fontWeight: FontWeight.w900,
                                    fontSize: 18,
                                    color: Colors.teal),
                              ),
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: ((context) =>
                                              BookSchedulePage(
                                                  service: service))));
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ]),
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
                            builder: ((context) =>
                                BookSchedulePage(service: service))));
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

enum TimeSlot { slot0, slot1, slot2, slot3, slot4, slot5, slot6 }

class BookSchedulePage extends StatefulWidget {
  final ConsulationServices service;

  const BookSchedulePage({super.key, required this.service});

  @override
  State<BookSchedulePage> createState() =>
      _BookSchedulePageState(service: service);
}

class _BookSchedulePageState extends State<BookSchedulePage> {
  final ConsulationServices service;
  int? scheduleValue = TimeSlot.slot0.index;
  String _date = "0000-00-00";
  String _timeSlot = "00:00";
  String _selectionDate = "";
  String startDate = "";
  String endDate = "";
  String targetDate = "";
  bool dateSelected = false;
  String selectedService = "OCCUPATIONAL_THERAPY";
  late Future<List<appModel.AppointmentSlot>> futureBlockedSlots;

  Future<List<DateTime>> getBlockedDatesAsync() async {
    List<DateTime> dateList = <DateTime>[];
    List<appModel.AppointmentSlot> futureBlockedSlots =
        await appointmentController.fetchBlockedSlots(
            DateTime.now().year, DateTime.now().month);

    futureBlockedSlots.forEach((element) {
      dateList.add(DateTime.parse(element.startTime));
    });

    print(dateList);
    return dateList;
  }

  List<appModel.AppointmentSlot> blockedSlots = getSlots();
  static List<appModel.AppointmentSlot> getSlots() {
    const data = [
      {
        "start_time": "2023-10-25T09:00:00+00:00",
        "end_time": "2023-10-25T10:00:00+00:00"
      },
      {
        "start_time": "2023-10-23T09:00:00+00:00",
        "end_time": "2023-10-23T10:00:00+00:00"
      },
      {
        "start_time": "2023-10-23T09:00:00+00:00",
        "end_time": "2023-10-23T10:00:00+00:00"
      },
      {
        "start_time": "2023-10-23T09:00:00+00:00",
        "end_time": "2023-10-23T10:00:00+00:00"
      },
      {
        "start_time": "2023-10-23T09:00:00+00:00",
        "end_time": "2023-10-23T10:00:00+00:00"
      },
      {
        "start_time": "2023-10-23T09:00:00+00:00",
        "end_time": "2023-10-23T10:00:00+00:00"
      }
    ];
    return data
        .map<appModel.AppointmentSlot>(appModel.AppointmentSlot.fromJson)
        .toList();
  }

  _BookSchedulePageState({required this.service});

  AppointmentController appointmentController =
      Get.put(AppointmentController());

  @override
  void initState() {
    super.initState();
    if (service == ConsulationServices.therapy) {
      selectedService = "OCCUPATIONAL_THERAPY";
    } else if (service == ConsulationServices.consultation) {
      selectedService = "PSYCHIATRIC_CONSULTATION";
    } else if (service == ConsulationServices.counseling) {
      selectedService = "COUNSELING";
    } else if (service == ConsulationServices.assessment) {
      selectedService = "PSYCHOLOGICAL_ASSESMENT";
    }
  }

  void updateSelectionDate() {
    setState(() {
      const tString = "T";
      startDate = "$_date$tString$_timeSlot";
      print("startDate: $startDate");

      final sunDate = DateTime.parse(startDate).add(const Duration(hours: 1));
      endDate = DateFormat('yyyy-MM-ddTHH:mm').format(sunDate).toString();
      print("endDate: $endDate");
    });
  }

  void selectionChanged(DateRangePickerSelectionChangedArgs args) {
    SchedulerBinding.instance!.addPostFrameCallback((duration) {
      setState(() {
        dateSelected = true;
        _date = DateFormat('yyyy-MM-dd').format(args.value).toString();
        print("date selection changed");
        updateSelectionDate();
      });
    });
  }

  List<DateTime> getBlackoutDates() {
    List<DateTime> blockDateList = <DateTime>[];

    print("Get Blackout Dates");

    blockedSlots.forEach((element) {
      // final blockDay =
      //     DateFormat('yyyy-MM-dd').format(DateTime.parse(element.startTime));
      blockDateList.add(DateTime.parse(element.startTime));
    });

    return blockDateList;
  }

  @override
  Widget build(BuildContext context) {
    getBlockedDatesAsync();
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        automaticallyImplyLeading: false,
        title: Text("Schedule Appointment"),
        centerTitle: true,
        backgroundColor: Colors.teal,
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
      ),
      body: Column(
        children: [
          SizedBox(
            width: MediaQuery.sizeOf(context).width,
            height: 380,
            child: FutureBuilder<List<DateTime>>(
                future: getBlockedDatesAsync(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final dates = snapshot.data!;
                    print("dates");
                    print(dates);
                    return SfDateRangePicker(
                      showTodayButton: false,
                      enablePastDates: false,
                      selectionShape: DateRangePickerSelectionShape.rectangle,
                      selectionColor: primaryLightBlue,
                      headerHeight: 80,
                      showNavigationArrow: true,
                      monthViewSettings: DateRangePickerMonthViewSettings(
                        //blackoutDates: [DateTime(2023, 10, 20), DateTime(2023, 10, 21)],
                        blackoutDates: dates,
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
                            color: unselectedGray,
                            border: Border.all(color: Colors.white, width: 1),
                            shape: BoxShape.rectangle),
                        disabledDatesDecoration: BoxDecoration(
                            color: unselectedGray,
                            border: Border.all(color: unselectedGray, width: 1),
                            shape: BoxShape.rectangle),
                        specialDatesDecoration: BoxDecoration(
                            color: Colors.green,
                            border: Border.all(
                                color: const Color(0xFF2B732F), width: 1),
                            shape: BoxShape.circle),
                      ),
                      headerStyle: DateRangePickerHeaderStyle(
                          backgroundColor: Colors.teal,
                          textAlign: TextAlign.center,
                          textStyle: TextStyle(
                            fontStyle: FontStyle.normal,
                            fontSize: 25,
                            letterSpacing: 5,
                            color: backgroundColor,
                          )),
                      onSelectionChanged: selectionChanged,
                    );
                  } else {
                    return Container(
                      width: MediaQuery.sizeOf(context).width,
                      child: CircularProgressIndicator(
                        color: primaryGrey,
                      ),
                    );
                  }
                }),
          ),
          SizedBox(height: 10),
          Container(
            height: 8,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: <Color>[mainLightBlue, primaryBlue]),
            ),
          ),
          SizedBox(height: 30),
          SizedBox(
            width: MediaQuery.sizeOf(context).width,
            child: Padding(
              padding: const EdgeInsets.only(left: 25.0),
              child: Text(
                'Select Available Time',
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ChoiceChip(
                label: Text('9:00-10:00'),
                selected: scheduleValue == TimeSlot.slot1.index,
                selectedColor: slotSelect,
                onSelected: (bool selected) {
                  setState(() {
                    _timeSlot = "09:00";
                    updateSelectionDate();
                    scheduleValue = selected ? TimeSlot.slot1.index : null;
                  });
                },
              ),
              ChoiceChip(
                label: Text('10:00-11:00'),
                selected: scheduleValue == TimeSlot.slot2.index,
                selectedColor: slotSelect,
                onSelected: (bool selected) {
                  setState(() {
                    _timeSlot = "10:00";
                    updateSelectionDate();
                    scheduleValue = selected ? TimeSlot.slot2.index : null;
                  });
                },
              ),
              ChoiceChip(
                label: Text('11:00-12:00'),
                selected: scheduleValue == TimeSlot.slot3.index,
                selectedColor: slotSelect,
                onSelected: (bool selected) {
                  setState(() {
                    _timeSlot = "11:00";
                    updateSelectionDate();
                    scheduleValue = selected ? TimeSlot.slot3.index : null;
                  });
                },
              ),
            ],
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ChoiceChip(
                label: Text('01:00-02:00'),
                selected: scheduleValue == TimeSlot.slot4.index,
                selectedColor: slotSelect,
                onSelected: (bool selected) {
                  setState(() {
                    _timeSlot = "01:00";
                    updateSelectionDate();
                    scheduleValue = selected ? TimeSlot.slot4.index : null;
                  });
                },
              ),
              ChoiceChip(
                label: Text('02:00-03:00'),
                selected: scheduleValue == TimeSlot.slot5.index,
                selectedColor: slotSelect,
                onSelected: (bool selected) {
                  setState(() {
                    _timeSlot = "02:00";
                    updateSelectionDate();
                    scheduleValue = selected ? TimeSlot.slot5.index : null;
                  });
                },
              ),
              ChoiceChip(
                label: Text('03:00-04:00'),
                selected: scheduleValue == TimeSlot.slot6.index,
                selectedColor: slotSelect,
                onSelected: (bool selected) {
                  setState(() {
                    _timeSlot = "03:00";
                    updateSelectionDate();
                    scheduleValue = selected ? TimeSlot.slot6.index : null;
                  });
                },
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
                    if (scheduleValue != TimeSlot.slot0.index && dateSelected) {
                      print("Valid Schedule is selected");
                      print("startDate: $startDate endDate:$endDate");
                      print('Service Type: $selectedService');
                    } else {
                      print("No valid schedule selected");
                    }
                    appointmentController.setAppointment(
                        startDate, endDate, selectedService);
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: ((context) => BookScheduleSuccessPage())));
                  },
                  style: ButtonStyle(
                      minimumSize:
                          MaterialStateProperty.all<Size>(Size(200, 50)),
                      backgroundColor:
                          MaterialStateProperty.all<Color>(forumButton)),
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
    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 80,
          title: Text("Pending Approval",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w900,
                  fontSize: 35)),
          centerTitle: true,
          automaticallyImplyLeading: false,
          //backgroundColor: lightBlueBg,
          flexibleSpace: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('images/bg_yellow_hd.png'),
                    fit: BoxFit.fill),
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.elliptical(50, 20),
                    bottomRight: Radius.elliptical(50, 20))),
          ),
        ),
        body: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: ((context) => DashboardPage())));
          },
          child: Container(
            width: MediaQuery.sizeOf(context).width,
            color: backgroundColor,
            child: Column(
              children: [
                SizedBox(height: 100),
                Image.asset(
                  'images/calendar_logo.png',
                  fit: BoxFit.fitHeight,
                  height: 200,
                ),
                SizedBox(height: 20),
                SizedBox(
                  width: MediaQuery.sizeOf(context).width - 80,
                  child: Text(
                    "December 25, 2023",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 30,
                        fontWeight: FontWeight.w900),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.sizeOf(context).width - 80,
                  child: Text(
                    "01:00 - 02:00",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: primaryGrey,
                        fontSize: 25,
                        fontWeight: FontWeight.w900),
                  ),
                ),
                SizedBox(height: 40),
                SizedBox(
                  width: MediaQuery.sizeOf(context).width - 80,
                  child: HeaderContentText(
                      title:
                          "Your appointment request has been submitted. We'll notify you by email or by SMS between 1-2 business days for confirmation of booking appointment",
                      isOverflow: true,
                      isHeavy: true,
                      customColor: Colors.black54),
                ),
                SizedBox(height: 70),
                FilledButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: ((context) => AppointmentTab())));
                  },
                  style: ButtonStyle(
                      minimumSize:
                          MaterialStateProperty.all<Size>(Size(200, 50)),
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.orange)),
                  child: Text('CONTINUE'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ScheduleCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraint) {
      return Container(
        width: constraint.maxWidth,
        height: constraint.maxHeight,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: constraint.maxWidth - 30,
              height: constraint.maxHeight - 10,
              child: Row(
                children: [
                  Container(
                    width: 20,
                    height: constraint.maxHeight - 10,
                    decoration: BoxDecoration(
                      color: scLineGreen,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                        bottomLeft: Radius.circular(50),
                      ),
                    ),
                  ),
                  Container(
                    width: constraint.maxWidth - 30 - 20,
                    height: constraint.maxHeight - 10,
                    decoration: BoxDecoration(
                      color: scBgGreen,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(25),
                        bottomRight: Radius.circular(25),
                      ),
                    ),
                    child: Column(
                      children: [
                        SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: SizedBox(
                            width: constraint.maxWidth - 30 - 20 - 10,
                            child: Text(
                                "Philippine Mental Health Association - Palawan Chapter",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: scTitleDarkGreen,
                                )),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: SizedBox(
                            width: constraint.maxWidth - 30 - 20 - 10,
                            child: Text("Service: Counseling",
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: scTitleGreen,
                                )),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: SizedBox(
                            width: constraint.maxWidth - 30 - 20 - 10,
                            child: Text("Patient Name: John Doe",
                                style: TextStyle(
                                  fontSize: 13,
                                  color: scContentGreen,
                                )),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Row(
                            children: [
                              Icon(Icons.today, size: 15, color: scTitleGreen),
                              Text(" 2023-11-15  ",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: scContentGreen,
                                  )),
                              Icon(Icons.schedule,
                                  size: 15, color: scTitleGreen),
                              Text("01:00-02:00",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: scContentGreen,
                                  )),
                            ],
                          ),
                        ),
                        SizedBox(height: 10),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
}

class ReScheduleCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraint) {
      return Container(
        width: constraint.maxWidth,
        height: constraint.maxHeight,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: constraint.maxWidth - 30,
              height: constraint.maxHeight - 10,
              child: Row(
                children: [
                  Container(
                    width: 20,
                    height: constraint.maxHeight - 10,
                    decoration: BoxDecoration(
                      color: scLineGreen,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                        bottomLeft: Radius.circular(50),
                      ),
                    ),
                  ),
                  Container(
                    width: constraint.maxWidth - 30 - 20,
                    height: constraint.maxHeight - 10,
                    decoration: BoxDecoration(
                      color: scBgGreen,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(25),
                        bottomRight: Radius.circular(25),
                      ),
                    ),
                    child: Column(
                      children: [
                        SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: SizedBox(
                            width: constraint.maxWidth - 30 - 20 - 10,
                            child: Text(
                                "Philippine Mental Health Association - Palawan Chapter",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: scTitleDarkGreen,
                                )),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: SizedBox(
                            width: constraint.maxWidth - 30 - 20 - 10,
                            child: Text("Service: Counseling",
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: scTitleGreen,
                                )),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: SizedBox(
                            width: constraint.maxWidth - 30 - 20 - 10,
                            child: Text("Patient Name: John Doe",
                                style: TextStyle(
                                  fontSize: 13,
                                  color: scContentGreen,
                                )),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Row(
                            children: [
                              Icon(Icons.today, size: 15, color: scTitleGreen),
                              Text(" 2023-11-15  ",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: scContentGreen,
                                  )),
                              Icon(Icons.schedule,
                                  size: 15, color: scTitleGreen),
                              Text("01:00-02:00",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: scContentGreen,
                                  )),
                            ],
                          ),
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            FilledButton(
                              onPressed: () {},
                              style: ButtonStyle(
                                  minimumSize: MaterialStateProperty.all<Size>(
                                      Size(80, 30)),
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.blue)),
                              child: Row(children: [
                                Icon(Icons.restore),
                                Text("   Reschedule")
                              ]),
                            ),
                            FilledButton(
                              onPressed: () {},
                              style: ButtonStyle(
                                  minimumSize: MaterialStateProperty.all<Size>(
                                      Size(80, 30)),
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.red)),
                              child: Row(children: [
                                Icon(Icons.update_disabled),
                                Text("   Cancel")
                              ]),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
}

class PendingCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraint) {
      return Container(
        width: constraint.maxWidth,
        height: constraint.maxHeight,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: constraint.maxWidth - 30,
              height: constraint.maxHeight - 10,
              child: Row(
                children: [
                  Container(
                    width: 20,
                    height: constraint.maxHeight - 10,
                    decoration: BoxDecoration(
                      color: Colors.orange,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                        bottomLeft: Radius.circular(50),
                      ),
                    ),
                  ),
                  Container(
                    width: constraint.maxWidth - 30 - 20,
                    height: constraint.maxHeight - 10,
                    decoration: BoxDecoration(
                      color: Colors.yellow.shade100,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(25),
                        bottomRight: Radius.circular(25),
                      ),
                    ),
                    child: Column(
                      children: [
                        SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: SizedBox(
                            width: constraint.maxWidth - 30 - 20 - 10,
                            child: Text(
                                "Philippine Mental Health Association - Palawan Chapter",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.orange.shade700,
                                )),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: SizedBox(
                            width: constraint.maxWidth - 30 - 20 - 10,
                            child: Text("Service: Counseling",
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.orange,
                                )),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: SizedBox(
                            width: constraint.maxWidth - 30 - 20 - 10,
                            child: Text("Patient Name: John Doe",
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.orange.shade300,
                                )),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Row(
                            children: [
                              Icon(Icons.today,
                                  size: 15, color: Colors.orange.shade700),
                              Text(" 2023-11-15  ",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: Colors.orange.shade700,
                                  )),
                              Icon(Icons.schedule,
                                  size: 15, color: Colors.orange.shade700),
                              Text("01:00-02:00",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: Colors.orange.shade700,
                                  )),
                            ],
                          ),
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            FilledButton(
                              onPressed: () {},
                              style: ButtonStyle(
                                  minimumSize: MaterialStateProperty.all<Size>(
                                      Size(80, 30)),
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.blue)),
                              child: Row(children: [
                                Icon(Icons.restore),
                                Text("   Reschedule")
                              ]),
                            ),
                            FilledButton(
                              onPressed: () {},
                              style: ButtonStyle(
                                  minimumSize: MaterialStateProperty.all<Size>(
                                      Size(80, 30)),
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.red)),
                              child: Row(children: [
                                Icon(Icons.update_disabled),
                                Text("   Cancel")
                              ]),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
}

class PreviousCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraint) {
      return Container(
        width: constraint.maxWidth,
        height: constraint.maxHeight,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: constraint.maxWidth - 30,
              height: constraint.maxHeight - 10,
              child: Row(
                children: [
                  Container(
                    width: 20,
                    height: constraint.maxHeight - 10,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade600,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                        bottomLeft: Radius.circular(50),
                      ),
                    ),
                  ),
                  Container(
                    width: constraint.maxWidth - 30 - 20,
                    height: constraint.maxHeight - 10,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(25),
                        bottomRight: Radius.circular(25),
                      ),
                    ),
                    child: Column(
                      children: [
                        SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: SizedBox(
                            width: constraint.maxWidth - 30 - 20 - 10,
                            child: Text(
                                "Philippine Mental Health Association - Palawan Chapter",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey.shade800,
                                )),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: SizedBox(
                            width: constraint.maxWidth - 30 - 20 - 10,
                            child: Text("Service: Counseling",
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: primaryGrey,
                                )),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: SizedBox(
                            width: constraint.maxWidth - 30 - 20 - 10,
                            child: Text("Patient Name: John Doe",
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.grey,
                                )),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Row(
                            children: [
                              Icon(Icons.today, size: 15, color: primaryGrey),
                              Text(" 2023-11-15  ",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: primaryGrey,
                                  )),
                              Icon(Icons.schedule,
                                  size: 15, color: primaryGrey),
                              Text("01:00-02:00",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: primaryGrey,
                                  )),
                            ],
                          ),
                        ),
                        SizedBox(height: 10),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
}

class AppointmentTab extends StatefulWidget {
  const AppointmentTab({super.key});

  @override
  _AppointmentTabState createState() {
    return _AppointmentTabState();
  }
}

class _AppointmentTabState extends State<AppointmentTab> {
  int _selectedIndex = 2;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if (index == 0) {
        Navigator.push(context,
            MaterialPageRoute(builder: ((context) => DashboardPage())));
      } else if (index == 1) {
        Navigator.push(
            context, MaterialPageRoute(builder: ((context) => MessagesTab())));
      } else if (index == 3) {
        Navigator.push(
            context, MaterialPageRoute(builder: ((context) => ProfileTab())));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraint) {
      double headPadding = 20;
      double headerSize = 30;
      double tileHeight = constraint.maxHeight / 5;
      return PopScope(
        canPop: false,
        child: Scaffold(
          appBar: AppBar(
            toolbarHeight: 80,
            automaticallyImplyLeading: false,
            //backgroundColor: lightBlueBg,
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
            title: Text("APPOINTMENT",
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.w900)),
            centerTitle: true,
            // leading: SizedBox(
            //   width: 20,
            //   height: 20,
            //   child: Padding(
            //     padding: EdgeInsets.only(bottom: 3.0, left: 11.0),
            //     child: IconButton(
            //       icon: const Icon(
            //         Icons.arrow_back,
            //         size: 30,
            //         color: Colors.white,
            //       ),
            //       onPressed: () {
            //         Navigator.pop(context);
            //       },
            //     ),
            //   ),
            // ),
          ),
          body: Container(
            width: constraint.maxWidth,
            height: constraint.maxHeight,
            child: Column(
              children: [
                SizedBox(height: headPadding),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: SizedBox(
                    width: constraint.maxWidth,
                    height: headerSize,
                    child: Text("Upcoming Schedule",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w900,
                          fontSize: 25,
                        )),
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  width: constraint.maxWidth,
                  height: tileHeight - 30,
                  child: ScheduleCard(),
                ),
                Divider(),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: SizedBox(
                    width: constraint.maxWidth,
                    height: headerSize,
                    child: Text("Manage Bookings",
                        style: TextStyle(
                          color: Colors.black87,
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                        )),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: ((context) =>
                                  BookSelectionServicePage())));
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: constraint.maxWidth - 30,
                          height: tileHeight + 20,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Image.asset(
                                'images/book_appointment_tab.png',
                                fit: BoxFit.fill),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: ((context) => ReschedulePage())));
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: constraint.maxWidth - 30,
                          height: tileHeight + 20,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Image.asset('images/reschedule_tab.png',
                                fit: BoxFit.fill),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          bottomNavigationBar: SizedBox(
            width: MediaQuery.sizeOf(context).width,
            height: 60,
            child: BottomNavigationBar(
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Home',
                  backgroundColor: HexColor("#67ddd8"),
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.mail),
                  label: 'Messages',
                  backgroundColor: HexColor("#5ce1e6"),
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.event),
                  label: 'Appointment',
                  backgroundColor: HexColor("#67ddd8"),
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.account_circle),
                  label: 'Profile',
                  backgroundColor: HexColor("#5ce1e6"),
                ),
              ],
              currentIndex: _selectedIndex,
              selectedItemColor: Colors.teal,
              onTap: _onItemTapped,
            ),
          ),
        ),
      );
    });
  }
}

class ReschedulePage extends StatefulWidget {
  const ReschedulePage({super.key});

  @override
  _ReschedulePageState createState() {
    return _ReschedulePageState();
  }
}

class _ReschedulePageState extends State<ReschedulePage> {
  int _selectedIndex = 2;
  List<appModel.Appointment> upcoming = getUpcoming();

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if (index == 0) {
        Navigator.push(context,
            MaterialPageRoute(builder: ((context) => DashboardPage())));
      }
    });
  }

  static List<appModel.Appointment> getUpcoming() {
    const data = [
      {
        "startTime": "2023-11-06T09:00:00+00:00",
        "endTime": "2023-11-06T09:00:00+00:00",
        "service": "Therapy",
        "concerns": "sample",
      },
      {
        "startTime": "2023-11-06T09:00:00+00:00",
        "endTime": "2023-11-06T09:00:00+00:00",
        "service": "Therapy",
        "concerns": "sample",
      },
      {
        "startTime": "2023-11-06T09:00:00+00:00",
        "endTime": "2023-11-06T09:00:00+00:00",
        "service": "Therapy",
        "concerns": "sample",
      },
      {
        "startTime": "2023-11-06T09:00:00+00:00",
        "endTime": "2023-11-06T09:00:00+00:00",
        "service": "Therapy",
        "concerns": "sample",
      },
      {
        "startTime": "2023-11-06T09:00:00+00:00",
        "endTime": "2023-11-06T09:00:00+00:00",
        "service": "Therapy",
        "concerns": "sample",
      },
      {
        "startTime": "2023-11-06T09:00:00+00:00",
        "endTime": "2023-11-06T09:00:00+00:00",
        "service": "Therapy",
        "concerns": "sample",
      }
    ];
    return data
        .map<appModel.Appointment>(appModel.Appointment.fromJson)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: LayoutBuilder(builder: (context, constraint) {
        return Scaffold(
          appBar: AppBar(
            toolbarHeight: 80,
            automaticallyImplyLeading: false,
            //backgroundColor: lightBlueBg,
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
            title: Text("SCHEDULE/RESCHEDULE",
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.w900)),
            centerTitle: true,
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
            bottom: TabBar(
              dividerColor: Colors.transparent,
              indicatorColor: Colors.yellow,
              labelColor: Colors.white,
              unselectedLabelColor: primaryGrey,
              labelStyle: TextStyle(color: Colors.white),
              tabs: [
                Tab(text: "Upcoming", icon: Icon(Icons.schedule)),
                Tab(text: "Pending", icon: Icon(Icons.pending_actions)),
                Tab(text: "Previous", icon: Icon(Icons.history)),
              ],
            ),
          ),
          body: Container(
            width: constraint.maxWidth,
            height: constraint.maxHeight,
            child: TabBarView(
              children: <Widget>[
                Container(
                  width: constraint.maxWidth,
                  height: constraint.maxHeight - 80,
                  child: Column(
                    children: [
                      SizedBox(height: 20),
                      Container(
                          width: constraint.maxWidth,
                          height: constraint.maxHeight - 200,
                          child: buildUpcoming(upcoming)),
                    ],
                  ),
                ),
                Container(
                  width: constraint.maxWidth,
                  height: constraint.maxHeight - 80,
                  child: Column(
                    children: [
                      SizedBox(height: 20),
                      Container(
                          width: constraint.maxWidth,
                          height: constraint.maxHeight - 200,
                          child: buildPending(upcoming)),
                    ],
                  ),
                ),
                Container(
                  width: constraint.maxWidth,
                  height: constraint.maxHeight - 80,
                  child: Column(
                    children: [
                      SizedBox(height: 20),
                      Container(
                          width: constraint.maxWidth,
                          height: constraint.maxHeight - 200,
                          child: buildPrevious(upcoming)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget buildUpcoming(List<appModel.Appointment> upcoming) => ListView.builder(
        itemCount: upcoming.length,
        itemBuilder: (context, index) {
          final thread = upcoming[index];
          return LayoutBuilder(builder: (context, constraint) {
            return Column(
              children: [
                Container(
                    width: constraint.maxWidth,
                    height: 200,
                    child: ReScheduleCard()),
                Divider(),
              ],
            );
          });
        },
      );

  Widget buildPending(List<appModel.Appointment> upcoming) => ListView.builder(
        itemCount: upcoming.length,
        itemBuilder: (context, index) {
          final thread = upcoming[index];
          return LayoutBuilder(builder: (context, constraint) {
            return Column(
              children: [
                Container(
                    width: constraint.maxWidth,
                    height: 200,
                    child: PendingCard()),
                Divider(),
              ],
            );
          });
        },
      );

  Widget buildPrevious(List<appModel.Appointment> upcoming) => ListView.builder(
        itemCount: upcoming.length,
        itemBuilder: (context, index) {
          final thread = upcoming[index];
          return LayoutBuilder(builder: (context, constraint) {
            return Column(
              children: [
                Container(
                    width: constraint.maxWidth,
                    height: 140,
                    child: PreviousCard()),
                Divider(),
              ],
            );
          });
        },
      );
}
