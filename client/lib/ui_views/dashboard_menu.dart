import 'package:flutter/material.dart';
import 'package:flutter_intro/ui_views/dashboard_menu_aboutus.dart';
import 'package:flutter_intro/ui_views/dashboard_menu_contactus.dart';
import 'package:flutter_intro/ui_views/dashboard_menu_settings.dart';
import 'package:flutter_intro/ui_views/login_views.dart';
import 'dart:convert';
import 'package:flutter_intro/utils/colors_scheme.dart';
import 'package:flutter_intro/model/user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';

class MenuTitleText extends StatelessWidget {
  final String menuText;

  const MenuTitleText({
    super.key,
    required this.menuText,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      menuText,
      style: TextStyle(
        color: primaryGrey,
        fontFamily: 'Roboto',
        fontWeight: FontWeight.w500,
        fontSize: 20,
      ),
    );
  }
}

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
    double newSize = (title.length > 20) ? 25 : 30;
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

class AccountDetaiiledSummaryCard extends StatelessWidget {
  final String name;
  final String image;
  final String details;

  const AccountDetaiiledSummaryCard({
    super.key,
    required this.name,
    required this.image,
    required this.details,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 130,
        child: Card(
          shape: RoundedRectangleBorder(
            side: BorderSide(
              color: Colors.white,
            ),
          ),
          elevation: 1,
          surfaceTintColor: Colors.grey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Row(
                children: [
                  SizedBox(
                    width: 90,
                    height: 120,
                    child: IconButton(
                      icon: Image.asset(image),
                      iconSize: 5.0,
                      onPressed: () {},
                    ),
                  ),
                  Column(
                    children: [
                      SizedBox(
                        width: MediaQuery.sizeOf(context).width - 100,
                        height: 70,
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.only(
                              top: 30,
                            ),
                            child: AccountNameHeadingText(
                              title: name,
                              isOverflow: true,
                              isHeavy: true,
                              customColor: mainDarkBlue,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.sizeOf(context).width - 100,
                        height: 50,
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 12.0),
                            child: Text(
                              details,
                              textAlign: TextAlign.left,
                              style:
                                  TextStyle(color: Colors.blue, fontSize: 20),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
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

class AccountsPage extends StatelessWidget {
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
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        automaticallyImplyLeading: false,
        flexibleSpace: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('images/bg_teal_hd.png'), fit: BoxFit.fill),
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.elliptical(50, 20),
                  bottomRight: Radius.elliptical(50, 20))),
        ),
        title: Text("MENU",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900)),
        centerTitle: true,
        leading: SizedBox(
          width: 20,
          height: 20,
          child: Padding(
            padding: EdgeInsets.only(bottom: 3.0, left: 11.0),
            child: IconButton(
              icon: Icon(
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
                    style: const TextStyle(fontSize: 18, color: Colors.red),
                  ),
                );
              } else if (snapshot.hasData) {
                final data = snapshot.data;
                String mystring = data.toString();
                User userdata = User.fromJson(jsonDecode(mystring));
                String firstname = userdata.firstname;
                String lastname = userdata.lastname;
                String email = userdata.email;

                return Column(
                  children: [
                    SizedBox(height: 20),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20.0), //or 15.0
                      child: Container(
                        height: 100.0,
                        width: 100.0,
                        color: bgTeal,
                        child: Icon(Icons.person, color: conTeal, size: 80.0),
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
                            style: TextStyle(fontSize: 20, color: primaryGrey),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Divider(),
                    AccountMenuTile(
                      menu: 'Address',
                      menuIcon: Icons.place,
                      onTap: () {},
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
                                builder: ((context) => Settings())));
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
                                builder: ((context) => ContactUs())));
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
                                builder: ((context) => AboutUs())));
                      },
                      bgColor: bgPurple,
                      conColor: conPurple,
                    ),
                    SizedBox(height: 210),
                    Divider(),
                    AccountMenuTile(
                      menu: 'Logout',
                      menuIcon: Icons.logout,
                      bgColor: bgRed,
                      conColor: conRed,
                      onTap: () async {
                        await getLogOutState();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: ((context) => LoginMainPage())));
                      },
                    ),
                  ],
                );
              }
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
  }
}
