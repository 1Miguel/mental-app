import 'package:flutter/material.dart';
import 'package:flutter_intro/controllers/thread_controller.dart';
import 'package:flutter_intro/model/thread.dart';
import 'package:intl/intl.dart';
import 'package:flutter_intro/utils/colors_scheme.dart';

class PostTitle extends StatelessWidget {
  final String title;

  const PostTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      textAlign: TextAlign.start,
      style: TextStyle(
        color: Colors.black87,
        fontWeight: FontWeight.normal,
        fontFamily: 'Asap',
        fontSize: 15,
      ),
    );
  }
}

class PostUser extends StatelessWidget {
  final String username;

  const PostUser({super.key, required this.username});

  @override
  Widget build(BuildContext context) {
    return Text(
      username,
      textAlign: TextAlign.start,
      style: TextStyle(
        color: mainBlue,
        fontWeight: FontWeight.normal,
        fontFamily: 'Open Sans',
        fontSize: 12,
      ),
    );
  }
}

class PostDate extends StatelessWidget {
  final String date;

  const PostDate({super.key, required this.date});

  @override
  Widget build(BuildContext context) {
    return Text(
      date,
      textAlign: TextAlign.start,
      style: TextStyle(
        color: Colors.grey,
        fontWeight: FontWeight.normal,
        fontFamily: 'Open Sans',
        fontSize: 10,
      ),
    );
  }
}

class PostContent extends StatelessWidget {
  final String content;

  const PostContent({super.key, required this.content});

  @override
  Widget build(BuildContext context) {
    return Text(
      content,
      textAlign: TextAlign.start,
      softWrap: true,
      maxLines: 3,
      style: TextStyle(
        color: primaryGrey,
        fontWeight: FontWeight.normal,
        fontFamily: 'Open Sans',
        fontSize: 12,
      ),
    );
  }
}

class PostCard extends StatefulWidget {
  final int id;
  final String title;
  final String username;
  final String content;
  final String date;
  final int numComment;
  final bool isLiked;
  final int numLikes;
  final VoidCallback onTap;

  PostCard({
    super.key,
    required this.id,
    required this.title,
    required this.username,
    required this.content,
    required this.date,
    required this.numComment,
    required this.isLiked,
    required this.numLikes,
    required this.onTap,
  });

  @override
  State<PostCard> createState() => _PostCardState(
        id: id,
        title: title,
        username: username,
        content: content,
        date: date,
        numComment: numComment,
        isLiked: isLiked,
        numLikes: numLikes,
        onTap: onTap,
      );
}

class _PostCardState extends State<PostCard> {
  final int id;
  final String title;
  final String username;
  final String content;
  final String date;
  final int numComment;
  final bool isLiked;
  final int numLikes;
  final VoidCallback onTap;
  ThreadController _threadController = ThreadController();
  bool likeState = false;
  int likeCommentState = 0;
  int commentState = 0;

  _PostCardState({
    required this.id,
    required this.title,
    required this.username,
    required this.content,
    required this.date,
    required this.numComment,
    required this.isLiked,
    required this.numLikes,
    required this.onTap,
  });

  @override
  void initState() {
    super.initState();
    setState(() {
      likeState = isLiked;
      likeCommentState = numLikes;
      commentState = numComment;
    });
  }

  String formatDate(String date) {
    String updStartTime =
        DateFormat('yyyy-MM-dd').format(DateTime.parse(date)).toString();
    return updStartTime;
  }

  Color getLikeColor() {
    if (likeState == true) {
      return Colors.red;
    }
    return Colors.grey;
  }

  @override
  Widget build(BuildContext context) {
    print("PostCard Date: $date");
    return LayoutBuilder(
      builder: (context, constraint) {
        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () async {
            // List result = await Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //     maintainState: false,
            //     builder: ((context) => TopicThread(
            //           topicId: id,
            //           topicName: title,
            //           content: content,
            //           isLiked: likeState,
            //           numLikes: likeCommentState,
            //           numComments: commentState,
            //         )),
            //     //maintainState: false,
            //   ),
            // );

            // setState(() {
            //   print("Results ${result[0]}, ${result[1]}");
            //   print("Comment State: $commentState");
            //   if (result[0] != likeState) {
            //     if (result[0] == true) {
            //       likeState = true;
            //       likeCommentState += 1;
            //     } else {
            //       likeState = false;
            //       likeCommentState -= 1;
            //     }
            //   } else if (result[1] != commentState) {
            //     commentState = result[1];
            //   }
            //   print("Set State: {$likeState}");
            //   //likeState = isLiked;
            //   // likeCommentState = numLikes;
            //   // commentState = numComment;
            // });
          },
          child: Container(
            width: constraint.maxWidth,
            child: Card(
              elevation: 0.0,
              surfaceTintColor: Colors.teal,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 10.0, bottom: 0.0, right: 10.0, left: 10.0),
                    child: Row(
                      children: [
                        SizedBox(
                          width: constraint.maxWidth - 30,
                          child: Padding(
                            padding:
                                const EdgeInsets.only(left: 10.0, right: 10.0),
                            child: PostTitle(title: title),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 20.0, right: 10.0, top: 2),
                    child: Row(
                      children: [
                        CircleAvatar(
                            minRadius: 15, child: Icon(Icons.eco, size: 13)),
                        Column(
                          children: [
                            SizedBox(
                              width: 100,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 10.0, right: 10.0),
                                child: PostUser(username: "anonymous"),
                              ),
                            ),
                            SizedBox(
                              width: 100,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 10.0, right: 10.0),
                                child: PostDate(date: formatDate(date)),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 10.0, right: 10.0, top: 10.0),
                    child: SizedBox(
                      width: MediaQuery.sizeOf(context).width,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                        child: PostContent(content: content),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 25.0, top: 10.0, bottom: 10, right: 10),
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
                      Padding(
                        padding: const EdgeInsets.only(top: 5.0),
                        child: IconButton(
                          icon: Icon(
                            Icons.comment,
                            size: 15.0,
                            color: primaryGrey,
                          ),
                          onPressed: () {
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: ((context) => AccountsPage())));
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 25.0, top: 10.0, bottom: 10, right: 10),
                        child: Text(
                          likeCommentState.toString(),
                          style: TextStyle(
                            color: primaryGrey,
                            fontWeight: FontWeight.bold,
                            fontSize: 10,
                            fontFamily: 'Asap',
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5.0),
                        child: IconButton(
                          icon: Icon(
                            Icons.favorite,
                            size: 15.0,
                            color: getLikeColor(),
                          ),
                          onPressed: () {
                            _threadController.likeThread(id, !likeState);
                            setState(() {
                              if (likeState == true) {
                                likeState = false;
                                likeCommentState -= 1;
                              } else {
                                likeState = true;
                                likeCommentState += 1;
                              }
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class ForumMenuMyPosts extends StatefulWidget {
  const ForumMenuMyPosts({super.key});

  @override
  State<ForumMenuMyPosts> createState() => _ForumMenuMyPostsState();
}

class _ForumMenuMyPostsState extends State<ForumMenuMyPosts> {
  late Future<List<Thread>> futureMyThreadList;

  // Future<List<Thread>> fetchThreads() async {
  //   futureThreadList = threadController.fetchThreads(0);
  //   print(futureThreadList);
  //   return futureThreadList;
  // }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraint) {
      return Scaffold(
        appBar: AppBar(
          toolbarHeight: 60,
          title: Text("My Posts", style: TextStyle(color: Colors.white)),
          centerTitle: true,
          flexibleSpace: Container(
            decoration: BoxDecoration(
                color: Colors.teal,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.elliptical(50, 20),
                    bottomRight: Radius.elliptical(50, 20))),
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
                  Navigator.pop(context);
                },
              ),
            ),
          ),
        ),
      );
    });
  }
}
