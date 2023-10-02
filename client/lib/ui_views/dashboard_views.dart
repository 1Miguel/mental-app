import 'package:flutter/material.dart';
import 'package:flutter_intro/ui_views/book_appointment.dart';
import 'membership_views.dart';

class DashboardPage extends StatelessWidget {
  final scaffoldKey = GlobalKey<ScaffoldState>();

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
              Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: Text(
                  'Hi, User!',
                  textAlign: TextAlign.end,
                  style: TextStyle(
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      color: Colors.white),
                ),
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
                      width: MediaQuery.sizeOf(context).width - 80,
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
                        padding: EdgeInsets.only(left: 10.0, top: 10.0),
                        child: Text(
                          'Featured',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontFamily: 'Roboto',
                              fontSize: 30,
                              color: Colors.black),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 380,
                      child: Padding(
                        padding: EdgeInsets.only(left: 10.0),
                        child: Text(
                          'Puerto Princesa, Palawan',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontFamily: 'Roboto',
                              fontSize: 15,
                              color: Colors.black),
                        ),
                      ),
                    ),
                    SizedBox(height: 10, width: 380),
                    DashboardFeatureContext(
                        title:
                            'SECOND MENTAL HEALTH SUMMIT: "INCLUSIVITY AMIDST DIVERSITY"',
                        image: 'images/sample_cover_image.png',
                        content:
                            "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.',"),
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
                                color: Colors.black),
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
                                color: Colors.black),
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
                          onPressed: () {},
                        ),
                        DashboardCategoryButtons(
                          title: 'Mental Health Care',
                          imageIcon:
                              'images/dashboard_category_mental_health_care.png',
                          onPressed: () {},
                        ),
                        DashboardCategoryButtons(
                          title: 'Book Appointment',
                          imageIcon: 'images/dashboard_category_book.png',
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

class DashboardCategoryButtons extends StatelessWidget {
  final String imageIcon;
  final String title;
  final VoidCallback onPressed;
  const DashboardCategoryButtons(
      {super.key,
      required this.title,
      required this.imageIcon,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 80,
            height: 100,
            child: IconButton(
              icon: Image.asset(imageIcon),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Pressed Follow on $title button"),
                    duration: const Duration(seconds: 1),
                  ),
                );
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
              style: TextStyle(color: Colors.blue, fontSize: 12),
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
        width: 380,
        height: 380,
        child: Card(
          surfaceTintColor: Colors.white,
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(
                    top: 10.0, left: 10.0, right: 10.0, bottom: 5.0),
                child: Text(
                  title,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
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
                      fontFamily: 'Roboto', fontSize: 12, color: Colors.black),
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
                            fontFamily: 'Roboto',
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
      body: Column(
        children: [
          AccountSummaryCard(
            name: "Katon, Benj",
            image: 'images/sample_cover_image.png',
            details: '',
          ),
          SizedBox(
            height: 20,
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
      ),
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
        height: 110,
        child: Card(
          elevation: 0,
          surfaceTintColor: Colors.white,
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 80,
                    height: 100,
                    child: IconButton(
                      icon: Image.asset('images/google_logo.png'),
                      iconSize: 5.0,
                      onPressed: () {},
                    ),
                  ),
                  SizedBox(
                    width: 250,
                    height: 100,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 15.0, right: 15.0, top: 5.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                name,
                                textAlign: TextAlign.left,
                                style:
                                    TextStyle(color: Colors.blue, fontSize: 40),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 15.0, right: 15.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                details,
                                textAlign: TextAlign.left,
                                style:
                                    TextStyle(color: Colors.blue, fontSize: 20),
                              ),
                            ],
                          ),
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
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content:
                                Text("Pressed Follow on $actionTitle button"),
                            duration: const Duration(seconds: 1),
                          ),
                        );
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
        color: const Color.fromARGB(255, 0, 74, 173),
        fontFamily: 'Roboto',
        fontWeight: FontWeight.w700,
        fontSize: 28,
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
        title: Text('Profile'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AccountSummaryCard(
            name: "Katon, Benj",
            image: "images/google_logo.png",
            details: "Benj@yahoo.com",
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 50, right: 20, top: 15.0),
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
            padding: const EdgeInsets.only(left: 50, right: 20, top: 15.0),
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
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
