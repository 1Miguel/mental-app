import 'package:comment_box/comment/comment.dart';
import 'package:flutter/material.dart';
import 'package:flutter_intro/utils/colors_scheme.dart';

class TopicThread extends StatefulWidget {
  final String topicName;
  final String content;

  const TopicThread({
    super.key,
    required this.topicName,
    required this.content,
  });

  @override
  _TopicThreadState createState() =>
      _TopicThreadState(topicName: topicName, content: content);
}

class _TopicThreadState extends State<TopicThread> {
  final formKey = GlobalKey<FormState>();
  final String topicName;
  final String content;
  final TextEditingController commentController = TextEditingController();

  _TopicThreadState({required this.topicName, required this.content});

  List filedata = [
    {
      'name': 'Chuks Okwuenu',
      'pic': 'images/generic_user.png',
      'message': 'I love to code',
      'date': '2021-01-01 12:00:00'
    },
    {
      'name': 'Biggi Man',
      'pic': 'images/generic_user.png',
      'message': 'Very cool',
      'date': '2021-01-01 12:00:00'
    },
    {
      'name': 'Tunde Martins',
      'pic': 'images/generic_user.png',
      'message': 'Very cool',
      'date': '2021-01-01 12:00:00'
    },
    {
      'name': 'Biggi Man',
      'pic': 'images/generic_user.png',
      'message': 'Very cool',
      'date': '2021-01-01 12:00:00'
    },
  ];

  Widget commentChild(data) {
    return ListView(
      children: [
        Padding(
          padding:
              const EdgeInsets.only(top: 0.0, bottom: 0.0, left: 20, right: 10),
          child: SizedBox(
            width: MediaQuery.sizeOf(context).width,
            child: Text(
              topicName,
              style: TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87),
            ),
          ),
        ),
        Padding(
          padding:
              const EdgeInsets.only(top: 0.0, bottom: 0.0, left: 20, right: 10),
          child: SizedBox(
            width: MediaQuery.sizeOf(context).width,
            child: Text(
              content,
              style: TextStyle(
                  fontFamily: 'Roboto', fontSize: 16, color: primaryGrey),
            ),
          ),
        ),
        Divider(),
        for (var i = 0; i < data.length; i++)
          Padding(
            padding: const EdgeInsets.fromLTRB(2.0, 8.0, 2.0, 0.0),
            child: ListTile(
              leading: GestureDetector(
                onTap: () async {
                  // Display the image in large form.
                  print("Comment Clicked");
                },
                child: Container(
                  height: 50.0,
                  width: 50.0,
                  decoration: new BoxDecoration(
                      color: Colors.blue,
                      borderRadius: new BorderRadius.all(Radius.circular(50))),
                  child: CircleAvatar(
                      radius: 50,
                      backgroundImage:
                          Image.asset(data[i]['pic'], fit: BoxFit.contain)
                              .image),
                ),
              ),
              title: Text(
                data[i]['name'],
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(data[i]['message']),
              trailing: Text(data[i]['date'], style: TextStyle(fontSize: 10)),
            ),
          )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    Image img = Image.asset('images/generic_user.png');
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        toolbarHeight: 60,
        leading: SizedBox(
          width: 20,
          height: 20,
          child: Padding(
            padding: EdgeInsets.only(bottom: 3.0, left: 11.0),
            child: IconButton(
              icon: Icon(
                Icons.arrow_back,
                size: 30,
                color: primaryGrey,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ),
      ),
      body: Container(
        child: CommentBox(
          userImage: img.image,
          child: commentChild(filedata),
          labelText: 'Write a comment...',
          errorText: 'Comment cannot be blank',
          withBorder: false,
          sendButtonMethod: () {
            if (formKey.currentState!.validate()) {
              print(commentController.text);
              setState(() {
                var value = {
                  'name': 'New User',
                  'pic': 'images/generic_user.png',
                  'message': commentController.text,
                  'date': '2021-01-01 12:00:00'
                };
                filedata.insert(0, value);
              });
              commentController.clear();
              FocusScope.of(context).unfocus();
            } else {
              print("Not validated");
            }
          },
          formKey: formKey,
          commentController: commentController,
          backgroundColor: primaryGrey,
          textColor: Colors.white,
          sendWidget: Icon(Icons.send_sharp, size: 30, color: Colors.white),
        ),
      ),
    );
  }
}
