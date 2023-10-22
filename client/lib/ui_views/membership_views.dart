import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_intro/model/user.dart';
import 'package:flutter_intro/ui_views/dashboard_views.dart';
import 'package:flutter_intro/utils/colors_scheme.dart';
import 'package:image_picker/image_picker.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:checkbox_formfield/checkbox_formfield.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_intro/controllers/membership_controller.dart';
import 'package:get/get.dart';

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
        color: primaryBlue,
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
        color: primaryBlue,
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
            fontWeight: FontWeight.w400,
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

final TextStyle inputStyle = TextStyle(
  fontFamily: 'Open Sans',
  color: Colors.black87,
  fontSize: 13,
);

class InputDescription extends StatelessWidget {
  final String desc;

  const InputDescription({
    super.key,
    required this.desc,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width - 40,
      child: Text(
        desc,
        style: TextStyle(
          color: primaryGrey,
          fontWeight: FontWeight.bold,
          fontFamily: 'Open Sans',
        ),
      ),
    );
  }
}

InputDecoration getDecor(IconData icon) {
  return InputDecoration(
    suffixIcon: Icon(icon),
    filled: true,
    fillColor: Colors.white,
    contentPadding: EdgeInsets.only(left: 30.0),
    errorStyle: TextStyle(
      fontFamily: 'Open Sans',
      color: Colors.red,
      fontSize: 10,
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(30)),
      borderSide: BorderSide(
        color: Colors.grey,
        width: 1.0,
      ),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(30)),
      borderSide: BorderSide(
        color: HexColor('#90A4AE'),
        width: 1.0,
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(30)),
      borderSide: BorderSide(
        color: primaryLightBlue,
        width: 1.0,
      ),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(30)),
      borderSide: BorderSide(
        color: Colors.red,
        width: 1.0,
      ),
    ),
  );
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
    newSize = (title.length > 15) ? 25 : 30;
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

class MembershipView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        toolbarHeight: 60,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: <Color>[primaryLightBlue, primaryBlue]),
          ),
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
                  IconTitleBox(title: "REST \nA WHILE", overwriteSize: false),
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

enum MembershipType { individual, group }

class MembershipTypeIcons extends StatefulWidget {
  const MembershipTypeIcons({super.key});

  @override
  State<MembershipTypeIcons> createState() => _MembershipTypeIconsState();
}

class _MembershipTypeIconsState extends State<MembershipTypeIcons> {
  bool memberTypeSelected = false;
  bool individualSelected = false;
  bool groupSelected = false;

  resetStates() {
    if (individualSelected) {
      setState(() {
        individualSelected = false;
      });
    } else if (groupSelected) {
      setState(() {
        groupSelected = false;
      });
    }
  }

  setTypeValue(MembershipType type, bool typeState, bool mainSelectState) {
    if (type == MembershipType.individual) {
      setState(() {
        individualSelected = typeState;
        memberTypeSelected = mainSelectState;
      });
    } else if (type == MembershipType.group) {
      setState(() {
        groupSelected = typeState;
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
    print('regularSelected $individualSelected');
    print('studentSelected: $groupSelected');
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
                        individualSelected ? mainBlue : unselectedGray,
                    child: IconButton(
                      icon: Icon(
                        Icons.person,
                        size: 90,
                        color:
                            individualSelected ? Colors.white : Colors.black54,
                      ),
                      onPressed: () {
                        print('individualSelected');
                        printStates();
                        setMembershipTypeState(
                            MembershipType.individual, individualSelected);
                      },
                    ),
                  ),
                  IconTitleBox(title: "Individual", overwriteSize: false),
                ],
              ),
              Column(
                children: [
                  CircleAvatar(
                    radius: 70,
                    backgroundColor: groupSelected ? mainBlue : unselectedGray,
                    child: IconButton(
                      icon: Icon(
                        Icons.groups,
                        size: 90,
                        color: groupSelected ? Colors.white : Colors.black54,
                      ),
                      onPressed: () {
                        print('groupSelected');
                        printStates();
                        setMembershipTypeState(
                            MembershipType.group, groupSelected);
                      },
                    ),
                  ),
                  IconTitleBox(title: "Group", overwriteSize: false),
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
              } else if (individualSelected) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: ((context) =>
                            IndividualMembershipSelectionView())));
              } else if (groupSelected) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: ((context) =>
                            GroupMembershipSelectionView())));
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
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        toolbarHeight: 60,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: <Color>[primaryLightBlue, primaryBlue]),
          ),
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

class ContributingMembershipForm extends StatelessWidget {
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

class AssociateMembershipForm extends StatelessWidget {
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
      ),
      body: MembershipForm(
        membershipType: 'ASSOCIATE',
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

class StudentMembershipForm extends StatelessWidget {
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
      ),
      body: MembershipForm(
        membershipType: 'STUDENT',
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

class CorporateMembershipForm extends StatelessWidget {
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

class SustainingMembershipForm extends StatelessWidget {
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
      ),
      body: MembershipForm(
        membershipType: 'SUSTAINING',
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

class MembershipInfoForm extends StatelessWidget {
  final String amount;
  final String type;

  const MembershipInfoForm({
    super.key,
    required this.amount,
    required this.type,
  });

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
      ),
      body: MembershipPaymentForm(amount: amount, type: type),
    );
  }
}

class MembershipForm extends StatefulWidget {
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

  @override
  _MembershipFormState createState() {
    return _MembershipFormState(
      membershipType: membershipType,
      membershipHeading: membershipHeading,
      membershipOverview: membershipOverview,
      checkBoxHeading: checkBoxHeading,
      amount: amount,
    );
  }
}

class _MembershipFormState extends State<MembershipForm> {
  final String membershipType;
  final String membershipHeading;
  final String membershipOverview;
  final String checkBoxHeading;
  final String amount;
  bool agreementChecked = false;
  final _formKey = GlobalKey<FormState>();
  MembershipController membershipController = Get.put(MembershipController());

  _MembershipFormState({
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
      child: Form(
        key: _formKey,
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
              padding: const EdgeInsets.only(
                  left: sidePad, right: sidePad, top: 10.0),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Text(
                  membershipOverview,
                  softWrap: true,
                  maxLines: 12,
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                  ),
                ),
              ),
            ),
            SizedBox(height: 30),
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
                            fillColor: unselectedGray,
                            border: OutlineInputBorder(),
                            labelText: amount,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              width: MediaQuery.sizeOf(context).width - 35,
              child: CheckboxListTileFormField(
                title: Text(
                  "Pursuant to the Data Privacy Act of 2012, I hereby give my consent to PMHA to process my personal data as a member of the Association. I understand the processing of my personal data shall be limited to the purpose specified.",
                  softWrap: true,
                  maxLines: 5,
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 8,
                  ),
                ),
                initialValue: false,
                onSaved: (bool? value) {
                  print(value);
                },
                validator: (bool? value) {
                  if (value! && agreementChecked) {
                    return null;
                  } else {
                    return 'Please agree to policy before proceeding';
                  }
                },
                onChanged: (value) {
                  agreementChecked = true;
                  if (value) {
                    print("Agreement Checked :)");
                  } else {
                    print("Agreement Not Checked :(");
                  }
                },
                errorColor: Colors.red.shade300,
                checkColor: Colors.white,
                autovalidateMode: AutovalidateMode.disabled,
                contentPadding: EdgeInsets.all(1),
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.only(left: sidePad, right: sidePad),
            //   child: SizedBox(
            //     width: MediaQuery.of(context).size.width,
            //     child: Row(
            //       children: [
            //         CheckBoxExample(),
            //         Text(
            //           checkBoxHeading,
            //           softWrap: true,
            //           maxLines: 5,
            //           style: TextStyle(
            //             color: Colors.grey,
            //             fontSize: 5,
            //           ),
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
            SizedBox(
              height: 25,
            ),
            FilledButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: ((context) => MembershipInfoForm(
                            amount: amount,
                            type: membershipType,
                          )),
                    ),
                  );
                }
              },
              style: ButtonStyle(
                  minimumSize: MaterialStateProperty.all<Size>(Size(200, 50)),
                  backgroundColor:
                      MaterialStateProperty.all<Color>(primaryLightBlue)),
              child: Text('PAY NOW'),
            ),
          ],
        ),
      ),
    );
  }
}

class MembershipPaymentForm extends StatefulWidget {
  final String amount;
  final String type;

  const MembershipPaymentForm({
    super.key,
    required this.amount,
    required this.type,
  });

  @override
  _MembershipPaymentFormState createState() =>
      _MembershipPaymentFormState(amount: amount, type: type);
}

class _MembershipPaymentFormState extends State<MembershipPaymentForm> {
  final String amount;
  final String type;
  File? _image;
  final picker = ImagePicker();
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

  final _formKey = GlobalKey<FormState>();
  MembershipController membershipController = Get.put(MembershipController());

  getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString('user_data') ?? jsonEncode(emptyUser).toString();
  }

  _MembershipPaymentFormState({
    required this.amount,
    required this.type,
  });

  //Image Picker function to get image from gallery
  Future getImageFromGallery() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile == null) return;
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Container(
        width: MediaQuery.sizeOf(context).width,
        color: backgroundColor,
        child: FutureBuilder(
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
                  String email = userdata.email;
                  String address = userdata.address;
                  String mobile = userdata.contact_number;

                  return ListView(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                          child: TitleSubHeadingText(title: 'MEMBERSHIP'),
                        ),
                      ),
                      Divider(),
                      SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: Text(
                          'Personal Info',
                          style: TextStyle(
                              fontFamily: 'Asap',
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: primaryBlue),
                        ),
                      ),
                      SizedBox(height: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 5.0, left: 40.0),
                            child: InputDescription(desc: 'First Name'),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 40.0, right: 20.0),
                            child: SizedBox(
                              width: MediaQuery.sizeOf(context).width - 40.0,
                              child: TextFormField(
                                autofocus: false,
                                initialValue: firstname,
                                enabled: true,
                                decoration: const InputDecoration(
                                  icon: Icon(Icons.person),
                                ),
                                onSaved: (String? value) {
                                  // This optional block of code can be used to run
                                  // code when the user saves the form.
                                },
                                validator: (String? value) {
                                  return (value != null && value.contains('@'))
                                      ? 'Do not use the @ char.'
                                      : null;
                                },
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 5.0, left: 40.0),
                            child: InputDescription(desc: 'Last Name'),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 40.0, right: 20.0),
                            child: SizedBox(
                              width: MediaQuery.sizeOf(context).width - 40.0,
                              child: TextFormField(
                                autofocus: false,
                                initialValue: lastname,
                                enabled: true,
                                decoration: const InputDecoration(
                                  icon: Icon(Icons.person),
                                ),
                                onSaved: (String? value) {
                                  // This optional block of code can be used to run
                                  // code when the user saves the form.
                                },
                                validator: (String? value) {
                                  return (value != null && value.contains('@'))
                                      ? 'Do not use the @ char.'
                                      : null;
                                },
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 5.0, left: 40.0),
                            child: InputDescription(desc: 'Address'),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 40.0, right: 20.0),
                            child: SizedBox(
                              width: MediaQuery.sizeOf(context).width - 40.0,
                              child: TextFormField(
                                autofocus: false,
                                initialValue: address,
                                enabled: true,
                                decoration: const InputDecoration(
                                  icon: Icon(Icons.person),
                                ),
                                onSaved: (String? value) {
                                  // This optional block of code can be used to run
                                  // code when the user saves the form.
                                },
                                validator: (String? value) {
                                  return (value != null && value.contains('@'))
                                      ? 'Do not use the @ char.'
                                      : null;
                                },
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 5.0, left: 40.0),
                            child: InputDescription(desc: 'Contact Number'),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 40.0, right: 20.0),
                            child: SizedBox(
                              width: MediaQuery.sizeOf(context).width - 40.0,
                              child: TextFormField(
                                autofocus: false,
                                enabled: true,
                                initialValue: mobile,
                                decoration: const InputDecoration(
                                  //hintText: "Mobile Number",
                                  icon: Icon(Icons.person),
                                ),
                                onSaved: (String? value) {
                                  // This optional block of code can be used to run
                                  // code when the user saves the form.
                                },
                                validator: (String? value) {
                                  return (value != null && value.contains('@'))
                                      ? 'Do not use the @ char.'
                                      : null;
                                },
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 5.0, left: 40.0),
                            child: InputDescription(desc: 'Email Address'),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 40.0, right: 20.0),
                            child: SizedBox(
                              width: MediaQuery.sizeOf(context).width - 40.0,
                              child: TextFormField(
                                autofocus: true,
                                enabled: false,
                                initialValue: email,
                                decoration: const InputDecoration(
                                  icon: Icon(Icons.person),
                                ),
                                onSaved: (String? value) {
                                  // This optional block of code can be used to run
                                  // code when the user saves the form.
                                },
                                validator: (String? value) {
                                  return (value != null && value.contains('@'))
                                      ? 'Do not use the @ char.'
                                      : null;
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Divider(),
                      SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: Text(
                          'Membership Fee',
                          style: TextStyle(
                              fontFamily: 'Asap',
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: primaryBlue),
                        ),
                      ),
                      SizedBox(height: 15),
                      Row(children: [
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 40.0, bottom: 10),
                          child: SizedBox(
                            height: 30,
                            child: Row(
                              children: [
                                Text(
                                  'Amount',
                                  style: TextStyle(
                                      fontFamily: 'Roboto',
                                      fontSize: 15,
                                      color: Colors.black87),
                                ),
                                Text(
                                  ' * ',
                                  style: TextStyle(
                                      fontFamily: 'Roboto',
                                      fontSize: 15,
                                      color: Colors.red),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(bottom: 10.0, left: 10),
                          child: SizedBox(
                            width: 120,
                            height: 30,
                            child: TextField(
                              enabled: false,
                              decoration: InputDecoration(
                                isDense: true,
                                filled: true,
                                fillColor: unselectedGray,
                                border: OutlineInputBorder(),
                                labelText: amount,
                                disabledBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30)),
                                  borderSide: BorderSide(
                                    color: primaryLightBlue,
                                    width: 1.0,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ]),
                      SizedBox(height: 20),
                      Divider(),
                      SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: Text(
                          'Payment',
                          style: TextStyle(
                              fontFamily: 'Asap',
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: primaryBlue),
                        ),
                      ),
                      Row(
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 20.0, top: 5.0),
                            child: Text(
                              'Gcash/Bank Transfer',
                              style: TextStyle(
                                  fontFamily: 'Asap',
                                  fontSize: 14,
                                  color: mainLightGreen),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20.0),
                            child: SizedBox(
                              width: 180,
                              height: 34,
                              child: MaterialButton(
                                color: Colors.blue,
                                child: const Text("Upload from Gallery",
                                    style: TextStyle(
                                        color: Colors.white70,
                                        fontWeight: FontWeight.bold)),
                                onPressed: () {
                                  getImageFromGallery();
                                },
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                        ],
                      ),
                      Column(children: [
                        const SizedBox(
                          height: 20,
                          width: 30,
                        ),
                        _image != null
                            ? Image.file(
                                _image!,
                                width: 50,
                                height: 70,
                                fit: BoxFit.fitWidth,
                              )
                            : const Text('Please select an image'),
                      ]),
                      Divider(),
                      Column(
                        children: [
                          SizedBox(height: 50),
                          SizedBox(
                            width: 200,
                            child: FilledButton(
                              onPressed: () {
                                print("Register Membership");
                                print(type);
                                var memberType = 0;
                                if (type == "CONTRIBUTING") {
                                  memberType = 3;
                                } else if (type == "SUSTAINING") {
                                  memberType = 1;
                                } else if (type == "CORPORATE") {
                                  memberType = 2;
                                } else if (type == "STUDENT") {
                                  memberType = 4;
                                }
                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute(
                                //     builder: ((context) =>
                                //         MembershipSuccessPage()),
                                //   ),
                                // );
                                membershipController
                                    .registerMembership(memberType);
                              },
                              style: ButtonStyle(
                                  minimumSize: MaterialStateProperty.all<Size>(
                                      Size(200, 50)),
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          primaryLightBlue)),
                              child: Text('PAY NOW'),
                            ),
                          ),
                          SizedBox(height: 100),
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
      ),
    );
  }
}

class MembershipIntroPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: ((context) => DashboardPage()),
          ),
        );
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
                    'Membership',
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
                    'Join us and be a mental health advocate!',
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
                          builder: ((context) => MembershipView())));
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

class IndividualMembershipSelectionView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        toolbarHeight: 60,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: <Color>[primaryLightBlue, primaryBlue]),
          ),
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 50,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: TitleText(
              title: 'INDIVIDUAL',
              isOverflow: false,
            ),
          ),
          SizedBox(
            height: 50,
          ),
          IndividualMembershipIcons(),
        ],
      ),
    );
  }
}

enum IndividualMembershipType { contributing, associate, student }

class IndividualMembershipIcons extends StatefulWidget {
  const IndividualMembershipIcons({super.key});

  @override
  State<IndividualMembershipIcons> createState() =>
      _IndividualMembershipIconsState();
}

class _IndividualMembershipIconsState extends State<IndividualMembershipIcons> {
  bool indvMemSelected = false;
  bool contMemSelected = false;
  bool assocMemSelected = false;
  bool studMemSelected = false;

  resetStates() {
    if (contMemSelected) {
      setState(() {
        contMemSelected = false;
      });
    } else if (assocMemSelected) {
      setState(() {
        assocMemSelected = false;
      });
    } else if (studMemSelected) {
      setState(() {
        studMemSelected = false;
      });
    }
  }

  setStateValue(
      IndividualMembershipType type, bool typeState, bool memberState) {
    if (type == IndividualMembershipType.contributing) {
      setState(() {
        contMemSelected = typeState;
        indvMemSelected = memberState;
      });
    } else if (type == IndividualMembershipType.associate) {
      setState(() {
        assocMemSelected = typeState;
        indvMemSelected = memberState;
      });
    } else if (type == IndividualMembershipType.student) {
      setState(() {
        studMemSelected = typeState;
        indvMemSelected = memberState;
      });
    }
  }

  setIndivMemTypeState(IndividualMembershipType type, bool selectedValue) {
    print(type);
    printStates();

    if (selectedValue == true && indvMemSelected == true) {
      setStateValue(type, false, false);
    } else if (selectedValue == false && indvMemSelected == false) {
      setStateValue(type, true, true);
    } else if (selectedValue == false && indvMemSelected == true) {
      resetStates();
      setStateValue(type, true, true);
    }
  }

  printStates() {
    print('indvMemSelected $indvMemSelected');
    print('contMemSelected: $contMemSelected');
    print('assocMemSelected: $assocMemSelected');
    print('studMemSelected: $studMemSelected');
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
                        Icons.person,
                        size: 90,
                        color: contMemSelected ? Colors.white : Colors.black54,
                      ),
                      onPressed: () {
                        print('contMemSelected');
                        printStates();
                        setIndivMemTypeState(
                            IndividualMembershipType.contributing,
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
                        assocMemSelected ? mainBlue : unselectedGray,
                    child: IconButton(
                      icon: Icon(
                        Icons.person,
                        size: 90,
                        color: assocMemSelected ? Colors.white : Colors.black54,
                      ),
                      onPressed: () {
                        print('assocMemSelected');
                        printStates();
                        setIndivMemTypeState(IndividualMembershipType.associate,
                            assocMemSelected);
                      },
                    ),
                  ),
                  IconTitleBox(
                    title: "ASSOCIATE",
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
                          studMemSelected ? mainBlue : unselectedGray,
                      child: IconButton(
                        icon: Icon(
                          Icons.school,
                          size: 90,
                          color:
                              studMemSelected ? Colors.white : Colors.black54,
                        ),
                        onPressed: () {
                          print('studMemSelected');
                          printStates();
                          setIndivMemTypeState(IndividualMembershipType.student,
                              studMemSelected);
                        },
                      ),
                    ),
                    IconTitleBox(
                      title: "Student",
                      overwriteSize: true,
                      fontSize: 20.0,
                    ),
                    IconSubheadingBox(title: "High School and College"),
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
              if (indvMemSelected == false) {
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
              } else if (assocMemSelected) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: ((context) => AssociateMembershipForm())));
              } else if (studMemSelected) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: ((context) => StudentMembershipForm())));
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

class GroupMembershipSelectionView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        toolbarHeight: 60,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: <Color>[primaryLightBlue, primaryBlue]),
          ),
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 50,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: TitleText(
              title: 'GROUP',
              isOverflow: false,
            ),
          ),
          SizedBox(
            height: 50,
          ),
          GroupMembershipIcons(),
        ],
      ),
    );
  }
}

enum GroupMembershipType { sustaining, corporate }

class GroupMembershipIcons extends StatefulWidget {
  const GroupMembershipIcons({super.key});

  @override
  State<GroupMembershipIcons> createState() => _GroupMembershipIconsState();
}

class _GroupMembershipIconsState extends State<GroupMembershipIcons> {
  bool groupMemSelected = false;
  bool susMemSelected = false;
  bool corpMemSelected = false;

  resetStates() {
    if (susMemSelected) {
      setState(() {
        susMemSelected = false;
      });
    } else if (corpMemSelected) {
      setState(() {
        corpMemSelected = false;
      });
    }
  }

  setStateValue(GroupMembershipType type, bool typeState, bool memberState) {
    if (type == GroupMembershipType.sustaining) {
      setState(() {
        susMemSelected = typeState;
        groupMemSelected = memberState;
      });
    } else if (type == GroupMembershipType.corporate) {
      setState(() {
        corpMemSelected = typeState;
        groupMemSelected = memberState;
      });
    }
  }

  setRegMemTypeState(GroupMembershipType type, bool selectedValue) {
    print(type);
    printStates();

    if (selectedValue == true && groupMemSelected == true) {
      setStateValue(type, false, false);
    } else if (selectedValue == false && groupMemSelected == false) {
      setStateValue(type, true, true);
    } else if (selectedValue == false && groupMemSelected == true) {
      resetStates();
      setStateValue(type, true, true);
    }
  }

  printStates() {
    print('groupMemSelected $groupMemSelected');
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
                    backgroundColor: susMemSelected ? mainBlue : unselectedGray,
                    child: IconButton(
                      icon: Icon(
                        Icons.person,
                        size: 90,
                        color: susMemSelected ? Colors.white : Colors.black54,
                      ),
                      onPressed: () {
                        print('susMemSelected');
                        printStates();
                        setRegMemTypeState(
                            GroupMembershipType.sustaining, susMemSelected);
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
                        Icons.person,
                        size: 90,
                        color: corpMemSelected ? Colors.white : Colors.black54,
                      ),
                      onPressed: () {
                        print('corpMemSelected');
                        printStates();
                        setRegMemTypeState(
                            GroupMembershipType.corporate, corpMemSelected);
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
          SizedBox(
            height: 90,
          ),
          FilledButton(
            onPressed: () {
              if (groupMemSelected == false) {
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

class MembershipSuccessPage extends StatelessWidget {
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
                        title: "Thank you!",
                        isOverflow: true,
                        isHeavy: true,
                        customColor: mainLightGreen),
                  )
                ],
              ),
              SizedBox(height: 70),
              SizedBox(
                width: MediaQuery.sizeOf(context).width - 80,
                child: HeaderContentText(
                    title:
                        'Your payment request has been submitted. Please wait for our call (09362855204) between 2-3 business days for confirmation of payment.',
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
                child: Text('CONTINUE'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
