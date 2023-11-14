import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

const FB_VIDEO_URL =
    "https://web.facebook.com/YouthLifeEnrichmentProgram/videos/385779920179224";

class VideoScreen extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    String html = '''
           <iframe width="200" height='200'
            src="https://www.facebook.com/v2.3/plugins/video.php? 
            allowfullscreen=false&autoplay=true&href=${FB_VIDEO_URL}" </iframe>
     ''';

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          toolbarHeight: 80,
          automaticallyImplyLeading: false,
          leading: SizedBox(
            width: 20,
            height: 20,
            child: Padding(
              padding: EdgeInsets.only(bottom: 3.0, left: 11.0),
              child: IconButton(
                icon: const Icon(
                  Icons.arrow_back,
                  size: 30,
                  color: Colors.black,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: MediaQuery.sizeOf(context).width,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                      child: SizedBox(
                          width: MediaQuery.sizeOf(context).width,
                          child: Text(
                            "Course: \nMaking the right choices",
                            style: TextStyle(
                                color: Colors.teal,
                                fontWeight: FontWeight.bold,
                                fontSize: 25),
                          )),
                    ),
                    Divider(),
                  ],
                ),
              ),
              HtmlWidget(
                html,
                //webView: true,
              ),
            ],
          ),
        ),
        // body: SingleChildScrollView(
        //   child: HtmlWidget(
        //     html,
        //     //webView: true,
        //   ),
        // ),
      ),
    );
  }
}
