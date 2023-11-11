import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter_intro/ui_views/dashboard_messages.dart';
import 'package:flutter_intro/ui_views/book_appointment.dart';
import 'package:flutter_intro/ui_views/dashboard_views.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:flutter_intro/model/user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';
import 'package:flutter_intro/utils/colors_scheme.dart';

InputDecoration getFormDecor(String labelText) {
  return InputDecoration(
    contentPadding: EdgeInsets.only(left: 20, top: 5, right: 40),
    label: Text(labelText),
    labelStyle: TextStyle(
      fontFamily: 'Open Sans',
      color: primaryGrey,
      fontSize: 16,
    ),
    errorStyle: TextStyle(
      fontFamily: 'Open Sans',
      color: Colors.red,
      fontSize: 10,
    ),
  );
}

class ProfileTab extends StatefulWidget {
  const ProfileTab({super.key});

  @override
  _ProfileTabState createState() {
    return _ProfileTabState();
  }
}

class _ProfileTabState extends State<ProfileTab> {
  final _formKey = GlobalKey<FormState>();
  int _selectedIndex = 3;

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

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if (index == 0) {
        Navigator.push(context,
            MaterialPageRoute(builder: ((context) => DashboardPage())));
      } else if (index == 1) {
        Navigator.push(
            context, MaterialPageRoute(builder: ((context) => MessagesTab())));
      } else if (index == 2) {
        Navigator.push(context,
            MaterialPageRoute(builder: ((context) => AppointmentTab())));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraint) {
      const double appBarHeight = 80;
      const double botBarHeight = 60;
      double bodyHeight = constraint.maxHeight - 80 - 60;
      return PopScope(
        canPop: false,
        child: Form(
          key: _formKey,
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
              title: Text("PROFILE",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w900)),
              centerTitle: true,
            ),
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
                          style:
                              const TextStyle(fontSize: 18, color: Colors.red),
                        ),
                      );
                    } else if (snapshot.hasData) {
                      final data = snapshot.data;
                      String mystring = data.toString();
                      //Map<String, dynamic> myjson = jsonDecode(mystring);
                      User userdata = User.fromJson(jsonDecode(mystring));

                      return Container(
                        width: constraint.maxWidth,
                        height: bodyHeight,
                        child: EditProfileForm(
                            userData: userdata, formKey: _formKey),
                      );
                    }
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }),
            bottomNavigationBar: SizedBox(
              width: MediaQuery.sizeOf(context).width,
              height: botBarHeight,
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
        ),
      );
    });
  }
}

class EditProfileForm extends StatefulWidget {
  final User userData;
  final GlobalKey<FormState> formKey;

  const EditProfileForm(
      {super.key, required this.userData, required this.formKey});

  @override
  State<EditProfileForm> createState() =>
      _EditProfileFormState(userData: userData, formKey: formKey);
}

class _EditProfileFormState extends State<EditProfileForm> {
  final User userData;
  final GlobalKey<FormState> formKey;
  bool editEnabled = false;
  bool editPwEnabled = false;

  _EditProfileFormState({required this.userData, required this.formKey});

  Color getEnabledColor() {
    if (editEnabled) {
      return Colors.blueGrey.shade700;
    }
    return Colors.blue;
  }

  Color getPwEnabledColor() {
    if (editPwEnabled) {
      return Colors.blueGrey.shade700;
    }
    return Colors.blue;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraint) {
      const double formInputSize = 18;
      return Container(
        width: constraint.maxWidth,
        height: constraint.maxHeight,
        child: ListView(
          children: [
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 150,
                  child: CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.lightBlue.shade600,
                    child: Icon(
                      Icons.person,
                      size: 80,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 150,
                  child: TextButton(
                    child: Row(
                      children: [
                        Text(
                          'Edit Profile  ',
                          style: TextStyle(
                              fontFamily: 'Open Sans',
                              fontWeight: FontWeight.w900,
                              fontSize: 18,
                              color: getEnabledColor()),
                        ),
                        Icon(Icons.border_color, color: getEnabledColor()),
                      ],
                    ),
                    onPressed: () {
                      setState(() {
                        editEnabled = !editEnabled;
                      });
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Divider(),
            Row(
              children: [
                SizedBox(
                  width: constraint.maxWidth,
                  child: TextFormField(
                    textAlign: TextAlign.right,
                    style: TextStyle(
                        color: Colors.blueGrey.shade700,
                        fontSize: formInputSize),
                    decoration: getFormDecor("First Name"),
                    initialValue: userData.firstname,
                    enabled: editEnabled,
                    onSaved: (String? value) {
                      // This optional block of code can be used to run
                      // code when the user saves the form.
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "First name can't be empty";
                      }
                      return null;
                    },
                  ),
                ),
              ],
            ),
            Row(
              children: [
                SizedBox(
                  width: constraint.maxWidth,
                  child: TextFormField(
                    textAlign: TextAlign.right,
                    style: TextStyle(
                        color: Colors.blueGrey.shade700,
                        fontSize: formInputSize),
                    decoration: getFormDecor("Last Name"),
                    initialValue: userData.lastname,
                    enabled: editEnabled,
                    onSaved: (String? value) {
                      // This optional block of code can be used to run
                      // code when the user saves the form.
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Last name can't be empty";
                      }
                      return null;
                    },
                  ),
                ),
              ],
            ),
            Row(
              children: [
                SizedBox(
                  width: constraint.maxWidth,
                  child: TextFormField(
                    textAlign: TextAlign.right,
                    style: TextStyle(
                        color: Colors.blueGrey.shade700,
                        fontSize: formInputSize),
                    decoration: getFormDecor("Username"),
                    initialValue: " ",
                    enabled: editEnabled,
                    onSaved: (String? value) {
                      // This optional block of code can be used to run
                      // code when the user saves the form.
                    },
                    validator: (value) {
                      // if (value == null || value.isEmpty) {
                      //   return "Last name can't be empty";
                      // }
                      return null;
                    },
                  ),
                ),
              ],
            ),
            Row(
              children: [
                SizedBox(
                  width: constraint.maxWidth,
                  child: TextFormField(
                    textAlign: TextAlign.right,
                    style: TextStyle(
                        color: Colors.blueGrey.shade700,
                        fontSize: formInputSize),
                    decoration: getFormDecor("Email"),
                    readOnly: true,
                    initialValue: userData.email,
                    enabled: editEnabled,
                    keyboardType: TextInputType.emailAddress,
                    onSaved: (String? value) {
                      // This optional block of code can be used to run
                      // code when the user saves the form.
                    },
                    validator: (value) {
                      // if (value == null || value.isEmpty) {
                      //   return "Last name can't be empty";
                      // }
                      return null;
                    },
                  ),
                ),
              ],
            ),
            Row(
              children: [
                SizedBox(
                  width: constraint.maxWidth,
                  child: TextFormField(
                    textAlign: TextAlign.right,
                    style: TextStyle(
                        color: Colors.blueGrey.shade700,
                        fontSize: formInputSize),
                    decoration: getFormDecor("Mobile Number"),
                    initialValue: " ",
                    enabled: editEnabled,
                    keyboardType: TextInputType.phone,
                    onSaved: (String? value) {
                      // This optional block of code can be used to run
                      // code when the user saves the form.
                    },
                    validator: (value) {
                      // if (value == null || value.isEmpty) {
                      //   return "Last name can't be empty";
                      // }
                      return null;
                    },
                  ),
                ),
              ],
            ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     SizedBox(
            //       width: 150,
            //       child: CircleAvatar(
            //         radius: 70,
            //         backgroundColor: Colors.lightBlue.shade600,
            //         child: Icon(
            //           Icons.person,
            //           size: 100,
            //           color: Colors.white,
            //         ),
            //       ),
            //     ),
            //   ],
            // ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 220,
                  child: TextButton(
                    child: Row(
                      children: [
                        Text(
                          'Change Password  ',
                          style: TextStyle(
                              fontFamily: 'Open Sans',
                              fontWeight: FontWeight.w900,
                              fontSize: 18,
                              color: getPwEnabledColor()),
                        ),
                        Icon(Icons.border_color, color: getPwEnabledColor()),
                      ],
                    ),
                    onPressed: () {
                      setState(() {
                        editPwEnabled = !editPwEnabled;
                      });
                    },
                  ),
                ),
              ],
            ),
            Row(
              children: [
                SizedBox(
                  width: constraint.maxWidth,
                  child: TextFormField(
                    textAlign: TextAlign.right,
                    style: TextStyle(
                        color: Colors.blueGrey.shade700,
                        fontSize: formInputSize),
                    decoration: getFormDecor("Current Password"),
                    showCursor: true,
                    enabled: editPwEnabled,
                    onSaved: (String? value) {
                      // This optional block of code can be used to run
                      // code when the user saves the form.
                    },
                    validator: (value) {
                      if (editPwEnabled) {
                        if (value == null || value.isEmpty) {
                          return "Password can't be empty";
                        }
                      }
                      return null;
                    },
                  ),
                ),
              ],
            ),
            Row(
              children: [
                SizedBox(
                  width: constraint.maxWidth,
                  child: TextFormField(
                    textAlign: TextAlign.right,
                    style: TextStyle(
                        color: Colors.blueGrey.shade700,
                        fontSize: formInputSize),
                    decoration: getFormDecor("New Password"),
                    obscureText: true,
                    enabled: editPwEnabled,
                    onSaved: (String? value) {
                      // This optional block of code can be used to run
                      // code when the user saves the form.
                    },
                    validator: (value) {
                      if (editPwEnabled) {
                        if (value == null || value.isEmpty) {
                          return "Password can't be empty";
                        }
                      }
                      return null;
                    },
                  ),
                ),
              ],
            ),
            Row(
              children: [
                SizedBox(
                  width: constraint.maxWidth,
                  child: TextFormField(
                    textAlign: TextAlign.right,
                    style: TextStyle(
                        color: Colors.blueGrey.shade700,
                        fontSize: formInputSize),
                    decoration: getFormDecor("Confirm Password"),
                    obscureText: true,
                    enabled: editPwEnabled,
                    onSaved: (String? value) {
                      // This optional block of code can be used to run
                      // code when the user saves the form.
                    },
                    validator: (value) {
                      if (editPwEnabled) {
                        if (value == null || value.isEmpty) {
                          return "Password can't be empty";
                        }
                      }
                      return null;
                    },
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10.0, bottom: 10),
                  child: FilledButton(
                    onPressed: (editEnabled || editPwEnabled)
                        ? () {
                            if (formKey.currentState!.validate()) {}
                          }
                        : null,
                    style: ButtonStyle(
                        minimumSize:
                            MaterialStateProperty.all<Size>(Size(200, 40)),
                        backgroundColor: MaterialStateProperty.all<Color>(
                            (editEnabled || editPwEnabled)
                                ? Colors.tealAccent.shade700
                                : Colors.grey)),
                    child: Text(
                      'SAVE CHANGES',
                      style: TextStyle(
                          fontFamily: 'Open Sans', fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    });
  }
}
