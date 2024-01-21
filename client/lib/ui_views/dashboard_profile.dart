import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_intro/controllers/change_password_controller.dart';
import 'package:flutter_intro/controllers/update_profile_controller.dart';
import 'package:flutter_intro/ui_views/dashboard_menu_aboutus.dart';
import 'package:flutter_intro/ui_views/dashboard_menu_contactus.dart';
import 'package:flutter_intro/ui_views/dashboard_menu_settings.dart';
import 'dart:convert';
import 'package:flutter_intro/ui_views/dashboard_messages.dart';
import 'package:flutter_intro/ui_views/book_appointment.dart';
import 'package:flutter_intro/ui_views/dashboard_profile_edit.dart';
import 'package:flutter_intro/ui_views/dashboard_views.dart';
import 'package:flutter_intro/ui_views/login_views.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:flutter_intro/model/user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';
import 'package:flutter_intro/utils/colors_scheme.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

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

class AccountMenuTile extends StatelessWidget {
  final String menu;
  final IconData menuIcon;
  final VoidCallback onTap;
  final Color bgColor;
  final Color conColor;

  const AccountMenuTile({
    super.key,
    required this.menu,
    required this.menuIcon,
    required this.onTap,
    required this.bgColor,
    required this.conColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListTile(
        contentPadding: EdgeInsets.only(left: 20.0, right: 30.0, top: 10.0),
        leading: CircleAvatar(
          backgroundColor: bgColor,
          radius: 20,
          child: Icon(menuIcon, size: 20, color: conColor),
        ),
        trailing: Icon(Icons.navigate_next, size: 20, color: Colors.grey),
        horizontalTitleGap: 30.0,
        title: MenuTitleText(menuText: menu),
        onTap: () {
          onTap();
        },
      ),
    );
  }
}

class ProfileTab extends StatefulWidget {
  const ProfileTab({super.key});
  @override
  _ProfileTabState createState() {
    return _ProfileTabState();
  }
}

class _ProfileTabState extends State<ProfileTab> {
  int _selectedIndex = 3;
  User emptyUser = User(
    id: 0,
    email: "",
    password_hash: "",
    firstname: "",
    lastname: "",
    username: "",
    address: "",
    age: 0,
    occupation: "",
    contact_number: "",
    status: "",
    dateCreated: "",
  );

  getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString('user_data') ?? jsonEncode(emptyUser).toString();
  }

  @override
  void initState() {
    getUserData();
    print("getUserData");
    super.initState();
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

  Future<void> getLogOutState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setBool('islogged_in', false);
    await prefs.remove("user_data");
    await prefs.remove("token");
    await prefs.remove("token_type");
    await prefs.remove("first_name");
    await prefs.remove("last_name");
    await prefs.remove("username");
    await prefs.remove("is_admin");
    await prefs.remove("is_super");
    await prefs.remove("isbanned");
  }

  @override
  Widget build(BuildContext context) {
    const double appBarHeight = 80;
    const double botBarHeight = 60;

    return LayoutBuilder(builder: (context, constraint) {
      double maxBodyHeight =
          constraint.maxHeight - (appBarHeight + botBarHeight + 30);
      return PopScope(
          canPop: false,
          child: Scaffold(
            appBar: AppBar(
              toolbarHeight: 80,
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
              title: Text("MENU",
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
                      User userdata = User.fromJson(jsonDecode(mystring));
                      String firstname = userdata.firstname;
                      String lastname = userdata.lastname;
                      String email = userdata.email;

                      return Container(
                        width: constraint.maxWidth,
                        height: maxBodyHeight,
                        child: Column(
                          children: [
                            Container(
                              width: constraint.maxWidth,
                              height: (maxBodyHeight / 3) * 2,
                              child: Column(
                                children: [
                                  SizedBox(height: 20),
                                  ClipRRect(
                                    borderRadius:
                                        BorderRadius.circular(20.0), //or 15.0
                                    child: Container(
                                      height: 100.0,
                                      width: 100.0,
                                      color: bgTeal,
                                      child: Icon(Icons.person,
                                          color: conTeal, size: 80.0),
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        width: MediaQuery.sizeOf(context).width,
                                        child: Text(
                                          "$firstname $lastname",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 20, color: primaryGrey),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 10),
                                  Divider(),
                                  AccountMenuTile(
                                    menu: 'Edit Profile',
                                    menuIcon: Icons.place,
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: ((context) =>
                                                  ProfileTabNew())));
                                    },
                                    bgColor: bgYellow,
                                    conColor: conYellow,
                                  ),
                                  AccountMenuTile(
                                    menu: 'Settings',
                                    menuIcon: Icons.settings,
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: ((context) =>
                                                  Settings())));
                                    },
                                    bgColor: bgGreen,
                                    conColor: conGreen,
                                  ),
                                  AccountMenuTile(
                                    menu: 'Contact Us',
                                    menuIcon: Icons.call,
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: ((context) =>
                                                  ContactUs())));
                                    },
                                    bgColor: bgPeachRed,
                                    conColor: conPeachRed,
                                  ),
                                  AccountMenuTile(
                                    menu: 'About Us',
                                    menuIcon: Icons.info,
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: ((context) =>
                                                  AboutUs())));
                                    },
                                    bgColor: bgPurple,
                                    conColor: conPurple,
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: constraint.maxWidth,
                              height: maxBodyHeight / 3,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Divider(),
                                  AccountMenuTile(
                                    menu: 'Logout',
                                    menuIcon: Icons.logout,
                                    bgColor: bgRed,
                                    conColor: conRed,
                                    onTap: () {
                                      getLogOutState();
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: ((context) =>
                                                  LoginMainPage())));
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
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
          ));
    });
  }
}

class EditProfileForm extends StatefulWidget {
  final User userData;
  final VoidCallback onPressed;

  EditProfileForm({
    super.key,
    required this.userData,
    required this.onPressed,
  });

  @override
  State<EditProfileForm> createState() => _EditProfileFormState(
        userData: userData,
        onPressed: onPressed,
      );
}

class _EditProfileFormState extends State<EditProfileForm> {
  final User userData;
  final VoidCallback onPressed;
  bool editEnabled = true;
  bool editPwEnabled = true;
  bool profileUpdated = false;
  final _formKey = GlobalKey<FormState>();
  final _formPwKey = GlobalKey<FormState>();
  UpdateProfileController updateProfileController =
      Get.put(UpdateProfileController());
  ChangePasswordController changePasswordController =
      Get.put(ChangePasswordController());
  String updFirstName = "";
  String updLastName = "";
  String updUserName = "";
  User emptyUser = User(
    id: 0,
    email: "",
    password_hash: "",
    firstname: "",
    lastname: "",
    username: "",
    address: "",
    age: 0,
    occupation: "",
    contact_number: "",
    status: "",
    dateCreated: "",
  );

  getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString('user_data');
  }

  _EditProfileFormState({required this.userData, required this.onPressed});

  Color getEnabledColor() {
    if (editEnabled) {
      return Colors.blueGrey.shade700;
    }
    return Colors.teal;
  }

  Color getSaveColor() {
    if (editEnabled) {
      return Colors.teal;
    }
    return Colors.blueGrey.shade700;
  }

  Color getPwEnabledColor() {
    if (editPwEnabled) {
      return Colors.blueGrey.shade700;
    }
    return Colors.teal;
  }

  Color getPwSaveColor() {
    if (editPwEnabled) {
      return Colors.teal;
    }
    return Colors.blueGrey.shade700;
  }

  // @override
  // void dispose() {
  //   super.dispose();
  //   // updateProfileController.firstNameController.clear();
  //   // updateProfileController.lastNameController.clear();
  //   // updateProfileController.userNameController.clear();
  // }

  @override
  void initState() {
    // User myData = getUserData();

    // updateProfileController.firstNameController.text = myData.firstname;
    // updateProfileController.lastNameController.text = myData.lastname;
    // updateProfileController.userNameController.text = myData.username;
    super.initState();
    //getValues();
  }

  // Future<void> getValues() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();

  //   if (prefs.containsKey('fistname')) {
  //     updateProfileController.firstNameController.text =
  //         prefs.getString('fistname') ?? userData.firstname;
  //   }

  //   if (prefs.containsKey('lastname')) {
  //     updateProfileController.lastNameController.text =
  //         prefs.getString('lastname') ?? userData.lastname;
  //   }

  //   if (prefs.containsKey('username')) {
  //     updateProfileController.userNameController.text =
  //         prefs.getString('username') ?? userData.username;
  //   }
  // }

  // Future<String?> getUserName() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String? name;

  //   if (prefs.containsKey('username')) {
  //     name = prefs.getString('username');
  //   }
  //   return name;
  // }

  // Future<String?> getFirstName() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String? name;

  //   if (prefs.containsKey('firstname')) {
  //     name = prefs.getString('firstname');
  //   }
  //   return name;
  // }

  // Future<String?> getLastName() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String? name;

  //   if (prefs.containsKey('lastname')) {
  //     name = prefs.getString('lastname');
  //   }
  //   return name;
  // }

  Future<void> getLogOutState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setBool('islogged_in', false);
    await prefs.remove("user_data");
    await prefs.remove("token");
    await prefs.remove("token_type");
    await prefs.remove("first_name");
    await prefs.remove("last_name");
    await prefs.remove("username");
    await prefs.remove("is_admin");
    await prefs.remove("is_super");
    await prefs.remove("isbanned");
    //await prefs.remove("islogged_in");
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
            Form(
              key: _formKey,
              child: Container(
                width: constraint.maxWidth,
                height: ((constraint.maxHeight) / 2),
                child: _buildFormData(context),
              ),
            ),
            Form(
              key: _formPwKey,
              child: Container(
                width: constraint.maxWidth,
                height: ((constraint.maxHeight) / 2) + 300,
                child: ListView(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: constraint.maxWidth,
                          child: Padding(
                            padding:
                                const EdgeInsets.only(left: 10.0, right: 10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                TextButton(
                                    child: Row(
                                      children: [
                                        Text(
                                          'Save Password',
                                          style: TextStyle(
                                              fontFamily: 'Open Sans',
                                              fontWeight: FontWeight.w900,
                                              fontSize: 18,
                                              color: getPwSaveColor()),
                                        ),
                                        Icon(Icons.border_color,
                                            color: getPwSaveColor()),
                                      ],
                                    ),
                                    onPressed: () async {
                                      if (_formPwKey.currentState!.validate()) {
                                        changePasswordController
                                            .changePassword();
                                        await getLogOutState();
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: ((context) =>
                                                    LoginMainPage())));
                                      }
                                    }),
                              ],
                            ),
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
                            controller:
                                changePasswordController.currentPassword,
                            showCursor: true,
                            obscureText: true,
                            enabled: true,
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
                            controller: changePasswordController.newPassword,
                            enabled: editPwEnabled,
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
                            controller:
                                changePasswordController.confirmPassword,
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
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget _buildFormData(BuildContext context) {
    const double formInputSize = 18;
    String initFirstName = "";
    String initLastName = "";
    String initUserName = "";
    return FutureBuilder(
        future: getUserData(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData) {
            final newData = snapshot.data;
            String mystring = newData.toString();
            User mapData = User.fromJson(jsonDecode(mystring));
            print("mapData ${mapData.firstname}");
            initFirstName = mapData.firstname;
            initLastName = mapData.lastname;
            initUserName = mapData.username;
            updateProfileController.firstNameController.text =
                mapData.firstname;
            updateProfileController.lastNameController.text = mapData.lastname;
            updateProfileController.userNameController.text = mapData.username;
            updateProfileController.emailController.text = mapData.email;
          }
          return ListView(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: MediaQuery.sizeOf(context).width,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            child: Row(
                              children: [
                                Text(
                                  'Save Profile',
                                  style: TextStyle(
                                      fontFamily: 'Open Sans',
                                      fontWeight: FontWeight.w900,
                                      fontSize: 18,
                                      color: getSaveColor()),
                                ),
                                Icon(Icons.border_color, color: getSaveColor()),
                              ],
                            ),
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                User updData =
                                    await updateProfileController.updateProfile(
                                        updFirstName, updLastName, updUserName);
                                updateProfileController.firstNameController
                                    .text = updData.firstname;
                                updateProfileController
                                    .lastNameController.text = updData.lastname;
                                updateProfileController
                                    .userNameController.text = updData.username;
                                updateProfileController.emailController.text =
                                    updData.email;
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text("User Profile Saved")));
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Divider(),
              Row(
                children: [
                  SizedBox(
                    width: MediaQuery.sizeOf(context).width,
                    child: TextFormField(
                        textAlign: TextAlign.right,
                        style: TextStyle(
                            color: Colors.blueGrey.shade700,
                            fontSize: formInputSize),
                        decoration: getFormDecor("First Name"),
                        initialValue:
                            updateProfileController.firstNameController.text,
                        enabled: true,
                        //controller: updateProfileController.firstNameController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "First name can't be empty";
                          }
                          return null;
                        },
                        onChanged: (value) {
                          setState(() {
                            updFirstName = value;
                          });
                        }),
                  ),
                ],
              ),
              Row(
                children: [
                  SizedBox(
                    width: MediaQuery.sizeOf(context).width,
                    child: TextFormField(
                        textAlign: TextAlign.right,
                        style: TextStyle(
                            color: Colors.blueGrey.shade700,
                            fontSize: formInputSize),
                        decoration: getFormDecor("Last Name"),
                        initialValue:
                            updateProfileController.lastNameController.text,
                        enabled: true,
                        //controller: updateProfileController.lastNameController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Last name can't be empty";
                          }
                          return null;
                        },
                        onChanged: (value) {
                          setState(() {
                            updLastName = value;
                          });
                        }),
                  ),
                ],
              ),
              Row(
                children: [
                  SizedBox(
                    width: MediaQuery.sizeOf(context).width,
                    child: TextFormField(
                        textAlign: TextAlign.right,
                        style: TextStyle(
                            color: Colors.blueGrey.shade700,
                            fontSize: formInputSize),
                        decoration: getFormDecor("Username"),
                        initialValue:
                            updateProfileController.userNameController.text,
                        enabled: true,
                        //controller: updateProfileController.userNameController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "username can't be empty";
                          }
                          return null;
                        },
                        onChanged: (value) {
                          setState(() {
                            updUserName = value;
                          });
                        }),
                  ),
                ],
              ),
              Row(
                children: [
                  SizedBox(
                    width: MediaQuery.sizeOf(context).width,
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
            ],
          );
        });
  }
}
