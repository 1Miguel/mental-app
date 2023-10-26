import 'package:flutter/material.dart';
import 'package:flutter_intro/model/thread.dart';
import 'package:flutter_intro/ui_views/comment_box_app.dart';

// Local import
import 'package:flutter_intro/utils/colors_scheme.dart';
import 'package:flutter_intro/controllers/thread_controller.dart';

import 'package:get/get.dart';

class CommunityIntroPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {},
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          child: Column(
            children: [
              SizedBox(height: 80),
              Image.asset(
                'images/therapy_logo.png',
                width: 300,
                fit: BoxFit.fitWidth,
                height: 400,
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Community',
                    style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 40,
                        fontWeight: FontWeight.w800,
                        color: primaryPurple),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: MediaQuery.sizeOf(context).width,
                    child: Text(
                      "Share, discuss, and exchange thoughts with other users related to a person's well-being",
                      softWrap: true,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: 'Open Sans',
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 70),
              FilledButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => CommunityMainpage())));
                },
                style: ButtonStyle(
                    minimumSize: MaterialStateProperty.all<Size>(Size(200, 50)),
                    backgroundColor:
                        MaterialStateProperty.all<Color>(mainBlue)),
                child: Text('GET STARTED'),
              ),
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

  @override
  Widget build(BuildContext context) {
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
        child: ListView(
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      top: 0.0, bottom: 0.0, left: 20, right: 10),
                  child: SizedBox(
                    width: MediaQuery.sizeOf(context).width,
                    child: Text(
                      "Community",
                      style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: mainBlue),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 0.0, bottom: 10.0, left: 20, right: 10),
                  child: SizedBox(
                    width: MediaQuery.sizeOf(context).width,
                    child: Text(
                      "Share, discuss ideas with other users!",
                      style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: primaryGrey),
                    ),
                  ),
                ),
                Divider(
                  color: mainLightBlue,
                  thickness: 2,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 20.0, bottom: 10.0, left: 20, right: 10),
                  child: SizedBox(
                    width: MediaQuery.sizeOf(context).width,
                    child: Text("Topics",
                        style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: mainLightBlue)),
                  ),
                ),
                Container(
                  height: 550,
                  child: FutureBuilder<List<Thread>>(
                    future: fetchThreads(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        final threads = snapshot.data!;
                        return buildThreads(threads);
                      } else {
                        return const Text('No topics available');
                      }
                    },
                  ),
                ),
                FilledButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: ((context) => CreatePost()),
                      ),
                    );
                  },
                  style: ButtonStyle(
                      minimumSize:
                          MaterialStateProperty.all<Size>(Size(120, 30)),
                      backgroundColor:
                          MaterialStateProperty.all<Color>(mainLightBlue)),
                  child: Text('Create Post'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildThreads(List<Thread> threads) => ListView.builder(
        itemCount: threads.length,
        itemBuilder: (context, index) {
          final thread = threads[index];
          return PostCard(
            id: thread.threadId,
            title: thread.topic,
            username: thread.creator,
            content: thread.content,
            count: 1,
            onTap: () {},
          );
        },
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
        fontWeight: FontWeight.bold,
        fontFamily: 'Open Sans',
        fontSize: 17,
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
        color: mainDeepPurple,
        fontWeight: FontWeight.normal,
        fontFamily: 'Open Sans',
        fontSize: 12,
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
        fontSize: 14,
      ),
    );
  }
}

class PostCard extends StatelessWidget {
  final int id;
  final String title;
  final String username;
  final String content;
  final int count;
  final VoidCallback onTap;

  const PostCard({
    super.key,
    required this.id,
    required this.title,
    required this.username,
    required this.content,
    required this.count,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: ((context) => TopicThread(
                  topicId: id,
                  topicName: title,
                  content: content,
                )),
          ),
        );
      },
      child: Container(
        child: Card(
          elevation: 0.0,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    top: 10.0, bottom: 0.0, right: 10.0, left: 10.0),
                child: SizedBox(
                  width: MediaQuery.sizeOf(context).width,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                    child: PostTitle(title: title),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                child: SizedBox(
                  width: MediaQuery.sizeOf(context).width,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                    child: PostUser(username: "anonymous"),
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
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
                        left: 25.0, top: 10.0, bottom: 10),
                    child: Text(
                      count.toString(),
                      style: TextStyle(
                        color: primaryGrey,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Open Sans',
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5.0),
                    child: IconButton(
                      icon: Icon(
                        Icons.comment,
                        size: 20.0,
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
                ],
              ),
            ],
          ),
        ),
      ),
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
  final _formKey = GlobalKey<FormState>();
  ThreadController threadController = Get.put(ThreadController());

  @override
  Widget build(BuildContext context) {
    threadController.topicController.clear();
    threadController.contentController.clear();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: <Color>[primaryLightBlue, primaryBlue]),
          ),
        ),
        toolbarHeight: 60,
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
      body: Container(
        width: MediaQuery.sizeOf(context).width,
        child: ListView(
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: SizedBox(
                      width: MediaQuery.sizeOf(context).width,
                      child: Text(
                        'Title',
                        style: TextStyle(
                          fontFamily: 'Open Sans',
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  ),
                  TextFormField(
                    minLines: 1,
                    maxLines: 2,
                    keyboardType: TextInputType.multiline,
                    controller: threadController.topicController,
                    initialValue: null,
                    style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(10),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a topic title';
                      }
                      return null;
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: SizedBox(
                      width: MediaQuery.sizeOf(context).width,
                      child: Text(
                        'Description',
                        style: TextStyle(
                          fontFamily: 'Open Sans',
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  ),
                  TextFormField(
                    minLines: 5,
                    maxLines: 6,
                    keyboardType: TextInputType.multiline,
                    controller: threadController.contentController,
                    style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 20,
                        fontWeight: FontWeight.normal,
                        color: primaryGrey),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(10),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter content description';
                      }
                      return null;
                    },
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0, right: 10),
                        child: Text(
                          'Anonymous: ',
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 15,
                            fontWeight: FontWeight.normal,
                            color: primaryGrey,
                          ),
                        ),
                      ),
                      Switch(
                        // This bool value toggles the switch.
                        value: anonymous,
                        activeColor: Colors.green,
                        onChanged: (bool value) {
                          // This is called when the user toggles the switch.
                          setState(() {
                            anonymous = value;
                          });
                        },
                      ),
                    ],
                  ),
                  SizedBox(
                    child: MaterialButton(
                      color: primaryLightBlue,
                      child: Text("Create Post",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          threadController.createPost();
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
    );
  }
}
