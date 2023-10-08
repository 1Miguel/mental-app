import 'package:flutter/material.dart';
import 'package:flutter_intro/ui_views/book_appointment.dart';
import 'package:flutter_intro/model/user.dart';
import 'package:flutter_intro/ui_views/login_views.dart';
import 'package:flutter_intro/utils/colors_scheme.dart';
import 'package:hexcolor/hexcolor.dart';
import 'membership_views.dart';

import 'dart:convert';

// Local import
import 'package:flutter_intro/ui_views/login_views.dart';

// Third-party import
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:get/get.dart';

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

class DashboardLoaderPage extends StatelessWidget {
  Future<String?> getUserName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? name = prefs.getString('first_name')!.toUpperCase();
    return name;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.deepPurpleAccent,
          title: const Text('Flutter FutureBuilder'),
        ),
        body: SizedBox(
          width: double.infinity,
          child: Center(
            child: FutureBuilder(
              future: getUserName(),
              initialData: "User",
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
                    return Center(
                      child: Text(
                        data ?? "HELLO",
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    );
                  }
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class DashboardPage extends StatelessWidget {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  Future<String?> getUserName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? name = prefs.getString('first_name');
    return name;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            floating: false,
            pinned: true,
            snap: false,
            centerTitle: false,
            toolbarHeight: 100,
            backgroundColor: Colors.deepPurple,
            leading: Builder(
              builder: (BuildContext context) {
                return SizedBox(
                  width: 20,
                  height: 20,
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 3.0, left: 11.0),
                    child: IconButton(
                      icon: const Icon(
                        Icons.menu,
                        size: 40.0,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: ((context) => AccountsPage())));
                      },
                    ),
                  ),
                );
              },
            ),
            leadingWidth: 80,
            actions: [
              FutureBuilder(
                future: getUserName(),
                initialData: null,
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
                      print(data);
                      return Padding(
                        padding: const EdgeInsets.only(right: 20.0),
                        child: Text(
                          'Hi, $data',
                          textAlign: TextAlign.end,
                          style: TextStyle(
                              fontFamily: 'Proza Libre',
                              fontWeight: FontWeight.bold,
                              fontSize: 30,
                              color: Colors.white),
                        ),
                      );
                    }
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            ],
          ),
          // Other Sliver Widgets
          SliverList(
            delegate: SliverChildListDelegate([
              SizedBox(
                child: Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: 40,
                      width: MediaQuery.sizeOf(context).width - 20,
                      child: TextFormField(
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(left: 30.0),
                            hintText: 'Enter Keyword',
                            suffixIcon: Icon(Icons.search),
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30)),
                            ),
                            filled: true,
                            fillColor: Colors.white),
                      ),
                    ),
                    SizedBox(
                      width: 380,
                      child: Padding(
                        padding: EdgeInsets.only(top: 10.0),
                        child: Text(
                          'Featured',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontFamily: 'Raleways',
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: mainDeepPurple),
                        ),
                      ),
                    ),
                    // SizedBox(
                    //   width: 380,
                    //   child: Text(
                    //     'Puerto Princesa, Palawan',
                    //     textAlign: TextAlign.left,
                    //     style: TextStyle(
                    //         fontFamily: 'Open Sans',
                    //         fontSize: 12,
                    //         color: mainDeepPurple),
                    //   ),
                    // ),
                    //SizedBox(height: 10, width: 380),
                    DashboardFeatureCarousel(),
                    // DashboardFeatureContext(
                    //     title:
                    //         'SECOND MENTAL HEALTH SUMMIT: "INCLUSIVITY AMIDST DIVERSITY"',
                    //     image: 'images/sample_cover_image.png',
                    //     content:
                    //         "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.',"),
                  ],
                ),
              ),
              Container(
                height: 500,
                color: Colors.white,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0, top: 20.0),
                          child: Text(
                            'Categories',
                            style: TextStyle(
                                fontFamily: 'Roboto',
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: mainDeepPurple),
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(right: 20.0, top: 20.0),
                          child: Text(
                            'Explore More',
                            style: TextStyle(
                                fontFamily: 'Roboto',
                                fontSize: 15,
                                color: mainDeepPurple),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        DashboardCategoryButtons(
                          title: 'Library',
                          imageIcon: 'images/dashboard_category_library.png',
                          icon: Icons.library_books,
                          onPressed: () {},
                        ),
                        DashboardCategoryButtons(
                          title: 'Mental Health Care',
                          imageIcon:
                              'images/dashboard_category_mental_health_care.png',
                          icon: Icons.psychology,
                          onPressed: () {},
                        ),
                        DashboardCategoryButtons(
                          title: 'Book Appointment',
                          imageIcon: 'images/dashboard_category_book.png',
                          icon: Icons.calendar_month,
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: ((context) =>
                                        BookAppointmentIntroPage())));
                          },
                        ),
                        DashboardCategoryButtons(
                          title: 'Talk To Us',
                          imageIcon: 'images/dashboard_category_talk.png',
                          icon: Icons.groups_2,
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}

class DashboardFeatureCarousel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 380,
      child: ImageSlideshow(
        indicatorColor: Colors.blue,
        onPageChanged: (value) {
          debugPrint('Page changed: $value');
        },
        autoPlayInterval: 3000,
        isLoop: true,
        children: [
          DashboardFeatureContext(
            title:
                'SECOND MENTAL HEALTH SUMMIT:\n"INCLUSIVITY AMIDST DIVERSITY"',
            image: 'images/sample_cover_image.png',
            content:
                "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.',",
          ),
          DashboardFeatureContext(
            title:
                'THIRD MENTAL HEALTH SUMMIT:\n"INCLUSIVITY AMIDST DIVERSITY"',
            image: 'images/sample_cover_image.png',
            content:
                "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.',",
          ),
        ],
      ),
    );
  }
}

class DashboardCategoryButtons extends StatelessWidget {
  final String imageIcon;
  final String title;
  final VoidCallback onPressed;
  final IconData icon;
  const DashboardCategoryButtons(
      {super.key,
      required this.title,
      required this.imageIcon,
      required this.icon,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: unselectedGray,
            child: IconButton(
              icon: Icon(
                icon,
                size: 30,
                color: Colors.black54,
              ),
              onPressed: () {
                onPressed();
              },
            ),
          ),
          SizedBox(
            width: 80,
            height: 50,
            child: Text(
              title,
              maxLines: 2,
              softWrap: true,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black54, fontSize: 12),
            ),
          )
        ],
      ),
    );
  }
}

class DashboardFeatureContext extends StatelessWidget {
  final String image;
  final String title;
  final String content;

  const DashboardFeatureContext({
    super.key,
    required this.title,
    required this.image,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: MediaQuery.sizeOf(context).width,
        height: 500,
        child: Card(
          surfaceTintColor: Colors.grey,
          child: Column(
            children: <Widget>[
              SizedBox(
                width: MediaQuery.sizeOf(context).width,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    title,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontFamily: 'Asap',
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: HexColor('#424242'),
                    ),
                  ),
                ),
              ),
              Image.asset(
                image,
                fit: BoxFit.fitHeight,
                height: 200,
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  content,
                  maxLines: 2,
                  softWrap: true,
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                      fontFamily: 'Asap',
                      fontSize: 12,
                      color: HexColor('#424242')),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 20.0),
                    child: TextButton(
                      child: Text(
                        'Read more',
                        textAlign: TextAlign.right,
                        style: TextStyle(
                            fontFamily: 'Open Sans',
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                      onPressed: () {/* ... */},
                    ),
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

class AccountsPage extends StatelessWidget {
  User emptyUser = User(
    id: 0,
    email: "",
    password_hash: "",
    firstname: "",
    lastname: "",
    address: "",
    age: 0,
    occupation: "",
  );

  getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString('user_data') ?? jsonEncode(emptyUser).toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
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
                //Map<String, dynamic> myjson = jsonDecode(mystring);
                User userdata = User.fromJson(jsonDecode(mystring));
                String firstname = userdata.firstname;
                String lastname = userdata.lastname;

                return Column(
                  children: [
                    AccountSummaryCard(
                      name: "$lastname, $firstname",
                      image: 'images/generic_user.png',
                      details: '',
                    ),
                    AccountMenuTile(
                      menu: 'Profile',
                      menuIcon: Icons.account_circle_rounded,
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: ((context) => AccountProfilePage())));
                      },
                    ),
                    AccountMenuTile(
                      menu: 'Membership',
                      menuIcon: Icons.badge,
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: ((context) => MembershipIntroPage())));
                      },
                    ),
                    AccountMenuTile(
                      menu: 'Donate',
                      menuIcon: Icons.volunteer_activism,
                      onTap: () {},
                    ),
                    AccountMenuTile(
                      menu: 'About Us',
                      menuIcon: Icons.diversity_3,
                      onTap: () {},
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

class AccountSummaryCard extends StatelessWidget {
  final String name;
  final String image;
  final String details;

  const AccountSummaryCard({
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
                      icon: Image.asset(image),
                      iconSize: 5.0,
                      onPressed: () {},
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.sizeOf(context).width - 100,
                    height: 120,
                    child: Center(
                      child: AccountNameHeadingText(
                        title: name,
                        isOverflow: true,
                        isHeavy: true,
                        customColor: mainBlue,
                      ),
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
                      icon: Image.asset(image),
                      iconSize: 5.0,
                      onPressed: () {},
                    ),
                  ),
                  Column(
                    children: [
                      SizedBox(
                        width: MediaQuery.sizeOf(context).width - 100,
                        height: 60,
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.only(
                              top: 20,
                            ),
                            child: AccountNameHeadingText(
                              title: name,
                              isOverflow: true,
                              isHeavy: true,
                              customColor: mainDeepPurple,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.sizeOf(context).width - 100,
                        height: 60,
                        child: Center(
                          child: Text(
                            details,
                            textAlign: TextAlign.left,
                            style: TextStyle(color: Colors.blue, fontSize: 20),
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

class AccountActionsCard extends StatelessWidget {
  final String actionTitle;
  final String actionInfo;
  final VoidCallback onPressed;

  const AccountActionsCard({
    super.key,
    required this.actionTitle,
    required this.actionInfo,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 225,
        child: Card(
          elevation: 0,
          surfaceTintColor: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Text(
                  actionTitle,
                  textAlign: TextAlign.left,
                  style: TextStyle(color: Colors.black, fontSize: 25),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width - 20,
                height: 130,
                child: Card(
                  elevation: 1,
                  surfaceTintColor: Colors.blueGrey,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      actionInfo,
                      textAlign: TextAlign.left,
                      style: TextStyle(color: Colors.black, fontSize: 12),
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 20.0),
                    child: FilledButton(
                      onPressed: () {
                        onPressed();
                      },
                      style: ButtonStyle(
                          minimumSize:
                              MaterialStateProperty.all<Size>(Size(100, 10)),
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Colors.deepPurple)),
                      child: Text('Next'),
                    ),
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
        color: mainDeepPurple,
        fontFamily: 'Roboto',
        fontWeight: FontWeight.w900,
        fontSize: 25,
      ),
    );
  }
}

class MenuSubTitleText extends StatelessWidget {
  final String menuText;

  const MenuSubTitleText({
    super.key,
    required this.menuText,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      menuText,
      style: TextStyle(
        color: Colors.deepPurple,
        fontFamily: 'Roboto',
        fontWeight: FontWeight.w500,
        fontSize: 24,
      ),
    );
  }
}

class AccountMenuTile extends StatelessWidget {
  final String menu;
  final IconData menuIcon;
  final VoidCallback onTap;

  const AccountMenuTile({
    super.key,
    required this.menu,
    required this.menuIcon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding:
          EdgeInsets.only(left: 50.0, right: 50.0, top: 10.0, bottom: 10.0),
      leading: Icon(menuIcon, size: 50.0),
      horizontalTitleGap: 30.0,
      title: MenuTitleText(menuText: menu),
      onTap: () {
        onTap();
      },
    );
  }
}

class AccountSubMenuTile extends StatelessWidget {
  final String menu;
  final IconData menuIcon;
  final VoidCallback onTap;

  const AccountSubMenuTile({
    super.key,
    required this.menu,
    required this.menuIcon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.only(
        left: 50.0,
        right: 50.0,
        top: 5.0,
      ),
      leading: Icon(menuIcon, size: 40.0),
      horizontalTitleGap: 30.0,
      title: MenuSubTitleText(menuText: menu),
      onTap: () {
        onTap();
      },
    );
  }
}

class AccountProfilePage extends StatelessWidget {
  User emptyUser = User(
    id: 0,
    email: "",
    password_hash: "",
    firstname: "",
    lastname: "",
    address: "",
    age: 0,
    occupation: "",
  );

  getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString('user_data') ?? jsonEncode(emptyUser).toString();
  }

  Future<String?> getLogOutState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? name = prefs.getString('first_name')!.toUpperCase();
    prefs.clear();
  }

  @override
  Widget build(BuildContext context) {
    //Image img = Image.asset('images/sample_cover_image.png');
    Image img = Image.asset('images/google_logo.png');
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
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
        title: Text(
          'Profile',
          style: const TextStyle(
            fontSize: 18,
            fontFamily: 'Roboto',
            color: Colors.deepPurple,
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
                //Map<String, dynamic> myjson = jsonDecode(mystring);
                User userdata = User.fromJson(jsonDecode(mystring));
                String firstname = userdata.firstname;
                String lastname = userdata.lastname;
                String email = userdata.email;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AccountDetaiiledSummaryCard(
                      name: "$lastname, $firstname",
                      image: "images/generic_user.png",
                      details: "$email",
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 50, right: 20, top: 15.0),
                      child: MenuTitleText(menuText: 'Information'),
                    ),
                    AccountSubMenuTile(
                      menu: 'Edit Profile',
                      menuIcon: Icons.edit_square,
                      onTap: () {},
                    ),
                    AccountSubMenuTile(
                      menu: 'Email',
                      menuIcon: Icons.mail_rounded,
                      onTap: () {},
                    ),
                    AccountSubMenuTile(
                      menu: 'Password',
                      menuIcon: Icons.lock,
                      onTap: () {},
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 50, right: 20, top: 15.0),
                      child: MenuTitleText(menuText: 'Account'),
                    ),
                    AccountSubMenuTile(
                      menu: 'Notifications',
                      menuIcon: Icons.notifications,
                      onTap: () {},
                    ),
                    AccountSubMenuTile(
                      menu: 'Switch Account',
                      menuIcon: Icons.sync_alt_outlined,
                      onTap: () {},
                    ),
                    AccountSubMenuTile(
                      menu: 'Logout',
                      menuIcon: Icons.logout,
                      onTap: () {
                        getLogOutState();
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
