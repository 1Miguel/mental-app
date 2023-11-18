import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_intro/model/thread.dart';
import 'package:flutter_intro/model/user.dart';
import 'package:flutter_intro/ui_views/comment_box_app.dart';
import 'package:flutter_intro/ui_views/dashboard_views.dart';
import 'package:flutter_intro/ui_views/forum_members.dart';
import 'package:flutter_intro/ui_views/forum_myfavorites.dart';
import 'package:flutter_intro/ui_views/forum_myposts.dart';

// Local import
import 'package:flutter_intro/utils/colors_scheme.dart';
import 'package:flutter_intro/controllers/thread_controller.dart';

import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MenuTile extends StatelessWidget {
  final String menu;
  final IconData menuIcon;
  final VoidCallback onTap;

  const MenuTile({
    super.key,
    required this.menu,
    required this.menuIcon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          ListTile(
            contentPadding: EdgeInsets.only(left: 40.0, right: 40.0, top: 10.0),
            leading: Icon(menuIcon, size: 30, color: Colors.teal),
            trailing: Icon(Icons.navigate_next, size: 30, color: Colors.grey),
            horizontalTitleGap: 30.0,
            title: MenuTitleText(menuText: menu),
            onTap: () {
              onTap();
            },
          ),
          Divider(),
        ],
      ),
    );
  }
}

class CommunityIntroPage extends StatelessWidget {
  User emptyUser = User(
    id: 0,
    email: "",
    password_hash: "",
    firstname: "",
    lastname: "",
    username: "",
    address: "",
    age: 0,
    occupation: "",
    contact_number: "",
    status: "",
    dateCreated: "",
  );

  Future<String?> getUserStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? status = prefs.getString('status')!.toUpperCase();
    return status;
  }

  _showErrorDialog(context, errorMessage) {
    Alert(
      context: context,
      //style: alertStyle,
      type: AlertType.error,
      title: "User Banned",
      desc: errorMessage,
      buttons: [
        DialogButton(
          child: Text(
            "OK",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => {
            Navigator.push(context,
                MaterialPageRoute(builder: ((context) => DashboardPage()))),
          },
          color: Colors.redAccent,
          radius: BorderRadius.circular(0.0),
        ),
      ],
    ).show();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {},
      child: Scaffold(
        backgroundColor: forumMainBg,
        resizeToAvoidBottomInset: false,
        body: Container(
          child: Column(
            children: [
              SizedBox(height: 120),
              Image.asset(
                'images/forum_intro.png',
                width: 300,
                fit: BoxFit.fitWidth,
                height: 400,
              ),
              SizedBox(height: 20),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: MediaQuery.sizeOf(context).width - 60,
                    child: Text(
                      "Share, discuss, and exchange thoughts with other users related to a person's well-being",
                      softWrap: true,
                      maxLines: 3,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: 'Open Sans',
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 70),
              FutureBuilder<dynamic>(
                  future: getUserStatus(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final requestList = snapshot.data!;
                      print(requestList);
                      return FilledButton(
                        onPressed: () async {
                          if (requestList != "BANNED") {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: ((context) =>
                                        CommunityMainpage())));
                          } else {
                            print("Debug: user is banned");
                            _showErrorDialog(context,
                                "Your account has been banned. Kindly contact PMHA to appeal your account.");
                          }
                        },
                        style: ButtonStyle(
                          minimumSize:
                              MaterialStateProperty.all<Size>(Size(200, 50)),
                          backgroundColor:
                              MaterialStateProperty.all<Color>(forumButton),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                              side:
                                  BorderSide(width: 2.0, color: loginDarkTeal),
                            ),
                          ),
                        ),
                        child: Text(
                          'GET STARTED',
                          style: TextStyle(
                              fontFamily: 'Open Sans',
                              fontWeight: FontWeight.bold),
                        ),
                      );
                    }
                    return CircularProgressIndicator();
                  }),
            ],
          ),
        ),
      ),
    );
  }
}

class CommunityMainpage extends StatefulWidget {
  @override
  State<CommunityMainpage> createState() => _CommunityMainPageState();
}

class _CommunityMainPageState extends State<CommunityMainpage> {
  List<Thread> threads = getThreads();
  late Future<List<Thread>> futureThreadList;
  ThreadController threadController = Get.put(ThreadController());

  static List<Thread> getThreads() {
    const data = [
      {
        "thread_id": 1,
        "topic": "How to Overcome depression",
        "content":
            "I have been depressed for over a month now, would you guys help me out",
        "creator": "/user001",
        "date_created": "2023-10-20",
        "comments": [],
      },
      {
        "thread_id": 2,
        "topic": "Does having a pet help me overcome stress?",
        "content":
            "I'm going to get me dog as soon as next week, would it help me to deal with my stress?",
        "creator": "/user002",
        "date_created": "2023-10-20",
        "comments": [],
      },
      {
        "thread_id": 3,
        "topic": "Most Common Health Problems",
        "content":
            "I'm wondering what are the most common mental health related problems people face today",
        "creator": "/user003",
        "date_created": "2023-10-20",
        "comments": [],
      },
      {
        "thread_id": 4,
        "topic": "How to overcome anger",
        "content": "How to start with anger management?",
        "creator": "/user004",
        "date_created": "2023-10-20",
        "comments": [],
      }
    ];
    return data.map<Thread>(Thread.fromJson).toList();
  }

  Future<List<Thread>> fetchThreads() async {
    futureThreadList = threadController.fetchThreads(0);
    print(futureThreadList);
    return futureThreadList;
  }

  _onPagePop(context) {
    Navigator.push(
        context, MaterialPageRoute(builder: ((context) => DashboardPage())));
  }

  @override
  void initState() {
    setState(() {});
    super.initState();
    //Timer.periodic(Duration(seconds: 2), (timer) {
    //setState(() {});
    //});
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (value) {
        _onPagePop(context);
      },
      canPop: false,
      child: LayoutBuilder(builder: (context, constraint) {
        return Scaffold(
          backgroundColor: Colors.teal,
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            backgroundColor: Colors.teal,
            toolbarHeight: 60,
            title: Text("Forum", style: TextStyle(color: Colors.white)),
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
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: ((context) => DashboardPage())));
                  },
                ),
              ),
            ),
            actions: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: 15.0),
                child: IconButton(
                  icon: Icon(
                    Icons.menu,
                    color: Colors.white,
                    size: 40,
                  ),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: ((context) => ForumMenu())));
                  },
                ),
              ),
            ],
          ),
          body: Container(
            color: Colors.teal,
            width: constraint.maxWidth,
            height: constraint.maxHeight - 84,
            child: Column(
              children: [
                Container(
                  width: constraint.maxWidth,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.teal,
                    image: DecorationImage(
                      image: AssetImage(
                        "images/forum_logo_hd.png",
                      ),
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                ),
                Container(
                  height: constraint.maxHeight - 100 - 84,
                  decoration: BoxDecoration(
                      color: backgroundColor,
                      border: Border(
                        top: BorderSide(color: backgroundColor, width: 2),
                        left: BorderSide(color: backgroundColor, width: 2),
                        right: BorderSide(color: backgroundColor, width: 2),
                      ),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.elliptical(40, 20),
                          topRight: Radius.elliptical(50, 20))),
                  child: Column(
                    children: [
                      SizedBox(height: 10),
                      Container(
                        height: constraint.maxHeight - 100 - 90 - 30 - 10 - 20,
                        width: constraint.maxWidth,
                        child: FutureBuilder<List<Thread>>(
                          future: fetchThreads(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              final threads = snapshot.data!;
                              return buildThreads(threads, () {
                                setState(() {});
                              });
                            } else {
                              return waitThreads(context);
                            }
                          },
                        ),
                      ),
                      SizedBox(
                        height: 30,
                        child: FilledButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: ((context) => CreatePost()),
                              ),
                            );
                          },
                          style: ButtonStyle(
                              minimumSize: MaterialStateProperty.all<Size>(
                                  Size(120, 30)),
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.lightGreen)),
                          child: Text('Post'),
                        ),
                      ),
                      SizedBox(height: 20),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  String formatDate(String date) {
    String updStartTime =
        DateFormat('yyyy-MM-dd').format(DateTime.parse(date)).toString();
    return updStartTime;
  }

  Widget buildThreads(List<Thread> threads, VoidCallback callback) =>
      RefreshIndicator(
        onRefresh: () async {
          setState(() {
            callback();
          });
          await Future.delayed(Duration(seconds: 2));
        },
        child: ListView.builder(
          itemCount: threads.length,
          itemBuilder: (context, index) {
            final thread = threads[index];

            getLikeColor() {
              if (thread.isLiked == true) {
                return Colors.red;
              }
              Colors.grey;
            }

            return LayoutBuilder(builder: (context, constraint) {
              return Column(
                children: [
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () async {
                      List result = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          maintainState: false,
                          builder: ((context) => TopicThread(
                                topicId: thread.threadId,
                                topicName: thread.topic,
                                content: thread.content,
                                isLiked: thread.isLiked,
                                numLikes: thread.numLikes,
                                numComments: thread.numComments,
                              )),
                          //maintainState: false,
                        ),
                      );
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
                                  top: 10.0,
                                  bottom: 0.0,
                                  right: 10.0,
                                  left: 10.0),
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: constraint.maxWidth - 30,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10.0, right: 10.0),
                                      child: PostTitle(title: thread.topic),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 20.0, right: 10.0, top: 2),
                              child: Row(
                                children: [
                                  CircleAvatar(
                                      minRadius: 15,
                                      child: Icon(Icons.eco, size: 13)),
                                  Column(
                                    children: [
                                      SizedBox(
                                        width: 100,
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 10.0, right: 10.0),
                                          child: PostUser(
                                              username: thread.creator),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 100,
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 10.0, right: 10.0),
                                          child: PostDate(
                                              date: formatDate(thread.date)),
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
                                  padding: const EdgeInsets.only(
                                      left: 10.0, right: 10.0),
                                  child: PostContent(content: thread.content),
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 25.0,
                                      top: 10.0,
                                      bottom: 10,
                                      right: 10),
                                  child: Text(
                                    thread.numComments.toString(),
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
                                      left: 25.0,
                                      top: 10.0,
                                      bottom: 10,
                                      right: 10),
                                  child: Text(
                                    thread.numLikes.toString(),
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
                                      threadController.likeThread(
                                          thread.threadId, !thread.isLiked);
                                      setState(() {});
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Divider(),
                ],
              );
            });
          },
        ),
      );

  Widget waitThreads(context) => Container(
        width: MediaQuery.sizeOf(context).width,
        child: Column(
          children: [
            SizedBox(
              width: 100,
              height: 100,
              child: CircularProgressIndicator(
                color: primaryGrey,
              ),
            ),
          ],
        ),
      );
}

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
            List result = await Navigator.push(
              context,
              MaterialPageRoute(
                maintainState: false,
                builder: ((context) => TopicThread(
                      topicId: id,
                      topicName: title,
                      content: content,
                      isLiked: likeState,
                      numLikes: likeCommentState,
                      numComments: commentState,
                    )),
                //maintainState: false,
              ),
            );

            setState(() {
              print("Results ${result[0]}, ${result[1]}");
              print("Comment State: $commentState");
              if (result[0] != likeState) {
                if (result[0] == true) {
                  likeState = true;
                  likeCommentState += 1;
                } else {
                  likeState = false;
                  likeCommentState -= 1;
                }
              } else if (result[1] != commentState) {
                commentState = result[1];
              }
              print("Set State: {$likeState}");
              //likeState = isLiked;
              // likeCommentState = numLikes;
              // commentState = numComment;
            });
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
                                child: PostUser(username: username),
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

class CreatePost extends StatefulWidget {
  const CreatePost({super.key});

  @override
  State<CreatePost> createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {
  bool anonymous = true;
  bool notify = false;
  String postName = "anonymous";
  final _formKey = GlobalKey<FormState>();
  ThreadController threadController = Get.put(ThreadController());

  Future<String?> getUserName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? name;

    if (prefs.containsKey('username')) {
      name = prefs.getString('username');
    }
    return name;
  }

  String getPostName() {
    if (anonymous) {
      return "anonymous";
    }
    return postName;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        toolbarHeight: 60,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.elliptical(100, 20.0),
          ),
        ),
        centerTitle: true,
        leading: SizedBox(
          width: 20,
          height: 20,
          child: Padding(
            padding: EdgeInsets.only(bottom: 3.0, left: 11.0),
            child: IconButton(
              icon: const Icon(
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
        title: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Text(
            'CREATE POST',
            style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white),
          ),
        ),
      ),
      body: FutureBuilder(
          future: getUserName(),
          initialData: null,
          builder: (BuildContext context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.grey,
                ),
              );
            }
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                return Center(
                  child: Text(
                    'An ${snapshot.error} occurred',
                    style: const TextStyle(fontSize: 18, color: Colors.red),
                  ),
                );
              } else if (snapshot.hasData) {
                final data = snapshot.data;
                postName = data!;

                return Container(
                  width: MediaQuery.sizeOf(context).width,
                  child: ListView(
                    children: [
                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            SizedBox(height: 95),
                            Container(
                              width: MediaQuery.sizeOf(context).width,
                              height: 300,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                image: DecorationImage(
                                  image: AssetImage("images/thought.gif"),
                                  fit: BoxFit.fitHeight,
                                ),
                              ),
                            ),
                            Container(
                              width: MediaQuery.sizeOf(context).width,
                              decoration: BoxDecoration(
                                  color: lightBlueBg,
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(50),
                                    topLeft: Radius.circular(50),
                                  )),
                              child: Column(
                                children: [
                                  SizedBox(height: 50),
                                  Container(
                                    width: MediaQuery.sizeOf(context).width,
                                    child: TextFormField(
                                      minLines: 1,
                                      maxLines: 2,
                                      keyboardType: TextInputType.text,
                                      controller:
                                          threadController.topicController,
                                      initialValue: null,
                                      style: TextStyle(
                                        fontFamily: 'Roboto',
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                      decoration: InputDecoration(
                                        hintText: "Title",
                                        hintStyle:
                                            TextStyle(color: Colors.white),
                                        errorStyle: TextStyle(
                                          fontFamily: 'Roboto',
                                          color: Colors.red,
                                        ),
                                        contentPadding: EdgeInsets.only(
                                            left: 20, right: 20),
                                      ),
                                      validator: (value) {
                                        String validPattern =
                                            '[^ a-zA-Z?!0-9.,]';
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter a topic title';
                                        }
                                        if (value
                                            .contains(RegExp(validPattern))) {
                                          return 'Must not contain invalid characters';
                                        }
                                        if (value.length > 50) {
                                          return 'Invalid title length';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                  Container(
                                    color: lightBlueBg,
                                    width: MediaQuery.sizeOf(context).width,
                                    child: TextFormField(
                                      minLines: 6,
                                      maxLines: 6,
                                      keyboardType: TextInputType.multiline,
                                      controller:
                                          threadController.contentController,
                                      style: TextStyle(
                                          fontFamily: 'Roboto',
                                          fontSize: 20,
                                          fontWeight: FontWeight.normal,
                                          color: Colors.white),
                                      decoration: InputDecoration(
                                        hintText: "Body",
                                        hintStyle:
                                            TextStyle(color: Colors.white),
                                        contentPadding: EdgeInsets.only(
                                            left: 20, right: 20, top: 20),
                                        errorStyle: TextStyle(
                                          fontFamily: 'Roboto',
                                          color: Colors.red,
                                        ),
                                      ),
                                      validator: (value) {
                                        String validPattern =
                                            '[^ a-zA-Z?!0-9.,]';
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter content description';
                                        }
                                        if (value
                                            .contains(RegExp(validPattern))) {
                                          return 'Must not contain invalid characters';
                                        }
                                        if (value.length > 255) {
                                          return 'Invalid content length';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height: 90,
                              color: greenBlueBg,
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 20.0, right: 10),
                                        child: Text(
                                          'Anonymous',
                                          style: TextStyle(
                                            fontFamily: 'Roboto',
                                            fontSize: 15,
                                            fontWeight: FontWeight.normal,
                                            color: primaryGrey,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 50,
                                        height: 30,
                                        child: FittedBox(
                                          fit: BoxFit.fill,
                                          child: Switch(
                                            // This bool value toggles the switch.
                                            value: anonymous,
                                            activeColor: unselectedLightBlue,
                                            onChanged: (bool value) {
                                              // This is called when the user toggles the switch.
                                              setState(() {
                                                anonymous = value;
                                              });
                                            },
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 20.0, right: 10),
                                        child: Text(
                                          'Notify for replies',
                                          style: TextStyle(
                                            fontFamily: 'Roboto',
                                            fontSize: 15,
                                            fontWeight: FontWeight.normal,
                                            color: primaryGrey,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 50,
                                        height: 30,
                                        child: FittedBox(
                                          fit: BoxFit.fill,
                                          child: Switch(
                                            // This bool value toggles the switch.
                                            value: notify,
                                            activeColor: unselectedLightBlue,
                                            onChanged: (bool value) {
                                              // This is called when the user toggles the switch.
                                              setState(() {
                                                notify = value;
                                              });
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    child: MaterialButton(
                                      color: mainLightBlue,
                                      child: Text("Post",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold)),
                                      onPressed: () {
                                        if (_formKey.currentState!.validate()) {
                                          threadController
                                              .createPost(getPostName());
                                        }
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
  }
}

class ForumMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraint) {
      return Scaffold(
        appBar: AppBar(
          //backgroundColor: Colors.teal,
          toolbarHeight: 60,
          title: Text("Forum", style: TextStyle(color: Colors.white)),
          centerTitle: true,
          flexibleSpace: Container(
            decoration: BoxDecoration(
                color: Colors.teal,
                //image: DecorationImage(
                //    image: AssetImage('images/bg_teal_hd.png'),
                //    fit: BoxFit.fill),
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
        body: Container(
          child: ListView(
            children: [
              MenuTile(
                menu: 'My Post',
                menuIcon: Icons.edit_square,
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => ForumMenuMyPosts())));
                },
              ),
              MenuTile(
                menu: 'Favorites',
                menuIcon: Icons.favorite,
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => ForumMenuMyFavorites())));
                },
              ),
              // MenuTile(
              //   menu: 'Delete Post',
              //   menuIcon: Icons.delete,
              //   onTap: () {
              //     // Navigator.push(
              //     //     context,
              //     //     MaterialPageRoute(
              //     //         builder: ((context) => EditProfilePage())));
              //   },
              // ),
              MenuTile(
                menu: 'Members',
                menuIcon: Icons.group,
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => ForumMembers())));
                },
              ),
            ],
          ),
        ),
      );
    });
  }
}

class SuccessPostPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PopScope(
        canPop: false,
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            // Navigator.push(context,
            //     MaterialPageRoute(builder: ((context) => MoodModalPage())));
          },
          child: Scaffold(
            body: Container(
              color: backgroundColor,
              child: Center(
                child: ListView(
                  children: [
                    SizedBox(height: 100),
                    Image.asset(
                      'images/welcome_logo.png',
                      fit: BoxFit.fitHeight,
                      height: 300,
                    ),
                    SizedBox(height: 80),
                    SizedBox(
                      child: Text(
                        "Great!",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.lightGreen,
                          fontFamily: 'Proza Libre',
                          fontWeight: FontWeight.bold,
                          fontSize: 40,
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    SizedBox(
                      child: Text(
                        "Your post has been published",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black87,
                          fontFamily: 'Proza Libre',
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    SizedBox(height: 50),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FilledButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: ((context) =>
                                        CommunityMainpage())));
                          },
                          style: ButtonStyle(
                            minimumSize:
                                MaterialStateProperty.all<Size>(Size(200, 50)),
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.teal),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                                side: BorderSide(
                                    width: 2.0, color: loginDarkTeal),
                              ),
                            ),
                          ),
                          child: Text(
                            'CONTINUE',
                            style: TextStyle(
                              fontFamily: 'Open Sans',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}

class ForumMenuMembers extends StatefulWidget {
  const ForumMenuMembers({super.key});

  @override
  State<ForumMenuMembers> createState() => _ForumMenuMembersState();
}

class _ForumMenuMembersState extends State<ForumMenuMembers> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraint) {
      return Scaffold(
        appBar: AppBar(
          toolbarHeight: 60,
          title: Text("Members", style: TextStyle(color: Colors.white)),
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
