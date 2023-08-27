import 'package:flutter/material.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
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
                onPressed: () {},
                tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
              ),
            ],
            bottom: AppBar(
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
            ),
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
