import 'package:flutter/material.dart';
import 'package:flutter_intro/ui_views/dashboard_views.dart';
import 'package:flutter_intro/utils/colors_scheme.dart';

class TitleText extends StatelessWidget {
  final String title;
  final bool isOverflow;

  const TitleText({
    super.key,
    required this.title,
    required this.isOverflow,
  });

  @override
  Widget build(BuildContext context) {
    double newSize = isOverflow ? 30 : 45;
    return Text(
      title,
      textAlign: TextAlign.center,
      softWrap: true,
      maxLines: 2,
      style: TextStyle(
        color: mainDarkBlue,
        fontFamily: 'Proza Libre',
        fontWeight: FontWeight.w900,
        fontSize: newSize,
      ),
    );
  }
}

class TitleSubHeadingText extends StatelessWidget {
  final String title;

  const TitleSubHeadingText({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      textAlign: TextAlign.center,
      style: TextStyle(
        color: Color.fromARGB(255, 0, 74, 173),
        fontWeight: FontWeight.w900,
        fontSize: 30,
      ),
    );
  }
}

class FormHeadingText extends StatelessWidget {
  final String title;
  final Color textColor;

  const FormHeadingText({
    super.key,
    required this.title,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        color: textColor,
        fontWeight: FontWeight.bold,
        fontSize: 20,
      ),
    );
  }
}

class FormSubHeadingText extends StatelessWidget {
  final String title;

  const FormSubHeadingText({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        color: Colors.deepPurple,
        fontWeight: FontWeight.bold,
        fontSize: 15,
      ),
    );
  }
}

class IconTitleBox extends StatelessWidget {
  final String title;
  final bool overwriteSize;
  double? fontSize;

  IconTitleBox({
    super.key,
    required this.title,
    required this.overwriteSize,
    dynamic fontSize = 0,
  });

  @override
  Widget build(BuildContext context) {
    double textSize = 20;
    if (title.length < 10) {
      textSize = 25;
    } else if (title.length > 20) {
      textSize = 15;
    }

    if (overwriteSize) {
      textSize = fontSize ?? 20.0;
    }
    return SizedBox(
      width: 170,
      child: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Text(
          title,
          textAlign: TextAlign.center,
          softWrap: true,
          maxLines: 2,
          style: TextStyle(
            color: secondaryBlue,
            fontWeight: FontWeight.w900,
            fontFamily: 'Roboto',
            fontSize: textSize,
          ),
        ),
      ),
    );
  }
}

class IconSubheadingBox extends StatelessWidget {
  final String title;

  const IconSubheadingBox({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    double textSize = 13;
    if (title.length < 10) {
      textSize = 15;
    } else if (title.length > 20) {
      textSize = 11;
    }
    return SizedBox(
      width: 170,
      child: Text(
        title,
        textAlign: TextAlign.center,
        softWrap: true,
        maxLines: 2,
        style: TextStyle(
          color: mainLightBlue,
          fontSize: textSize,
        ),
      ),
    );
  }
}

class MembershipView extends StatelessWidget {
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
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 50,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: TitleText(
              title: 'MEMBERSHIP',
              isOverflow: false,
            ),
          ),
          SizedBox(
            height: 80,
          ),
          RegisterMemberIcons(),
        ],
      ),
    );
  }
}

enum MembershipActions { register, cancel }

class RegisterMemberIcons extends StatefulWidget {
  const RegisterMemberIcons({super.key});

  @override
  State<RegisterMemberIcons> createState() => _RegisterMemberIconsState();
}

class _RegisterMemberIconsState extends State<RegisterMemberIcons> {
  bool membershipSelected = false;
  bool registerMemberSelected = false;
  bool cancelMemberSelected = false;

  resetStates() {
    if (registerMemberSelected) {
      setState(() {
        registerMemberSelected = false;
      });
    } else if (cancelMemberSelected) {
      setState(() {
        cancelMemberSelected = false;
      });
    }
  }

  setStateValue(MembershipActions action, bool actionState, bool memberState) {
    if (action == MembershipActions.register) {
      setState(() {
        registerMemberSelected = actionState;
        membershipSelected = memberState;
      });
    } else if (action == MembershipActions.cancel) {
      setState(() {
        cancelMemberSelected = actionState;
        membershipSelected = memberState;
      });
    }
  }

  setMembershipActionState(MembershipActions action, bool selectedValue) {
    print(action);
    printStates();

    if (selectedValue == true && membershipSelected == true) {
      setStateValue(action, false, false);
    } else if (selectedValue == false && membershipSelected == false) {
      setStateValue(action, true, true);
    } else if (selectedValue == false && membershipSelected == true) {
      resetStates();
      setStateValue(action, true, true);
    }
  }

  printStates() {
    print('registerMemberSelected $registerMemberSelected');
    print('cancelMemberSelected: $cancelMemberSelected');
    print('membershipSelected: $membershipSelected');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  CircleAvatar(
                    radius: 70,
                    backgroundColor:
                        registerMemberSelected ? mainBlue : unselectedGray,
                    child: IconButton(
                      icon: Icon(
                        Icons.group_add,
                        size: 70,
                        color: registerMemberSelected
                            ? Colors.white
                            : Colors.black54,
                      ),
                      onPressed: () {
                        print('registerMemberSelected');
                        printStates();
                        setMembershipActionState(
                          MembershipActions.register,
                          registerMemberSelected,
                        );
                      },
                    ),
                  ),
                  IconTitleBox(title: "BECOME A MEMBER", overwriteSize: false),
                ],
              ),
              Column(
                children: [
                  CircleAvatar(
                    radius: 70,
                    backgroundColor:
                        cancelMemberSelected ? mainBlue : unselectedGray,
                    child: IconButton(
                      icon: Icon(
                        Icons.group_off,
                        size: 70,
                        color: cancelMemberSelected
                            ? Colors.white
                            : Colors.black54,
                      ),
                      onPressed: () {
                        print('cancelMemberSelected');
                        printStates();
                        setMembershipActionState(
                          MembershipActions.cancel,
                          cancelMemberSelected,
                        );
                      },
                    ),
                  ),
                  IconTitleBox(
                      title: "CANCEL MEMBERSHIP", overwriteSize: false),
                ],
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 40.0),
            child: SizedBox(
              width: 300,
              child: Text(
                'Please select one to continue',
                textAlign: TextAlign.center,
                softWrap: true,
                maxLines: 2,
                style: TextStyle(
                  fontFamily: 'Asap',
                  color: Colors.black54,
                  fontSize: 18,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 90,
          ),
          FilledButton(
            onPressed: () {
              if (membershipSelected == false) {
                showDialog(
                    context: context,
                    builder: (context) {
                      return SimpleDialog(
                        title: Text('Error'),
                        contentPadding: EdgeInsets.all(20),
                        children: [
                          Text('Please select one of the options to proceed')
                        ],
                      );
                    });
              } else if (registerMemberSelected) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: ((context) => MembershipSelectionView())));
              } else if (cancelMemberSelected) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: ((context) => CancelMembershipView())));
              }
            },
            style: ButtonStyle(
                minimumSize: MaterialStateProperty.all<Size>(Size(200, 50)),
                backgroundColor: MaterialStateProperty.all<Color>(mainBlue)),
            child: Text('CONFIRM'),
          ),
        ],
      ),
    );
  }
}

enum MembershipType { regular, student }

class MembershipTypeIcons extends StatefulWidget {
  const MembershipTypeIcons({super.key});

  @override
  State<MembershipTypeIcons> createState() => _MembershipTypeIconsState();
}

class _MembershipTypeIconsState extends State<MembershipTypeIcons> {
  bool memberTypeSelected = false;
  bool regularSelected = false;
  bool studentSelected = false;

  resetStates() {
    if (regularSelected) {
      setState(() {
        regularSelected = false;
      });
    } else if (studentSelected) {
      setState(() {
        studentSelected = false;
      });
    }
  }

  setTypeValue(MembershipType type, bool typeState, bool mainSelectState) {
    if (type == MembershipType.regular) {
      setState(() {
        regularSelected = typeState;
        memberTypeSelected = mainSelectState;
      });
    } else if (type == MembershipType.student) {
      setState(() {
        studentSelected = typeState;
        memberTypeSelected = mainSelectState;
      });
    }
  }

  setMembershipTypeState(MembershipType type, bool selectedValue) {
    print(type);
    printStates();

    if (selectedValue == true && memberTypeSelected == true) {
      setTypeValue(type, false, false);
    } else if (selectedValue == false && memberTypeSelected == false) {
      setTypeValue(type, true, true);
    } else if (selectedValue == false && memberTypeSelected == true) {
      resetStates();
      setTypeValue(type, true, true);
    }
  }

  printStates() {
    print('regularSelected $regularSelected');
    print('studentSelected: $studentSelected');
    print('memberTypeSelected: $memberTypeSelected');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  CircleAvatar(
                    radius: 70,
                    backgroundColor:
                        regularSelected ? mainBlue : unselectedGray,
                    child: IconButton(
                      icon: Icon(
                        Icons.groups,
                        size: 90,
                        color: regularSelected ? Colors.white : Colors.black54,
                      ),
                      onPressed: () {
                        print('registerMemberSelected');
                        printStates();
                        setMembershipTypeState(
                            MembershipType.regular, regularSelected);
                      },
                    ),
                  ),
                  IconTitleBox(title: "REGULAR", overwriteSize: false),
                ],
              ),
              Column(
                children: [
                  CircleAvatar(
                    radius: 70,
                    backgroundColor:
                        studentSelected ? mainBlue : unselectedGray,
                    child: IconButton(
                      icon: Icon(
                        Icons.groups,
                        size: 90,
                        color: studentSelected ? Colors.white : Colors.black54,
                      ),
                      onPressed: () {
                        print('studentSelected');
                        printStates();
                        setMembershipTypeState(
                            MembershipType.student, studentSelected);
                      },
                    ),
                  ),
                  IconTitleBox(title: "STUDENT", overwriteSize: false),
                ],
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 40.0),
            child: SizedBox(
              width: 300,
              child: Text(
                'Please select the type of membership',
                textAlign: TextAlign.center,
                softWrap: true,
                maxLines: 2,
                style: TextStyle(
                  fontFamily: 'Asap',
                  color: Colors.black54,
                  fontSize: 18,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 90,
          ),
          FilledButton(
            onPressed: () {
              if (memberTypeSelected == false) {
                showDialog(
                    context: context,
                    builder: (context) {
                      return SimpleDialog(
                        title: Text('Error'),
                        contentPadding: EdgeInsets.all(20),
                        children: [
                          Text('Please select one of the membership types')
                        ],
                      );
                    });
              } else if (regularSelected) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: ((context) =>
                            RegularMembershipSelectionView())));
              } else if (studentSelected) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: ((context) =>
                            StudentMembershipSelectionView())));
              }
            },
            style: ButtonStyle(
                minimumSize: MaterialStateProperty.all<Size>(Size(200, 50)),
                backgroundColor: MaterialStateProperty.all<Color>(mainBlue)),
            child: Text('CONFIRM'),
          ),
        ],
      ),
    );
  }
}

class MemberIconLarge extends StatelessWidget {
  final String membershipTitle;
  final VoidCallback onTap;

  const MemberIconLarge({
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
              height: 170,
              width: 170,
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  border: Border.all(width: 28, color: Colors.grey)),
              child: SizedBox(
                height: 150,
                width: 150,
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
                color: Color.fromARGB(255, 0, 74, 173),
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MemberIconSmall extends StatelessWidget {
  final String membershipTitle;
  final String membershipSubHeading;
  final VoidCallback onTap;

  const MemberIconSmall({
    super.key,
    required this.membershipTitle,
    required this.membershipSubHeading,
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
                color: Color.fromARGB(255, 0, 74, 173),
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
          SizedBox(
            width: 170,
            child: Text(
              membershipSubHeading,
              textAlign: TextAlign.center,
              softWrap: true,
              maxLines: 2,
              style: TextStyle(
                color: Colors.blue,
                fontSize: 15,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CheckBoxExample extends StatefulWidget {
  const CheckBoxExample({super.key});

  @override
  State<CheckBoxExample> createState() => _CheckboxExampleState();
}

class _CheckboxExampleState extends State<CheckBoxExample> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.blue;
      }
      return Colors.grey;
    }

    return Checkbox(
      checkColor: Colors.white,
      fillColor: MaterialStateProperty.resolveWith(getColor),
      value: isChecked,
      onChanged: (bool? value) {
        setState(() {
          isChecked = value!;
        });
      },
    );
  }
}

enum SingingCharacter { lafayette, jefferson }

class RadioExample extends StatefulWidget {
  const RadioExample({super.key});

  @override
  State<RadioExample> createState() => _RadioExampleState();
}

class _RadioExampleState extends State<RadioExample> {
  SingingCharacter? _character = SingingCharacter.lafayette;

  @override
  Widget build(BuildContext contxt) {
    return Column(
      children: <Widget>[
        ListTile(
          title: const Text('Lafayette'),
          leading: Radio<SingingCharacter>(
            value: SingingCharacter.lafayette,
            groupValue: _character,
            onChanged: (SingingCharacter? value) {
              setState(() {
                _character = value;
              });
            },
          ),
        ),
        ListTile(
          title: const Text('Thomas Jefferson'),
          leading: Radio<SingingCharacter>(
            value: SingingCharacter.jefferson,
            groupValue: _character,
            onChanged: (SingingCharacter? value) {
              setState(() {
                _character = value;
              });
            },
          ),
        ),
      ],
    );
  }
}

enum CancelReason { expensive, paymentMethod, unused, other }

class RadioCancellation extends StatefulWidget {
  const RadioCancellation({super.key});

  @override
  State<RadioCancellation> createState() => _RadioCancellationState();
}

class _RadioCancellationState extends State<RadioCancellation> {
  CancelReason? _cancelReasons = CancelReason.other;

  @override
  Widget build(BuildContext contxt) {
    return Padding(
      padding: const EdgeInsets.only(left: 25.0),
      child: Column(
        children: <Widget>[
          ListTile(
            title: const Text('Too Expensive'),
            leading: Radio<CancelReason>(
              value: CancelReason.expensive,
              groupValue: _cancelReasons,
              onChanged: (CancelReason? value) {
                setState(() {
                  _cancelReasons = value;
                });
              },
            ),
            visualDensity: VisualDensity(horizontal: 0, vertical: -4),
          ),
          ListTile(
            title: const Text('Payment Method'),
            leading: Radio<CancelReason>(
              value: CancelReason.paymentMethod,
              groupValue: _cancelReasons,
              onChanged: (CancelReason? value) {
                setState(() {
                  _cancelReasons = value;
                });
              },
            ),
            visualDensity: VisualDensity(horizontal: 0, vertical: -4),
          ),
          ListTile(
            title: const Text('Unused'),
            leading: Radio<CancelReason>(
              value: CancelReason.unused,
              groupValue: _cancelReasons,
              onChanged: (CancelReason? value) {
                setState(() {
                  _cancelReasons = value;
                });
              },
            ),
            visualDensity: VisualDensity(horizontal: 0, vertical: -3),
          ),
          ListTile(
            title: const Text('Other'),
            leading: Radio<CancelReason>(
              value: CancelReason.other,
              groupValue: _cancelReasons,
              onChanged: (CancelReason? value) {
                setState(() {
                  _cancelReasons = value;
                });
              },
            ),
            visualDensity: VisualDensity(horizontal: 0, vertical: -4),
          ),
        ],
      ),
    );
  }
}

class CancelMembershipView extends StatelessWidget {
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
      ),
      body: Column(
        children: [
          SizedBox(height: 20),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: TitleText(
              title: 'CANCEL MEMBERSHIP',
              isOverflow: false,
            ),
          ),
          MemberCancellationForm(),
        ],
      ),
    );
  }
}

class MemberCancellationForm extends StatefulWidget {
  const MemberCancellationForm({super.key});

  @override
  MemberCancellationState createState() {
    return MemberCancellationState();
  }
}

class MemberCancellationState extends State<MemberCancellationForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 20,
            ),
            SizedBox(
              width: 350,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: Text('Please choose the reason you are canceling'),
              ),
            ),
            RadioCancellation(),
            SizedBox(
              width: 350,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: TextFormField(
                  // TODO: only trigger validation if others is selected
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter reason';
                    } else if (value.length > 140) {
                      return 'Character Limit Error! Exceeds 140 Characters';
                    }
                    return null;
                  },
                  maxLines: 2,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(25.0)),
                    ),
                    hintText: 'Please write here (Maximum: 140 char)',
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 350,
              child: Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: FormHeadingText(
                  title: 'Suggestion',
                  textColor: Colors.deepPurple,
                ),
              ),
            ),
            SizedBox(
              width: 350,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: TextFormField(
                  maxLines: 2,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter suggestion';
                    } else if (value.length > 140) {
                      return 'Character Limit Error! Exceeds 140 Characters';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(25.0)),
                    ),
                    hintText: 'Please write here (Maximum: 140 char)',
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            FilledButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  // TODO: REST API
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: ((context) => DashboardPage()),
                    ),
                  );
                }
              },
              style: ButtonStyle(
                  minimumSize: MaterialStateProperty.all<Size>(Size(200, 50)),
                  backgroundColor: MaterialStateProperty.all<Color>(mainBlue)),
              child: Text('CONFIRM'),
            ),
          ],
        ),
      ),
    );
  }
}

class MembershipSelectionView extends StatelessWidget {
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
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 50,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: TitleText(
              title: 'MEMBERSHIP',
              isOverflow: false,
            ),
          ),
          SizedBox(
            height: 100,
          ),
          MembershipTypeIcons(),
        ],
      ),
    );
  }
}

class RegularMembershipSelectionView extends StatelessWidget {
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
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 50,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: TitleText(
              title: 'REGULAR',
              isOverflow: false,
            ),
          ),
          SizedBox(
            height: 50,
          ),
          RegularMembershipIcons(),
        ],
      ),
    );
  }
}

enum RegularMembershipType { contributing, life, sustaining, corporate }

class RegularMembershipIcons extends StatefulWidget {
  const RegularMembershipIcons({super.key});

  @override
  State<RegularMembershipIcons> createState() => _RegularMembershipIconsState();
}

class _RegularMembershipIconsState extends State<RegularMembershipIcons> {
  bool regMemSelected = false;
  bool contMemSelected = false;
  bool lifeMemSelected = false;
  bool susMemSelected = false;
  bool corpMemSelected = false;

  resetStates() {
    if (contMemSelected) {
      setState(() {
        contMemSelected = false;
      });
    } else if (lifeMemSelected) {
      setState(() {
        lifeMemSelected = false;
      });
    } else if (susMemSelected) {
      setState(() {
        susMemSelected = false;
      });
    } else if (corpMemSelected) {
      setState(() {
        corpMemSelected = false;
      });
    }
  }

  setStateValue(RegularMembershipType type, bool typeState, bool memberState) {
    if (type == RegularMembershipType.contributing) {
      setState(() {
        contMemSelected = typeState;
        regMemSelected = memberState;
      });
    } else if (type == RegularMembershipType.life) {
      setState(() {
        lifeMemSelected = typeState;
        regMemSelected = memberState;
      });
    } else if (type == RegularMembershipType.sustaining) {
      setState(() {
        susMemSelected = typeState;
        regMemSelected = memberState;
      });
    } else if (type == RegularMembershipType.corporate) {
      setState(() {
        corpMemSelected = typeState;
        regMemSelected = memberState;
      });
    }
  }

  setRegMemTypeState(RegularMembershipType type, bool selectedValue) {
    print(type);
    printStates();

    if (selectedValue == true && regMemSelected == true) {
      setStateValue(type, false, false);
    } else if (selectedValue == false && regMemSelected == false) {
      setStateValue(type, true, true);
    } else if (selectedValue == false && regMemSelected == true) {
      resetStates();
      setStateValue(type, true, true);
    }
  }

  printStates() {
    print('regMemSelected $regMemSelected');
    print('contMemSelected: $contMemSelected');
    print('lifeMemSelected: $lifeMemSelected');
    print('susMemSelected: $susMemSelected');
    print('corpMemSelected: $corpMemSelected');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  CircleAvatar(
                    radius: 70,
                    backgroundColor:
                        contMemSelected ? mainBlue : unselectedGray,
                    child: IconButton(
                      icon: Icon(
                        Icons.groups,
                        size: 90,
                        color: contMemSelected ? Colors.white : Colors.black54,
                      ),
                      onPressed: () {
                        print('contMemSelected');
                        printStates();
                        setRegMemTypeState(RegularMembershipType.contributing,
                            contMemSelected);
                      },
                    ),
                  ),
                  IconTitleBox(
                    title: "CONTRIBUTING",
                    overwriteSize: true,
                    fontSize: 20.0,
                  ),
                  IconSubheadingBox(title: "Professional"),
                ],
              ),
              Column(
                children: [
                  CircleAvatar(
                    radius: 70,
                    backgroundColor:
                        lifeMemSelected ? mainBlue : unselectedGray,
                    child: IconButton(
                      icon: Icon(
                        Icons.groups,
                        size: 90,
                        color: lifeMemSelected ? Colors.white : Colors.black54,
                      ),
                      onPressed: () {
                        print('lifeMemSelected');
                        printStates();
                        setRegMemTypeState(
                            RegularMembershipType.life, lifeMemSelected);
                      },
                    ),
                  ),
                  IconTitleBox(
                    title: "LIFE",
                    overwriteSize: true,
                    fontSize: 20.0,
                  ),
                  IconSubheadingBox(title: "Individual"),
                ],
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    CircleAvatar(
                      radius: 70,
                      backgroundColor:
                          susMemSelected ? mainBlue : unselectedGray,
                      child: IconButton(
                        icon: Icon(
                          Icons.groups,
                          size: 90,
                          color: susMemSelected ? Colors.white : Colors.black54,
                        ),
                        onPressed: () {
                          print('susMemSelected');
                          printStates();
                          setRegMemTypeState(
                              RegularMembershipType.sustaining, susMemSelected);
                        },
                      ),
                    ),
                    IconTitleBox(
                      title: "SUSTAINING",
                      overwriteSize: true,
                      fontSize: 20.0,
                    ),
                    IconSubheadingBox(title: "Government and Non-Government"),
                  ],
                ),
                Column(
                  children: [
                    CircleAvatar(
                      radius: 70,
                      backgroundColor:
                          corpMemSelected ? mainBlue : unselectedGray,
                      child: IconButton(
                        icon: Icon(
                          Icons.groups,
                          size: 90,
                          color:
                              corpMemSelected ? Colors.white : Colors.black54,
                        ),
                        onPressed: () {
                          print('corpMemSelected');
                          printStates();
                          setRegMemTypeState(
                              RegularMembershipType.corporate, corpMemSelected);
                        },
                      ),
                    ),
                    IconTitleBox(
                      title: "CORPORATE",
                      overwriteSize: true,
                      fontSize: 20.0,
                    ),
                    IconSubheadingBox(title: "Corporation and Big Companies"),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: 90,
          ),
          FilledButton(
            onPressed: () {
              if (regMemSelected == false) {
                showDialog(
                    context: context,
                    builder: (context) {
                      return SimpleDialog(
                        title: Text('Error'),
                        contentPadding: EdgeInsets.all(20),
                        children: [
                          Text('Please select one of the membership types')
                        ],
                      );
                    });
              } else if (contMemSelected) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: ((context) => ContributingMembershipForm())));
              } else if (lifeMemSelected) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: ((context) => LifeMembershipForm())));
              } else if (susMemSelected) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: ((context) => SustainingMembershipForm())));
              } else if (corpMemSelected) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: ((context) => CorporateMembershipForm())));
              }
            },
            style: ButtonStyle(
                minimumSize: MaterialStateProperty.all<Size>(Size(200, 50)),
                backgroundColor: MaterialStateProperty.all<Color>(mainBlue)),
            child: Text('SELECT'),
          ),
        ],
      ),
    );
  }
}

class StudentMembershipSelectionView extends StatelessWidget {
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
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 50,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: TitleText(
              title: 'STUDENT',
              isOverflow: false,
            ),
          ),
          SizedBox(
            height: 50,
          ),
          StudentMembershipIcons(),
        ],
      ),
    );
  }
}

enum StudentMembershipType { junior, senior, college }

class StudentMembershipIcons extends StatefulWidget {
  const StudentMembershipIcons({super.key});

  @override
  State<StudentMembershipIcons> createState() => _StudentMembershipIconsState();
}

class _StudentMembershipIconsState extends State<StudentMembershipIcons> {
  bool studMemSelected = false;
  bool junHighSelected = false;
  bool senHighSelected = false;
  bool collegeSelected = false;

  resetStates() {
    if (junHighSelected) {
      setState(() {
        junHighSelected = false;
      });
    } else if (senHighSelected) {
      setState(() {
        senHighSelected = false;
      });
    } else if (collegeSelected) {
      setState(() {
        collegeSelected = false;
      });
    }
  }

  setStateValue(StudentMembershipType type, bool typeState, bool memberState) {
    if (type == StudentMembershipType.junior) {
      setState(() {
        junHighSelected = typeState;
        studMemSelected = memberState;
      });
    } else if (type == StudentMembershipType.senior) {
      setState(() {
        senHighSelected = typeState;
        studMemSelected = memberState;
      });
    } else if (type == StudentMembershipType.college) {
      setState(() {
        collegeSelected = typeState;
        studMemSelected = memberState;
      });
    }
  }

  setStudentMemTypeState(StudentMembershipType type, bool selectedValue) {
    print(type);
    printStates();

    if (selectedValue == true && studMemSelected == true) {
      setStateValue(type, false, false);
    } else if (selectedValue == false && studMemSelected == false) {
      setStateValue(type, true, true);
    } else if (selectedValue == false && studMemSelected == true) {
      resetStates();
      setStateValue(type, true, true);
    }
  }

  printStates() {
    print('studMemSelected $studMemSelected');
    print('junHighSelected: $junHighSelected');
    print('senHighSelected: $senHighSelected');
    print('collegeSelected: $collegeSelected');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  CircleAvatar(
                    radius: 70,
                    backgroundColor:
                        junHighSelected ? mainBlue : unselectedGray,
                    child: IconButton(
                      icon: Icon(
                        Icons.groups,
                        size: 90,
                        color: junHighSelected ? Colors.white : Colors.black54,
                      ),
                      onPressed: () {
                        print('junHighSelected');
                        printStates();
                        setStudentMemTypeState(
                            StudentMembershipType.junior, junHighSelected);
                      },
                    ),
                  ),
                  IconTitleBox(
                      title: "JUNIOR HIGH SCHOOL", overwriteSize: false),
                ],
              ),
              Column(
                children: [
                  CircleAvatar(
                    radius: 70,
                    backgroundColor:
                        senHighSelected ? mainBlue : unselectedGray,
                    child: IconButton(
                      icon: Icon(
                        Icons.groups,
                        size: 90,
                        color: senHighSelected ? Colors.white : Colors.black54,
                      ),
                      onPressed: () {
                        print('senHighSelected');
                        printStates();
                        setStudentMemTypeState(
                            StudentMembershipType.senior, senHighSelected);
                      },
                    ),
                  ),
                  IconTitleBox(
                      title: "SENIOR HIGH SCHOOL", overwriteSize: false),
                ],
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    CircleAvatar(
                      radius: 70,
                      backgroundColor:
                          collegeSelected ? mainBlue : unselectedGray,
                      child: IconButton(
                        icon: Icon(
                          Icons.groups,
                          size: 90,
                          color:
                              collegeSelected ? Colors.white : Colors.black54,
                        ),
                        onPressed: () {
                          print('collegeSelected');
                          printStates();
                          setStudentMemTypeState(
                              StudentMembershipType.college, collegeSelected);
                        },
                      ),
                    ),
                    IconTitleBox(title: "COLLEGE", overwriteSize: false),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: 90,
          ),
          FilledButton(
            onPressed: () {
              if (studMemSelected == false) {
                showDialog(
                    context: context,
                    builder: (context) {
                      return SimpleDialog(
                        title: Text('Error'),
                        contentPadding: EdgeInsets.all(20),
                        children: [
                          Text('Please select one of the membership types')
                        ],
                      );
                    });
              } else if (junHighSelected) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: ((context) =>
                            JuniorHighSchoolMembershipForm())));
              } else if (senHighSelected) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: ((context) =>
                            SeniorHighSchoolMembershipForm())));
              } else if (collegeSelected) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: ((context) => CollegeMembershipForm())));
              }
            },
            style: ButtonStyle(
                minimumSize: MaterialStateProperty.all<Size>(Size(200, 50)),
                backgroundColor: MaterialStateProperty.all<Color>(mainBlue)),
            child: Text('SELECT'),
          ),
        ],
      ),
    );
  }
}

class ContributingMembershipForm extends StatelessWidget {
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
      ),
      body: MembershipForm(
        membershipType: 'CONTRIBUTING',
        membershipHeading: '1 Year',
        membershipOverview:
            'Become a part of the mental health promotion and support the cause of Mental Health\n\nHelp Sustain the mental health support we provide for indigent service users\n\nInvitation to PMHA events and activites exclusively for members\n\nReceive quarterly mailers about our recent events and activities',
        checkBoxHeading:
            'Pursuant to the Data Privacy Act of 2012, I hereby give my consent to PMHA to process my personal data\nas a member of the Association. I understand that the processing  of my personal data shall be limited to\nthe purpose specified.',
        amount: '₱300.00',
      ),
    );
  }
}

class LifeMembershipForm extends StatelessWidget {
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
      ),
      body: MembershipForm(
        membershipType: 'LIFE',
        membershipHeading: 'Lifetime',
        membershipOverview:
            'Become a part of the mental health promotion and support the cause of Mental Health\n\nHelp Sustain the mental health support we provide for indigent service users\n\nInvitation to PMHA events and activites exclusively for members\n\nReceive quarterly mailers about our recent events and activities',
        checkBoxHeading:
            'Pursuant to the Data Privacy Act of 2012, I hereby give my consent to PMHA to process my personal data\nas a member of the Association. I understand that the processing  of my personal data shall be limited to\nthe purpose specified.',
        amount: '₱3,000.00',
      ),
    );
  }
}

class SustainingMembershipForm extends StatelessWidget {
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
      ),
      body: MembershipForm(
        membershipType: 'SUSTAINING',
        membershipHeading: '1 Year',
        membershipOverview:
            'Become a part of the mental health promotion and support the cause of Mental Health\n\nHelp Sustain the mental health support we provide for indigent service users\n\nInvitation to PMHA events and activites exclusively for members\n\nReceive quarterly mailers about our recent events and activities',
        checkBoxHeading:
            'Pursuant to the Data Privacy Act of 2012, I hereby give my consent to PMHA to process my personal data\nas a member of the Association. I understand that the processing  of my personal data shall be limited to\nthe purpose specified.',
        amount: '₱3,000.00',
      ),
    );
  }
}

class CorporateMembershipForm extends StatelessWidget {
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
      ),
      body: MembershipForm(
        membershipType: 'CORPORATE',
        membershipHeading: '1 Year',
        membershipOverview:
            'Become a part of the mental health promotion and support the cause of Mental Health\n\nHelp Sustain the mental health support we provide for indigent service users\n\nInvitation to PMHA events and activites exclusively for members\n\nReceive quarterly mailers about our recent events and activities',
        checkBoxHeading:
            'Pursuant to the Data Privacy Act of 2012, I hereby give my consent to PMHA to process my personal data\nas a member of the Association. I understand that the processing  of my personal data shall be limited to\nthe purpose specified.',
        amount: '₱10,000.00',
      ),
    );
  }
}

class JuniorHighSchoolMembershipForm extends StatelessWidget {
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
      ),
      body: MembershipForm(
        membershipType: 'JUNIOR HIGH\nSCHOOL',
        membershipHeading: '1 Year',
        membershipOverview:
            'Become a part of the mental health promotion and support the cause of Mental Health\n\nHelp Sustain the mental health support we provide for indigent service users\n\nInvitation to PMHA events and activites exclusively for members\n\nReceive quarterly mailers about our recent events and activities',
        checkBoxHeading:
            'Pursuant to the Data Privacy Act of 2012, I hereby give my consent to PMHA to process my personal data\nas a member of the Association. I understand that the processing  of my personal data shall be limited to\nthe purpose specified.',
        amount: '₱20.00',
      ),
    );
  }
}

class SeniorHighSchoolMembershipForm extends StatelessWidget {
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
      ),
      body: MembershipForm(
        membershipType: 'SENIOR HIGH\nSCHOOL',
        membershipHeading: '1 Year',
        membershipOverview:
            'Become a part of the mental health promotion and support the cause of Mental Health\n\nHelp Sustain the mental health support we provide for indigent service users\n\nInvitation to PMHA events and activites exclusively for members\n\nReceive quarterly mailers about our recent events and activities',
        checkBoxHeading:
            'Pursuant to the Data Privacy Act of 2012, I hereby give my consent to PMHA to process my personal data\nas a member of the Association. I understand that the processing  of my personal data shall be limited to\nthe purpose specified.',
        amount: '₱50.00',
      ),
    );
  }
}

class CollegeMembershipForm extends StatelessWidget {
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
      ),
      body: MembershipForm(
        membershipType: 'COLLEGE',
        membershipHeading: '1 Year',
        membershipOverview:
            'Become a part of the mental health promotion and support the cause of Mental Health\n\nHelp Sustain the mental health support we provide for indigent service users\n\nInvitation to PMHA events and activites exclusively for members\n\nReceive quarterly mailers about our recent events and activities',
        checkBoxHeading:
            'Pursuant to the Data Privacy Act of 2012, I hereby give my consent to PMHA to process my personal data\nas a member of the Association. I understand that the processing  of my personal data shall be limited to\nthe purpose specified.',
        amount: '₱100.00',
      ),
    );
  }
}

class MembershipForm extends StatelessWidget {
  final String membershipType;
  final String membershipHeading;
  final String membershipOverview;
  final String checkBoxHeading;
  final String amount;

  const MembershipForm({
    super.key,
    required this.membershipType,
    required this.membershipHeading,
    required this.membershipOverview,
    required this.checkBoxHeading,
    required this.amount,
  });

  static const sidePad = 30.0;
  @override
  Widget build(BuildContext context) {
    var headingOverflow = (membershipType.length > 15) ? true : false;
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: TitleSubHeadingText(title: 'MEMBERSHIP'),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 100,
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: 8, vertical: headingOverflow ? 10 : 16),
              child: TitleText(
                title: membershipType,
                isOverflow: headingOverflow,
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: sidePad, right: sidePad),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: FormHeadingText(
                title: 'MEMBERSHIP PRIVILEGES',
                textColor: Colors.black,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: sidePad, right: sidePad),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Row(
                children: [
                  FormHeadingText(
                    title: '$membershipHeading ',
                    textColor: Colors.lightGreen,
                  ),
                  FormHeadingText(
                    title: 'Membership',
                    textColor: Color.fromARGB(255, 0, 74, 173),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(left: sidePad, right: sidePad, top: 10.0),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Text(
                membershipOverview,
                softWrap: true,
                maxLines: 10,
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 15,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: sidePad, right: sidePad),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    child: Text(
                      'Read more',
                      textAlign: TextAlign.right,
                      style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue),
                    ),
                    onPressed: () {/* ... */},
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: sidePad, right: sidePad),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: FormHeadingText(
                title: 'Payment',
                textColor: Color.fromARGB(255, 0, 74, 173),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: sidePad, right: sidePad),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Membership Fee',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                    ),
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10.0),
                        child: SizedBox(
                          width: 180,
                          height: 40,
                          child: TextField(
                            enabled: false,
                            decoration: InputDecoration(
                              isDense: true,
                              filled: true,
                              fillColor: Colors.grey,
                              border: OutlineInputBorder(),
                              labelText: amount,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10.0),
                        child: SizedBox(
                          width: 180,
                          height: 40,
                          child: TextField(
                            enabled: false,
                            decoration: InputDecoration(
                              isDense: true,
                              filled: true,
                              fillColor: Colors.grey,
                              border: OutlineInputBorder(),
                              label: Text(
                                'Select Payment Method',
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: sidePad, right: sidePad),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Row(
                children: [
                  CheckBoxExample(),
                  Text(
                    checkBoxHeading,
                    softWrap: true,
                    maxLines: 5,
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 5,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 25,
          ),
          FilledButton(
            onPressed: () {},
            style: ButtonStyle(
                minimumSize: MaterialStateProperty.all<Size>(Size(200, 50)),
                backgroundColor: MaterialStateProperty.all<Color>(
                    Color.fromARGB(255, 0, 74, 173))),
            child: Text('SUBMIT'),
          ),
        ],
      ),
    );
  }
}

class MembershipIntroPage extends StatelessWidget {
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
                  'MEMBERSHIP',
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
                  'Join us and be a mental health\nadvocate',
                  softWrap: true,
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 20,
                      color: Colors.deepPurple),
                ),
              ],
            ),
            SizedBox(height: 40),
            FilledButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: ((context) => MembershipView())));
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
