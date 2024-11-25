import 'package:crime_reporting_system/pages/Widgets/appdrawer.dart';

import 'package:crime_reporting_system/pages/Widgets/navbar.dart';
import 'package:flutter/material.dart';
import 'dart:ui';


class FeedbackScreen extends StatefulWidget {
  const FeedbackScreen({super.key});

  @override
  State<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  //final ref = FirebaseDatabase.instance.ref("Communiques");
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: const Navbar(),
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        appBar: AppBar(
          title: const Text("Feedback"),
          backgroundColor: const Color.fromARGB(255, 107, 244, 230),
          elevation: 0,
        ),
        drawer: const AppDrawer(),
        body: const Column(
          children: [
            
          ],
        ),
      ),
    );
  }
}
