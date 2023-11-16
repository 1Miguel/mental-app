import 'package:flutter/material.dart';
import 'package:flutter_intro/controllers/thread_controller.dart';
import 'package:flutter_intro/model/thread.dart';
import 'package:flutter_intro/ui_views/users_controller.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:flutter_intro/utils/colors_scheme.dart';
import 'package:get/get.dart';

class PostUser extends StatelessWidget {
  final String username;

  const PostUser({super.key, required this.username});

  @override
  Widget build(BuildContext context) {
    return Text(
      username,
      textAlign: TextAlign.start,
      style: TextStyle(
        color: primaryGrey,
        fontWeight: FontWeight.bold,
        fontFamily: 'Open Sans',
        fontSize: 12,
      ),
    );
  }
}

class MemberCard extends StatefulWidget {
  final String username;
  final VoidCallback onTap;

  MemberCard({
    super.key,
    required this.username,
    required this.onTap,
  });

  @override
  State<MemberCard> createState() => _MemberCardState(
        username: username,
        onTap: onTap,
      );
}

class _MemberCardState extends State<MemberCard> {
  final String username;
  final VoidCallback onTap;

  _MemberCardState({
    required this.username,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraint) {
        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () async {},
          child: Container(
            width: constraint.maxWidth,
            child: Card(
              elevation: 0.0,
              surfaceTintColor: Colors.teal,
              child: Column(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 40.0, right: 10.0, top: 5),
                    child: Row(
                      children: [
                        CircleAvatar(
                            backgroundColor: Colors.teal.shade200,
                            minRadius: 15,
                            child: Icon(Icons.person, size: 15)),
                        SizedBox(
                          width: (constraint.maxWidth) / 2,
                          child: Padding(
                            padding:
                                const EdgeInsets.only(left: 30.0, right: 10.0),
                            child: PostUser(username: username),
                          ),
                        ),
                      ],
                    ),
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

class ForumMembers extends StatefulWidget {
  const ForumMembers({super.key});

  @override
  State<ForumMembers> createState() => _ForumMembersState();
}

class _ForumMembersState extends State<ForumMembers> {
  late Future<List<String>> futureUsersList;
  UserController userController = Get.put(UserController());

  Future<List<String>> fetchUsers() async {
    futureUsersList = userController.fetchUsers();
    print(futureUsersList);
    return futureUsersList;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraint) {
      return Scaffold(
        appBar: AppBar(
          toolbarHeight: 60,
          title: Text("Community", style: TextStyle(color: Colors.white)),
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
        body: Container(
          width: constraint.maxWidth,
          height: constraint.maxHeight,
          child: Column(
            children: [
              Container(
                height: constraint.maxHeight - 84 - 50,
                child: Column(
                  children: [
                    SizedBox(height: 20),
                    SizedBox(
                      width: constraint.maxWidth,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 30.0),
                        child: Text("Members", style: TextStyle(fontSize: 16)),
                      ),
                    ),
                    Divider(),
                    Container(
                      height: constraint.maxHeight - 200,
                      width: constraint.maxWidth,
                      child: FutureBuilder<List<String>>(
                        future: fetchUsers(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            final threads = snapshot.data!;
                            if (threads.length > 0) {
                              return _buildMembers(threads);
                            } else {
                              return Column(
                                children: [
                                  SizedBox(height: 20),
                                  Container(
                                    width: constraint.maxWidth - 80,
                                    child: Card(
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(15.0),
                                            child: SizedBox(
                                                width: constraint.maxWidth,
                                                child: Text("No members yet",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 25,
                                                    ))),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            }
                          } else {
                            return waitThreads(context);
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
    });
  }

  Widget _buildMembers(List<String> threads) => ListView.builder(
        itemCount: threads.length,
        itemBuilder: (context, index) {
          final thread = threads[index];
          return LayoutBuilder(builder: (context, constraint) {
            return Column(
              children: [
                MemberCard(
                  username: thread,
                  onTap: () {},
                ),
              ],
            );
          });
        },
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
