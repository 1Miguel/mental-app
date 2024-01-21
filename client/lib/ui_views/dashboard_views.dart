import 'package:flutter/material.dart';
import 'package:flutter_intro/ui_views/calm.dart';
import 'package:flutter_intro/ui_views/dashboard_media.dart';
import 'package:flutter_intro/ui_views/dashboard_menu.dart';
import 'package:flutter_intro/ui_views/dashboard_messages.dart';
import 'package:flutter_intro/ui_views/dashboard_profile.dart';
import 'dart:convert';

// Local import
import 'package:flutter_intro/ui_views/login_views.dart';
import 'package:flutter_intro/ui_views/book_appointment.dart';
import 'package:flutter_intro/ui_views/mood_views.dart';
import 'package:flutter_intro/model/user.dart';
import 'package:flutter_intro/ui_views/talktous_views.dart';
import 'package:flutter_intro/ui_views/community_views.dart';
import 'package:flutter_intro/utils/colors_scheme.dart';
import 'membership_views.dart';

// Third-party import
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

class InputDescription extends StatelessWidget {
  final String desc;

  const InputDescription({
    super.key,
    required this.desc,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 80,
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

InputDecoration getDecor() {
  return InputDecoration(
    labelStyle: TextStyle(
      fontFamily: 'Open Sans',
      color: primaryBlue,
      fontSize: 10,
    ),
    errorStyle: TextStyle(
      fontFamily: 'Open Sans',
      color: Colors.red,
      fontSize: 10,
    ),
  );
}

class PasswordDescription extends StatelessWidget {
  final String desc;

  const PasswordDescription({
    super.key,
    required this.desc,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 120,
      child: Text(
        desc,
        style: TextStyle(
          color: primaryGrey,
          fontWeight: FontWeight.bold,
          fontFamily: 'Open Sans',
          fontSize: 12,
        ),
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
          // backgroundColor: primaryBlue,
          title: const Text('Flutter FutureBuilder'),
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: <Color>[primaryLightBlue, primaryBlue]),
            ),
          ),
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

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  _DashboardPageState createState() {
    return _DashboardPageState();
  }
}

class _DashboardPageState extends State<DashboardPage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  int _selectedIndex = 0;

  Future<String?> getUserName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? name = prefs.getString('first_name');
    return name;
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if (index == 1) {
        Navigator.push(
            context, MaterialPageRoute(builder: ((context) => MessagesTab())));
      } else if (index == 2) {
        Navigator.push(context,
            MaterialPageRoute(builder: ((context) => AppointmentTab())));
      } else if (index == 3) {
        Navigator.push(
            context, MaterialPageRoute(builder: ((context) => ProfileTab())));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        key: scaffoldKey,
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("images/bg_teal_bod.png"),
              fit: BoxFit.fill,
            ),
          ),
          child: CustomScrollView(
            slivers: [
              SliverAppBar(
                automaticallyImplyLeading: false,
                floating: false,
                pinned: true,
                snap: false,
                centerTitle: false,
                toolbarHeight: 80,
                flexibleSpace: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('images/bg_teal_hd.png'),
                        fit: BoxFit.fill),
                  ),
                ),
                title: FutureBuilder(
                  future: getUserName(),
                  initialData: null,
                  builder: (BuildContext context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: Colors.transparent,
                        ),
                      );
                    }
                    if (snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.hasError) {
                        return Center(
                          child: Text(
                            'An ${snapshot.error} occurred',
                            style: const TextStyle(
                                fontSize: 18, color: Colors.red),
                          ),
                        );
                      } else if (snapshot.hasData) {
                        final data = snapshot.data;
                        return Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Text(
                            'Hi, $data',
                            textAlign: TextAlign.end,
                            style: TextStyle(
                                fontFamily: 'Proza Libre',
                                fontWeight: FontWeight.w900,
                                fontSize: 30,
                                color: loginDarkTeal),
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
              // Other Sliver Widgets
              SliverList(
                delegate: SliverChildListDelegate([
                  Container(
                    decoration: BoxDecoration(
                        color: backgroundColor,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(50),
                          topLeft: Radius.circular(50),
                        )),
                    width: MediaQuery.sizeOf(context).width,
                    height: (MediaQuery.sizeOf(context).height - 150) / 2,
                    child: Column(
                      children: [
                        SizedBox(height: 10),
                        SizedBox(
                          width: 380,
                          height: 50,
                          child: Padding(
                            padding: EdgeInsets.only(top: 10.0, left: 15),
                            child: Text(
                              'Discover',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontFamily: 'Proza Libre',
                                  fontSize: 35,
                                  fontWeight: FontWeight.w900,
                                  color: Colors.teal),
                            ),
                          ),
                        ),
                        SizedBox(
                            width: MediaQuery.sizeOf(context).width,
                            height: ((MediaQuery.sizeOf(context).height - 150) /
                                    2) -
                                60,
                            child: DashboardDiscoverCarousel()),
                      ],
                    ),
                  ),
                  //SizedBox(height: 10),
                  Container(
                    height: 5,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: <Color>[
                            unselectedLightBlue,
                            Colors.blueAccent
                          ]),
                    ),
                  ),
                  Container(
                    width: MediaQuery.sizeOf(context).width,
                    height: (MediaQuery.sizeOf(context).height - 150) / 2,
                    color: Colors.white,
                    child: Column(
                      children: [
                        SizedBox(height: 10),
                        SizedBox(
                          width: 380,
                          height: 40,
                          child: Text(
                            'Featured',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontFamily: 'Proza Libre',
                                fontSize: 35,
                                fontWeight: FontWeight.w900,
                                color: HexColor("#5ce1e6")),
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.sizeOf(context).width,
                          height:
                              ((MediaQuery.sizeOf(context).height - 150) / 2) -
                                  80,
                          child: DashboardFeatureCarousel(),
                        ),
                        // Padding(
                        //   padding: const EdgeInsets.only(top: 10.0),
                        //   child: Row(
                        //     mainAxisAlignment: MainAxisAlignment.center,
                        //     children: [
                        //       DashboardCategoryButtons(
                        //         title: 'Talk To Us',
                        //         imageIcon: 'images/dashboard_category_talk.png',
                        //         icon: Icons.question_answer,
                        //         onPressed: () {
                        //           Navigator.push(
                        //               context,
                        //               MaterialPageRoute(
                        //                   builder: ((context) =>
                        //                       TalkToUsIntroPage())));
                        //         },
                        //       ),
                        //       DashboardCategoryButtons(
                        //         title: 'Discover',
                        //         imageIcon:
                        //             'images/dashboard_category_mental_health_care.png',
                        //         icon: Icons.psychology,
                        //         onPressed: () {
                        //           Navigator.push(
                        //               context,
                        //               MaterialPageRoute(
                        //                   builder: ((context) =>
                        //                       DiscoverIntroPage())));
                        //         },
                        //       ),
                        //       DashboardCategoryButtons(
                        //         title: 'Book Appointment',
                        //         imageIcon: 'images/dashboard_category_book.png',
                        //         icon: Icons.calendar_month,
                        //         onPressed: () {
                        //           Navigator.push(
                        //               context,
                        //               MaterialPageRoute(
                        //                   builder: ((context) =>
                        //                       BookAppointmentIntroPage())));
                        //         },
                        //       ),
                        //       DashboardCategoryButtons(
                        //         title: 'Membership',
                        //         imageIcon:
                        //             'images/dashboard_category_library.png',
                        //         icon: Icons.diversity_2,
                        //         onPressed: () {
                        //           Navigator.push(
                        //               context,
                        //               MaterialPageRoute(
                        //                   builder: ((context) =>
                        //                       MembershipIntroPage())));
                        //           // final datenow = DateTime.now();
                        //           // final later =
                        //           //     datenow.addf(const Duration(hours: 24));

                        //           // showDialog(
                        //           //     context: Get.context!,
                        //           //     builder: (context) {
                        //           //       return SimpleDialog(
                        //           //         title: Text('Error!'),
                        //           //         contentPadding: EdgeInsets.all(20),
                        //           //         children: [
                        //           //           Text(datenow.toString()),
                        //           //           Text(later.toString())
                        //           //         ],
                        //           //       );
                        //           //     });
                        //         },
                        //       ),
                        //     ],
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                ]),
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
  }
}

class DashboardDiscoverCarousel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraint) {
      return Container(
        height: constraint.maxHeight,
        child: ImageSlideshow(
          indicatorColor: Colors.blue,
          onPageChanged: (value) {
            debugPrint('Page changed: $value');
          },
          isLoop: false,
          children: [
            DashboardFeatureContext(
              title: 'FORUM',
              image: 'images/forum_dashboard.png',
              content:
                  "Share, discuss and exchange thoughts with other users related to a person's well-being.",
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: ((context) => CommunityIntroPage())));
              },
            ),
            DashboardFeatureContext(
              title: 'MEDIA',
              image: 'images/media_dashboard.png',
              content:
                  "Discover articles, videos, and infographics about mental health and mental wellbeing",
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: ((context) => DashboardMediaIntro())));
              },
            ),
            DashboardFeatureContext(
              title: 'MOOD',
              image: 'images/mood_dashboard.png',
              content:
                  "Keep track and understand your moods to help you manage them better.",
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: ((context) => MoodHistoryPage())));
              },
            ),
          ],
        ),
      );
    });
  }
}

class DashboardFeatureCarousel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraint) {
      return Container(
        height: constraint.maxHeight,
        child: ImageSlideshow(
          indicatorColor: Colors.blue,
          onPageChanged: (value) {
            debugPrint('Page changed: $value');
          },
          isLoop: false,
          children: [
            DashboardFeatureContext(
              title: 'CALM',
              image: 'images/calm_dashboard.png',
              content:
                  "Find wellness, peace, and balance using the app's guided meditation and mindfulness techniques.",
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: ((context) => Calm())));
              },
            ),
            DashboardFeatureContext(
              title: 'BOOK APPOINTMENT',
              image: 'images/book_dashboard.png',
              content:
                  "We will continue to enhance individual and collective well-being for a mentally healthy Philippines!",
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: ((context) => BookAppointmentIntroPage())));
              },
            ),
          ],
        ),
      );
    });
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
  final VoidCallback onTap;

  const DashboardFeatureContext({
    super.key,
    required this.title,
    required this.image,
    required this.content,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraint) {
      return Container(
        width: constraint.maxWidth,
        height: constraint.maxHeight,
        child: Column(
          //color: Colors.pink,
          // elevation: 0,
          children: <Widget>[
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                print("Clicked Forum");
                onTap();
              },
              child: SizedBox(
                width: constraint.maxWidth,
                height: (constraint.maxHeight / 4) * 3,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.asset(image),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 25.0, right: 20.0),
              child: SizedBox(
                  width: constraint.maxWidth,
                  height: constraint.maxHeight / 4,
                  child: Text(content, style: TextStyle(color: primaryGrey))),
            ),
          ],
        ),
      );
    });
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
                        customColor: mainDarkBlue,
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
        color: primaryGrey,
        fontFamily: 'Roboto',
        fontWeight: FontWeight.w500,
        fontSize: 20,
      ),
    );
  }
}

class ProfileHeadingText extends StatelessWidget {
  final String menuText;

  const ProfileHeadingText({
    super.key,
    required this.menuText,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      menuText,
      style: TextStyle(
        color: mainDarkBlue,
        fontFamily: 'Roboto',
        fontWeight: FontWeight.w900,
        fontSize: 22,
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
        color: mainLightPurple,
        fontFamily: 'Roboto',
        fontWeight: FontWeight.w900,
        fontSize: 18,
      ),
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
    return Container(
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(
        color: unselectedGray,
      ))),
      child: ListTile(
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
      ),
    );
  }
}

class EditProfilePage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
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

  bool isMobileNumberValid(String phoneNumber) {
    String regexPattern =
        r'((\+[0-9]{2})|0)[.\- ]?9[0-9]{2}[.\- ]?[0-9]{3}[.\- ]?[0-9]{4}';
    var regExp = RegExp(regexPattern);

    if (phoneNumber.length == 0) {
      return false;
    } else if (regExp.hasMatch(phoneNumber)) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    //Image img = Image.asset('images/sample_cover_image.png');
    Image img = Image.asset('images/google_logo.png');
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
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
        title: Text(
          'Edit Profile',
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            fontFamily: 'Roboto',
            color: Colors.white,
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
                print("Debug $mystring");
                User userdata = User.fromJson(jsonDecode(mystring));
                String firstname = userdata.firstname;
                String lastname = userdata.lastname;
                String email = userdata.email;
                String address = userdata.address;
                String contact_number = userdata.contact_number;

                return Container(
                  color: backgroundColor,
                  child: ListView(
                    children: [
                      Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Padding(
                                  padding:
                                      EdgeInsets.only(top: 5.0, left: 40.0),
                                  child: InputDescription(desc: 'First Name'),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 40.0, right: 20.0),
                                  child: SizedBox(
                                    width: 210,
                                    child: TextFormField(
                                      style: TextStyle(color: primaryBlue),
                                      decoration: getDecor(),
                                      initialValue: firstname,
                                      enabled: true,
                                      onSaved: (String? value) {
                                        // This optional block of code can be used to run
                                        // code when the user saves the form.
                                      },
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter your first name';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding:
                                      EdgeInsets.only(top: 5.0, left: 40.0),
                                  child: InputDescription(desc: 'Last Name'),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 40.0, right: 20.0),
                                  child: SizedBox(
                                    width: 210,
                                    child: TextFormField(
                                      style: TextStyle(color: primaryBlue),
                                      decoration: getDecor(),
                                      initialValue: lastname,
                                      enabled: true,
                                      onSaved: (String? value) {
                                        // This optional block of code can be used to run
                                        // code when the user saves the form.
                                      },
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter your last name';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding:
                                      EdgeInsets.only(top: 5.0, left: 40.0),
                                  child: InputDescription(desc: 'Address'),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 40.0, right: 20.0),
                                  child: SizedBox(
                                    width: 210,
                                    child: TextFormField(
                                      style: TextStyle(color: primaryBlue),
                                      decoration: getDecor(),
                                      initialValue: address,
                                      enabled: true,
                                      onSaved: (String? value) {
                                        // This optional block of code can be used to run
                                        // code when the user saves the form.
                                      },
                                      validator: (String? value) {
                                        return (value != null &&
                                                value.contains('@'))
                                            ? 'Do not use the @ char.'
                                            : null;
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding:
                                      EdgeInsets.only(top: 5.0, left: 40.0),
                                  child:
                                      InputDescription(desc: 'Mobile Number'),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 40.0, right: 20.0),
                                  child: SizedBox(
                                    width: 210,
                                    child: TextFormField(
                                      style: TextStyle(color: primaryBlue),
                                      decoration: getDecor(),
                                      initialValue: contact_number,
                                      enabled: true,
                                      onSaved: (String? value) {
                                        // This optional block of code can be used to run
                                        // code when the user saves the form.
                                      },
                                      // validator: (value) {
                                      //   if (value != null && value.isNotEmpty) {
                                      //     if (!isMobileNumberValid(
                                      //         contact_number)) {
                                      //       return 'Invalid Mobile Number format';
                                      //     }
                                      //   }
                                      //   return null;
                                      // },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding:
                                      EdgeInsets.only(top: 5.0, left: 40.0),
                                  child: InputDescription(desc: 'Email'),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 40.0, right: 20.0),
                                  child: SizedBox(
                                    width: 210,
                                    child: TextFormField(
                                      style: TextStyle(color: primaryGrey),
                                      decoration: getDecor(),
                                      initialValue: email,
                                      enabled: false,
                                      onSaved: (String? value) {
                                        // This optional block of code can be used to run
                                        // code when the user saves the form.
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            Container(
                              height: 4,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                    colors: <Color>[
                                      mainLightBlue,
                                      primaryBlue
                                    ]),
                              ),
                            ),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                Padding(
                                  padding:
                                      EdgeInsets.only(top: 5.0, left: 40.0),
                                  child: PasswordDescription(
                                      desc: 'Current Password'),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 15.0, right: 20.0),
                                  child: SizedBox(
                                    width: 200,
                                    child: TextFormField(
                                      obscureText: true,
                                      enabled: true,
                                      onSaved: (String? value) {
                                        // This optional block of code can be used to run
                                        // code when the user saves the form.
                                      },
                                      validator: (String? value) {
                                        return (value != null &&
                                                value.contains('@'))
                                            ? 'Do not use the @ char.'
                                            : null;
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding:
                                      EdgeInsets.only(top: 5.0, left: 40.0),
                                  child:
                                      PasswordDescription(desc: 'New Password'),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 15.0, right: 20.0),
                                  child: SizedBox(
                                    width: 200,
                                    child: TextFormField(
                                      obscureText: true,
                                      enabled: true,
                                      onSaved: (String? value) {
                                        // This optional block of code can be used to run
                                        // code when the user saves the form.
                                      },
                                      validator: (String? value) {
                                        return (value != null &&
                                                value.contains('@'))
                                            ? 'Do not use the @ char.'
                                            : null;
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding:
                                      EdgeInsets.only(top: 5.0, left: 40.0),
                                  child: PasswordDescription(
                                      desc: 'Re-enter Password'),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 15.0, right: 20.0),
                                  child: SizedBox(
                                    width: 200,
                                    child: TextFormField(
                                      obscureText: true,
                                      enabled: true,
                                      onSaved: (String? value) {
                                        // This optional block of code can be used to run
                                        // code when the user saves the form.
                                      },
                                      validator: (String? value) {
                                        return (value != null &&
                                                value.contains('@'))
                                            ? 'Do not use the @ char.'
                                            : null;
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 50),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                FilledButton(
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {}
                                  },
                                  style: ButtonStyle(
                                      minimumSize:
                                          MaterialStateProperty.all<Size>(
                                              Size(200, 50)),
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                              primaryLightBlue)),
                                  child: Text(
                                    'SAVE',
                                    style: TextStyle(
                                        fontFamily: 'Open Sans',
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
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
    );
  }
}
