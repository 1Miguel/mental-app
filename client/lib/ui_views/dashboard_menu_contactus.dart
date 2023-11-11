import 'package:flutter/material.dart';

class ContactCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String content;

  ContactCard({
    super.key,
    required this.icon,
    required this.title,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraint) {
      return Container(
        width: constraint.maxWidth,
        height: constraint.maxHeight,
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20.0),
              child: SizedBox(
                width: 50,
                height: 50,
                child: Icon(
                  icon,
                  size: 35,
                  color: Colors.teal,
                ),
              ),
            ),
            Container(
              width: constraint.maxWidth - 100,
              child: Padding(
                padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                        width: constraint.maxWidth,
                        child: Text(
                          title,
                          style: TextStyle(fontSize: 20),
                        )),
                    SizedBox(
                        width: constraint.maxWidth,
                        child: Text(
                          content,
                          style: TextStyle(color: Colors.grey.shade600),
                        )),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}

class ContactUs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraint) {
      const double appBarHeight = 80;
      const double botBarHeight = 60;
      double bodyHeight = constraint.maxHeight - appBarHeight - botBarHeight;
      return Scaffold(
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
          title: Text("CONTACT US",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.w900)),
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
        body: Container(
          width: constraint.maxWidth,
          height: constraint.maxHeight - appBarHeight,
          child: Column(
            children: [
              SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                child: SizedBox(
                    width: constraint.maxWidth - 40,
                    child: Text(
                        "Contact us through any of the following below for more information.",
                        style: TextStyle(
                            fontSize: 18, color: Colors.tealAccent.shade700))),
              ),
              SizedBox(height: 10),
              Divider(),
              Container(
                width: constraint.maxWidth,
                height: 80,
                child: ContactCard(
                    icon: Icons.phone, title: "Mobile", content: "09362855204"),
              ),
              Container(
                width: constraint.maxWidth,
                height: 80,
                child: ContactCard(
                    icon: Icons.mail,
                    title: "Email",
                    content: "pmhapalawan@pmha.org.ph"),
              ),
              Container(
                width: constraint.maxWidth,
                height: 90,
                child: ContactCard(
                    icon: Icons.place,
                    title: "Address",
                    content: "Puerto Princesa, Philippines,\n5300"),
              ),
              Container(
                width: constraint.maxWidth,
                height: 80,
                child: ContactCard(
                    icon: Icons.public,
                    title: "Websites and Social Links",
                    content: "https://www.pmha.org.ph"),
              ),
            ],
          ),
        ),
      );
    });
  }
}
