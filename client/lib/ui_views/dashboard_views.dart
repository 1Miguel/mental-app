import 'package:flutter/material.dart';
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
            toolbarHeight: 120,
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
                        Icons.account_circle_rounded,
                        size: 70,
                        color: Colors.white,
                      ),
                      onPressed: () {},
                    ),
                  ),
                );
              },
            ),
            leadingWidth: 110,
            title: Text(
              'Hi, User!',
              style: TextStyle(
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  color: Colors.white),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.menu),
                iconSize: 40.0,
                color: Colors.white,
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => AccountsPage())));
                },
              ),
            ],
            bottom: AppBar(
                automaticallyImplyLeading: false,
                title: Container(
                  width: double.infinity,
                  height: 40,
                  color: Colors.deepPurple,
                  child: TextFormField(
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(left: 30.0),
                        hintText: 'Enter Keyword',
                        suffixIcon: Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                        ),
                        filled: true,
                        fillColor: Colors.white),
                  ),
                ),
                backgroundColor: Colors.deepPurple,
                actions: [Container()]),
          ),
          // Other Sliver Widgets
          SliverList(
            delegate: SliverChildListDelegate([
              const SizedBox(
                child: Column(
                  children: [
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
                          onPressed: () {},
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
                    color: Colors.blue,
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
                      fontFamily: 'Roboto', fontSize: 12, color: Colors.blue),
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
                            color: Colors.blue),
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
  final accountActions = const {
    'Membership':
        "Become a PMHA member to be part of our roster volunteers and professional and company partners. The membership fees also help sustain the mental health services for indigent service users and in the implementation of PMHA's programs and services.",
    'Donate':
        "With you as our partner, imagine what we can do together and how many more lives we can transform. With PMHA, donors and funders are not helping just another organization. They are a part of a worthy purpose of formulating new quality programs to respond to the changing times and ensure that mental health services.",
    'About Us':
        "Founded on January 15, 1950, the Philippine Mental Health Association, Inc. (PMHA) is a private, non-stock, non-profit organization that provides premier Mental Health Services through Education, Advocacy, Intervention and Research.",
  };

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
          AccountSummaryCard(
            name: "Katon, Benj",
            address: "Puerto Princesa, Palawan",
            age: "29 years. old",
            image: 'images/sample_cover_image.png',
          ),
          SizedBox(
            height: 20,
          ),
          for (MapEntry<String, String> action in accountActions.entries)
            AccountActionsCard(
              actionTitle: action.key,
              actionInfo: action.value,
              onPressed: () {
                action.key == 'Membership'
                    ? Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: ((context) => MembershipView())))
                    : {};
              },
            )
        ],
      ),
    );
  }
}

class AccountSummaryCard extends StatelessWidget {
  final String name;
  final String address;
  final String age;
  final String image;

  const AccountSummaryCard({
    super.key,
    required this.name,
    required this.address,
    required this.age,
    required this.image,
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
                    width: 200,
                    height: 100,
                    child: Container(
                      padding: EdgeInsets.only(
                          top: 10.0, left: 10.0, right: 10.0, bottom: 10.0),
                      color: Colors.white,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Katon Benj',
                            textAlign: TextAlign.left,
                            style: TextStyle(color: Colors.blue, fontSize: 25),
                          ),
                          Text(
                            'San Pedro, Puerto Princesa City Student 29, yo',
                            maxLines: 2,
                            softWrap: true,
                            textAlign: TextAlign.left,
                            style: TextStyle(color: Colors.blue, fontSize: 12),
                          ),
                        ],
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
