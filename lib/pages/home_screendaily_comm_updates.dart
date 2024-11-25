import 'package:crime_reporting_system/pages/Widgets/appdrawer.dart';

import 'package:crime_reporting_system/pages/Widgets/navbar.dart';

import 'package:flutter/material.dart';
import 'dart:ui';


 

class HomeScreendailyCommUpdates extends StatefulWidget {
  const HomeScreendailyCommUpdates({super.key});

  @override
  State<HomeScreendailyCommUpdates> createState() =>
      _HomeScreendailyCommUpdatesState();
}

class _HomeScreendailyCommUpdatesState
    extends State<HomeScreendailyCommUpdates> {
  //final ref = FirebaseDatabase.instance.ref("Communiques");
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: const Navbar(),
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        appBar: AppBar(
          title: const Text("Daily Community Updates"),
          backgroundColor: const Color.fromARGB(255, 108, 245, 231),
          elevation: 0,
        ),
        drawer: const AppDrawer(),
        body: const Column(
          children: [
            /* Expanded(
              child: FirebaseAnimatedList(
                query: ref,
                itemBuilder: (context, snapshot, animation, index) {
                  return CommuneCard(
                    title: Text(
                      snapshot.child("Message").value.toString(),
                    ),
                    subtitle: const Text(""),
                    onTap: () {},
                  );
                },
              ),
            ),*/
          ],
        ),
      ),
    );
  }
}
