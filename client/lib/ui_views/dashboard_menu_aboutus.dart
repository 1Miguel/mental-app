import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:flutter_intro/utils/colors_scheme.dart';

class AboutUs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraint) {
      const double appBarHeight = 80;
      const double botBarHeight = 60;
      const double paddingHeight = 50;
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
          title: Text("ABOUT US",
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
          height: bodyHeight,
          child: Column(
            children: [
              SizedBox(height: paddingHeight),
              Image.asset(
                'images/pmha_logo.jpg',
                fit: BoxFit.fitHeight,
                height: bodyHeight / 3,
              ),
              SizedBox(height: paddingHeight),
              Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                child: SizedBox(
                    width: constraint.maxWidth - 60,
                    child: Text(
                        "Founded on January 15, 1950, the Philippine Mental Health Association, Inc. is a private, non-stock, non-profit organization that provides premier Mental Health Services through Education, Advocacy, Intervention and Research.",
                        softWrap: true,
                        maxLines: 10,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 18, color: Colors.grey.shade600))),
              ),
              SizedBox(height: paddingHeight),
              FilledButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => AboutUsCarousel())));
                },
                style: ButtonStyle(
                  minimumSize: MaterialStateProperty.all<Size>(Size(200, 50)),
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.teal),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      side: BorderSide(width: 2.0, color: loginDarkTeal),
                    ),
                  ),
                ),
                child: Text(
                  'KNOW MORE',
                  style: TextStyle(
                      fontFamily: 'Open Sans', fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}

class CarouselPage extends StatelessWidget {
  final String title;
  final String desc;

  CarouselPage({
    super.key,
    required this.title,
    required this.desc,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraint) {
      return Container(
        width: constraint.maxWidth,
        height: constraint.maxHeight,
        child: Column(
          children: [
            SizedBox(
                width: constraint.maxWidth,
                child: Padding(
                  padding:
                      const EdgeInsets.only(left: 30.0, right: 30.0, top: 20.0),
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.teal,
                    ),
                  ),
                )),
            SizedBox(
                width: constraint.maxWidth,
                child: Padding(
                  padding:
                      const EdgeInsets.only(left: 30.0, right: 30.0, top: 20.0),
                  child: Text(
                    desc,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade700,
                    ),
                  ),
                )),
          ],
        ),
      );
    });
  }
}

class AboutUsCarousel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraint) {
      const double appBarHeight = 80;
      const double botBarHeight = 60;
      const double paddingHeight = 50;
      return Scaffold(
        appBar: AppBar(
          //backgroundColor: Colors.teal,
          toolbarHeight: appBarHeight,
          automaticallyImplyLeading: false,
          flexibleSpace: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('images/bt_teal_about_hd.png'),
                  fit: BoxFit.fill),
              shape: BoxShape.rectangle,
              // borderRadius: BorderRadius.only(
              //     bottomLeft: Radius.elliptical(50, 20),
              //     bottomRight: Radius.elliptical(50, 20))),
            ),
          ),
          title: Text("ABOUT US",
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
          color: Colors.transparent,
          width: constraint.maxWidth,
          height: constraint.maxHeight,
          child: Column(
            children: [
              Container(
                width: constraint.maxWidth,
                height: constraint.maxHeight / 2,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('images/bt_teal_about_bod.png'),
                      fit: BoxFit.fill),
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.elliptical(50, 30),
                      bottomRight: Radius.elliptical(50, 30)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20.0),
                      child: Image.asset(
                        'images/pmha_logo_rembg.png',
                        fit: BoxFit.fitWidth,
                        width: constraint.maxWidth - 40,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Container(
                  height: (constraint.maxHeight / 4) + 20,
                  width: constraint.maxWidth,
                  child: ImageSlideshow(
                      indicatorColor: Colors.blue,
                      onPageChanged: (value) {
                        debugPrint('Page changed: $value');
                      },
                      isLoop: false,
                      children: [
                        CarouselPage(
                          title: "Vision",
                          desc:
                              "The Filipino people with the highest level of mental health.",
                        ),
                        CarouselPage(
                          title: "Mission",
                          desc:
                              "To promote mental health, prevent mental disorders, and inspire individuals to become mental health advocates.",
                        ),
                        CarouselPage(
                          title: "Advocacy",
                          desc:
                              "We will continue to enhance individual and collective well-being for a  mentally healthy",
                        ),
                      ]),
                  // child: SizedBox(
                  //     child: Padding(
                  //   padding:
                  //       const EdgeInsets.only(left: 30.0, right: 30.0, top: 20.0),
                  //   child: Text(
                  //     "Vision",
                  //     style: TextStyle(
                  //       fontSize: 30,
                  //       fontWeight: FontWeight.bold,
                  //       color: Colors.teal,
                  //     ),
                  //   ),
                  // )),
                ),
              ),
              // SizedBox(
              //     width: constraint.maxWidth,
              //     child: Padding(
              //       padding: const EdgeInsets.only(
              //           left: 30.0, right: 30.0, top: 20.0),
              //       child: Text(
              //         "The Filipino people with the highest level of mental health.",
              //         textAlign: TextAlign.center,
              //         style: TextStyle(
              //           fontSize: 20,
              //           fontWeight: FontWeight.bold,
              //           color: Colors.grey.shade700,
              //         ),
              //       ),
              //     )),
            ],
          ),
        ),
      );
    });
  }
}
