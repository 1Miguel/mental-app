import 'package:comment_box/comment/comment.dart';
import 'package:flutter/material.dart';
import 'package:flutter_intro/utils/colors_scheme.dart';
import 'package:flutter_intro/model/thread.dart';
import 'package:flutter_intro/controllers/thread_controller.dart';
// Third-party import
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class TopicThread extends StatefulWidget {
  final int topicId;
  final String topicName;
  final String content;
  final bool isLiked;
  final int numLikes;
  final int numComments;

  const TopicThread({
    super.key,
    required this.topicId,
    required this.topicName,
    required this.content,
    required this.isLiked,
    required this.numLikes,
    required this.numComments,
  });

  @override
  _TopicThreadState createState() => _TopicThreadState(
        topicId: topicId,
        topicName: topicName,
        content: content,
        isLiked: isLiked,
        numLikes: numLikes,
        numComments: numComments,
      );
}

class _TopicThreadState extends State<TopicThread> {
  ThreadController threadController = Get.put(ThreadController());
  final formKey = GlobalKey<FormState>();
  final int topicId;
  final String topicName;
  final String content;
  final bool isLiked;
  final int numLikes;
  final int numComments;
  final TextEditingController commentController = TextEditingController();
  late Future<List<ThreadComment>> futureThreadComments;
  bool likeState = false;
  int likeNumState = 0;
  int commentState = 0;

  _TopicThreadState(
      {required this.topicId,
      required this.topicName,
      required this.content,
      required this.isLiked,
      required this.numLikes,
      required this.numComments});

  Future<List<ThreadComment>> getThreadComments() async {
    futureThreadComments = threadController.fetchThreadComments(topicId);
    print("topicId");
    print(topicId);
    print(futureThreadComments);
    return futureThreadComments;
  }

  @override
  void initState() {
    likeState = isLiked;
    likeNumState = numLikes;
    commentState = numComments;
    super.initState();
  }

  Widget buildComments(List<ThreadComment> comments) => ListView.builder(
        itemCount: comments.length,
        itemBuilder: (context, index) {
          final comment = comments[index];
          return Padding(
            padding: const EdgeInsets.fromLTRB(2.0, 8.0, 2.0, 0.0),
            child: ListTile(
              leading: GestureDetector(
                behavior: HitTestBehavior.opaque,
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
                  child: CircleAvatar(
                      minRadius: 25, child: Icon(Icons.eco, size: 25)),
                ),
              ),
              title: Text(
                "anonymous",
                style: TextStyle(fontWeight: FontWeight.bold, color: mainBlue),
              ),
              subtitle: Text(comment.content),
              trailing: Text("", style: TextStyle(fontSize: 10)),
            ),
          );
        },
      );

  @override
  void dispose() {
    threadController.commentController.clear();
    super.dispose();
  }

  String formatDate(String date) {
    String updStartTime =
        DateFormat('yyyy-MM-dd').format(DateTime.parse(date)).toString();
    return updStartTime;
  }

  Color getLikeColor() {
    if (likeState) {
      return Colors.red;
    }
    return primaryGrey;
  }

  @override
  Widget build(BuildContext context) {
    Image img = Image.asset('images/generic_user.png');
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        toolbarHeight: 60,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.elliptical(100, 20.0),
          ),
        ),
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
                Navigator.pop(context, [likeState, commentState]);
              },
            ),
          ),
        ),
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: CommentBox(
            userImage: img.image,
            labelText: 'Write a comment...',
            errorText: 'Comment cannot be blank',
            withBorder: false,
            sendButtonMethod: () {
              if (formKey.currentState!.validate()) {
                print(threadController.commentController.text);

                threadController.createComment(topicId);
                //threadController.commentController.clear();
                FocusScope.of(context).unfocus();
                setState(() {
                  commentState += 1;
                });
              } else {
                print("Not validated");
              }
            },
            formKey: formKey,
            commentController: threadController.commentController,
            backgroundColor: Colors.teal,
            textColor: Colors.white,
            sendWidget: Icon(Icons.send_sharp, size: 30, color: Colors.white),
            child: ListView(
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: CircleAvatar(
                          minRadius: 25, child: Icon(Icons.eco, size: 25)),
                    ),
                    Column(
                      children: [
                        SizedBox(
                          width: 200,
                          child: Padding(
                            padding:
                                const EdgeInsets.only(left: 20, right: 10.0),
                            child: Text(
                              "Anonymous",
                              style: TextStyle(
                                  fontFamily: 'Open Sans',
                                  fontSize: 25,
                                  fontWeight: FontWeight.normal,
                                  color: mainBlue),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 200,
                          child: Padding(
                            padding:
                                const EdgeInsets.only(left: 20, right: 10.0),
                            child: Text(
                              "2022-10-23",
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                color: primaryGrey,
                                fontWeight: FontWeight.normal,
                                fontFamily: 'Open Sans',
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 5.0, bottom: 0.0, left: 20, right: 10),
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
                          fontFamily: 'Roboto',
                          fontSize: 16,
                          color: primaryGrey),
                    ),
                  ),
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 25.0, bottom: 10),
                      child: Text(
                        commentState.toString(),
                        style: TextStyle(
                          color: primaryGrey,
                          fontWeight: FontWeight.bold,
                          fontSize: 10,
                          fontFamily: 'Asap',
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.comment,
                        size: 15.0,
                        color: primaryGrey,
                      ),
                      onPressed: () {},
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 25.0, bottom: 10),
                      child: Text(
                        likeNumState.toString(),
                        style: TextStyle(
                          color: primaryGrey,
                          fontWeight: FontWeight.bold,
                          fontSize: 10,
                          fontFamily: 'Asap',
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.favorite,
                        size: 15.0,
                        color: getLikeColor(),
                      ),
                      onPressed: () {
                        threadController.likeThread(topicId, !likeState);
                        setState(() {
                          if (likeState == false) {
                            likeNumState += 1;
                            likeState = true;
                          } else {
                            likeNumState -= 1;
                            likeState = false;
                          }
                        });
                      },
                    ),
                  ],
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
      ),
    );
  }
}
