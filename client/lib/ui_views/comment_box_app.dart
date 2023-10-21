import 'package:comment_box/comment/comment.dart';
import 'package:flutter/material.dart';
import 'package:flutter_intro/utils/colors_scheme.dart';
import 'package:flutter_intro/model/thread.dart';
import 'package:flutter_intro/controllers/thread_controller.dart';
// Third-party import
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';

class TopicThread extends StatefulWidget {
  final int topicId;
  final String topicName;
  final String content;

  const TopicThread({
    super.key,
    required this.topicId,
    required this.topicName,
    required this.content,
  });

  @override
  _TopicThreadState createState() => _TopicThreadState(
      topicId: topicId, topicName: topicName, content: content);
}

class _TopicThreadState extends State<TopicThread> {
  ThreadController threadController = Get.put(ThreadController());
  final formKey = GlobalKey<FormState>();
  final int topicId;
  final String topicName;
  final String content;
  final TextEditingController commentController = TextEditingController();
  late Future<List<ThreadComment>> futureThreadComments;

  _TopicThreadState({
    required this.topicId,
    required this.topicName,
    required this.content,
  });

  Future<List<ThreadComment>> getThreadComments() async {
    futureThreadComments = threadController.fetchThreadComments(topicId);
    print("topicId");
    print(topicId);
    print(futureThreadComments);
    return futureThreadComments;
  }

  Widget buildComments(List<ThreadComment> comments) => ListView.builder(
        itemCount: comments.length,
        itemBuilder: (context, index) {
          final comment = comments[index];
          return Padding(
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
                      color: primaryGrey,
                      borderRadius: new BorderRadius.all(Radius.circular(50))),
                  // child: CircleAvatar(
                  //   radius: 50,
                  //   //backgroundImage:
                  //   //    Image.asset(data[i]['pic'], fit: BoxFit.contain)
                  //   //        .image
                  // ),
                ),
              ),
              title: Text(
                comment.creator,
                style: TextStyle(fontWeight: FontWeight.bold, color: mainBlue),
              ),
              subtitle: Text(comment.content),
              trailing: Text("", style: TextStyle(fontSize: 10)),
            ),
          );
        },
      );

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
          labelText: 'Write a comment...',
          errorText: 'Comment cannot be blank',
          withBorder: false,
          sendButtonMethod: () {
            if (formKey.currentState!.validate()) {
              print(threadController.commentController.text);
              // setState(() {
              //   var post = {
              //     'creator': 'anonymous',
              //     'content': threadController.commentController.text,
              //     'date': DateTime.now().toString(),
              //   };
              //   //filedata.insert(0, value);
              // });
              threadController.createComment(topicId);
              //threadController.commentController.clear();
              FocusScope.of(context).unfocus();
            } else {
              print("Not validated");
            }
          },
          formKey: formKey,
          commentController: threadController.commentController,
          backgroundColor: primaryGrey,
          textColor: Colors.white,
          sendWidget: Icon(Icons.send_sharp, size: 30, color: Colors.white),
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    top: 0.0, bottom: 0.0, left: 20, right: 10),
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
                padding: const EdgeInsets.only(
                    top: 0.0, bottom: 0.0, left: 20, right: 10),
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
              SizedBox(
                  height: 800,
                  child: FutureBuilder<List<ThreadComment>>(
                      future: getThreadComments(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          final commentList = snapshot.data!;
                          return buildComments(commentList);
                        } else {
                          return const Text("No Comments");
                        }
                      })),
            ],
          ),
        ),
      ),
    );
  }
}
