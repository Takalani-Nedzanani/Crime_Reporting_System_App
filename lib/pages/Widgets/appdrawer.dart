import 'package:crime_reporting_system/pages/comments_screen.dart';
import 'package:crime_reporting_system/pages/feedback_screen.dart';
import 'package:crime_reporting_system/pages/home_screendaily_comm_updates.dart';
import 'package:crime_reporting_system/pages/report_crimes_screen.dart';
import 'package:crime_reporting_system/pages/report_missing_people_screen.dart';
import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color(0xFFF0F4F3),
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Color(0xFFF0F4F3),
            ),
            child: Center(
              child: SizedBox(
                width: 200,
                child: Image.asset(
                  "assets/images/r_11.jpeg",
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
          ListTile(
            title: const Text(
              'Daily Community Updates',
              style: TextStyle(
                  color: Color.fromARGB(255, 0, 0, 0),
                  fontSize: 22,
                  fontWeight: FontWeight.bold),
            ),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const HomeScreendailyCommUpdates(),
                ),
              );
            },
          ),
          ListTile(
            title: const Text(
              'Report Crimes',
              style: TextStyle(
                  color: Color.fromARGB(255, 0, 0, 0),
                  fontSize: 22,
                  fontWeight: FontWeight.bold),
            ),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const ReportCrimesScreen(),
                ),
              );
            },
          ),
          ListTile(
            title: const Text(
              'Report Missing People',
              style: TextStyle(
                  color: Color.fromARGB(255, 0, 0, 0),
                  fontSize: 22,
                  fontWeight: FontWeight.bold),
            ),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const ReportMissingPeopleScreen(),
                ),
              );
            },
          ),
          ListTile(
            title: const Text(
              'Feedback',
              style: TextStyle(
                  color: Color.fromARGB(255, 0, 0, 0),
                  fontSize: 22,
                  fontWeight: FontWeight.bold),
            ),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const FeedbackScreen(),
                ),
              );
            },
          ),
          ListTile(
            title: const Text(
              'Comments',
              style: TextStyle(
                  color: Color.fromARGB(255, 0, 0, 0),
                  fontSize: 22,
                  fontWeight: FontWeight.bold),
            ),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const CommentsScreen(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
