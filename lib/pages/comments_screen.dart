import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crime_reporting_system/pages/Widgets/appdrawer.dart';
import 'package:crime_reporting_system/pages/Widgets/navbar.dart';
import 'package:crime_reporting_system/pages/Widgets/rate.dart';
import 'package:flutter/material.dart';
import 'dart:ui';



import 'package:firebase_auth/firebase_auth.dart';

import 'package:firebase_database/firebase_database.dart';


class CommentsScreen extends StatefulWidget {
  const CommentsScreen({super.key});

  @override
  State<CommentsScreen> createState() => _CommentsScreenState();
}

class _CommentsScreenState extends State<CommentsScreen> {
  TextEditingController commentController = TextEditingController();
  final user = FirebaseAuth.instance.currentUser!;
  late DatabaseReference dbRef;

  @override
  void dispose() {
    commentController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    dbRef = FirebaseDatabase.instance.ref().child("Comment");
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Comments"),
          backgroundColor: const Color.fromARGB(255, 107, 244, 230),
          elevation: 0,
        ),
        drawer: const AppDrawer(),
        bottomNavigationBar: const Navbar(),
        backgroundColor: const Color(0xFFF0F4F3),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                child: Container(
                  margin: const EdgeInsets.only(top: 20),
                  child: const Column(
                    children: [
                      Text(
                        "Rate Our App",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: [FlutterRatingBar()],
                      ),
                      Divider(
                        thickness: 2,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Container(
                margin: const EdgeInsets.only(left: 15, right: 15),
                alignment: AlignmentDirectional.topStart,
                child: Column(
                  children: [
                    const Text(
                      "Add Comment",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(
                      height: 60,
                    ),
                    TextField(
                      maxLines: 5,
                      style: const TextStyle(
                          color: Color.fromARGB(255, 44, 43, 43)),
                      cursorColor: const Color.fromARGB(255, 36, 8, 8),
                      controller: commentController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(8),
                        border: const OutlineInputBorder(),
                        labelText: "Type Here",
                        labelStyle: const TextStyle(
                          color: Color.fromARGB(255, 7, 70, 59),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 2,
                            color: Color.fromARGB(255, 7, 70, 59),
                          ),
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 1,
                            color: Color.fromARGB(255, 7, 70, 59),
                          ),
                        ),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(
                              () {
                                addUserComments(
                                    commentController.text.trim(), user.email!);
                                Map<String, String> users = {
                                  'Message': commentController.text.trim(),
                                  'Email': user.email!,
                                };
                                dbRef.push().set(users);
                                commentController.clear();
                              },
                            );
                          },
                          icon: const Icon(
                            Icons.add,
                            color: Colors.black,
                          ),
                        ),
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
  }

  Future addUserComments(String comments, String username) async {
    await FirebaseFirestore.instance.collection("comments").add({
      'comments': comments,
      'username': username,
    });
  }
}
