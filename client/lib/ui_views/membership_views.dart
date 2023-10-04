import 'package:flutter/material.dart';
import 'package:flutter_intro/ui_views/dashboard_views.dart';

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
        color: Color.fromARGB(255, 0, 74, 173),
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
            height: 100,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MemberIconLarge(
                membershipTitle: 'BECOME A MEMBER',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: ((context) => MembershipSelectionView()),
                    ),
                  );
                },
              ),
              MemberIconLarge(
                  membershipTitle: 'CANCEL MEMBERSHIP',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: ((context) => CancelMembershipView()),
                      ),
                    );
                  }),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 30.0),
            child: SizedBox(
              width: 300,
              child: Text(
                'Please select one to continue',
                textAlign: TextAlign.center,
                softWrap: true,
                maxLines: 2,
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 20,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 100,
          ),
          FilledButton(
            onPressed: () {},
            style: ButtonStyle(
                minimumSize: MaterialStateProperty.all<Size>(Size(200, 50)),
                backgroundColor: MaterialStateProperty.all<Color>(
                    Color.fromARGB(255, 0, 74, 173))),
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
                  backgroundColor: MaterialStateProperty.all<Color>(
                      Color.fromARGB(255, 0, 74, 173))),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MemberIconLarge(
                membershipTitle: 'REGULAR',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: ((context) => RegularMembershipSelectionView()),
                    ),
                  );
                },
              ),
              MemberIconLarge(
                  membershipTitle: 'STUDENT',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: ((context) =>
                            StudentMembershipSelectionView()),
                      ),
                    );
                  }),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 30.0),
            child: SizedBox(
              width: 300,
              child: Text(
                'Please select the type of Membership',
                textAlign: TextAlign.center,
                softWrap: true,
                maxLines: 2,
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 20,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 100,
          ),
          FilledButton(
            onPressed: () {},
            style: ButtonStyle(
                minimumSize: MaterialStateProperty.all<Size>(Size(200, 50)),
                backgroundColor: MaterialStateProperty.all<Color>(
                    Color.fromARGB(255, 0, 74, 173))),
            child: Text('CONFIRM'),
          ),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MemberIconSmall(
                membershipTitle: 'CONTRIBUTING',
                membershipSubHeading: 'Professional',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: ((context) => ContributingMembershipForm()),
                    ),
                  );
                },
              ),
              MemberIconSmall(
                membershipTitle: 'LIFE',
                membershipSubHeading: 'Individual',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: ((context) => LifeMembershipForm()),
                    ),
                  );
                },
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MemberIconSmall(
                membershipTitle: 'SUSTAINING',
                membershipSubHeading: 'Government and Non-Government',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: ((context) => SustainingMembershipForm()),
                    ),
                  );
                },
              ),
              MemberIconSmall(
                membershipTitle: 'CORPORATE',
                membershipSubHeading: 'Corporation and Big Companies',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: ((context) => CorporateMembershipForm()),
                    ),
                  );
                },
              ),
            ],
          ),
          SizedBox(
            height: 80,
          ),
          FilledButton(
            onPressed: () {},
            style: ButtonStyle(
                minimumSize: MaterialStateProperty.all<Size>(Size(200, 50)),
                backgroundColor: MaterialStateProperty.all<Color>(
                    Color.fromARGB(255, 0, 74, 173))),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MemberIconSmall(
                membershipTitle: 'JUNIOR HIGH SCHOOL',
                membershipSubHeading: '',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: ((context) => JuniorHighSchoolMembershipForm()),
                    ),
                  );
                },
              ),
              MemberIconSmall(
                membershipTitle: 'SENIOR HIGH SCHOOL',
                membershipSubHeading: '',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: ((context) => SeniorHighSchoolMembershipForm()),
                    ),
                  );
                },
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MemberIconSmall(
                membershipTitle: 'COLLEGE',
                membershipSubHeading: '',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: ((context) => CollegeMembershipForm()),
                    ),
                  );
                },
              ),
            ],
          ),
          SizedBox(
            height: 80,
          ),
          FilledButton(
            onPressed: () {},
            style: ButtonStyle(
                minimumSize: MaterialStateProperty.all<Size>(Size(200, 50)),
                backgroundColor: MaterialStateProperty.all<Color>(
                    Color.fromARGB(255, 0, 74, 173))),
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
