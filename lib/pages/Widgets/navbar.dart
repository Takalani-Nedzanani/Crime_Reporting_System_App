import 'package:crime_reporting_system/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:crime_reporting_system/pages/comments_screen.dart';
import 'package:crime_reporting_system/pages/home_screendaily_comm_updates.dart';

class Navbar extends StatefulWidget {
  const Navbar({super.key});

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  @override
  Widget build(BuildContext context) {
    return navbar(context);
  }

  Container navbar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 5, bottom: 15),
      color: const Color(0xFFF0F4F3),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ElevatedButton(
            style: ButtonStyle(
              foregroundColor: getColor(
                  Colors.black, const Color.fromARGB(255, 104, 237, 224)),
              backgroundColor: getColor(
                  const Color.fromARGB(255, 111, 238, 245),
                  const Color.fromARGB(255, 119, 242, 229)),
            ),
            onPressed: () {
              setState(
                () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const HomeScreendailyCommUpdates(),
                    ),
                  );
                },
              );
            },
            child: const Icon(Icons.house_outlined),
          ),
          ElevatedButton(
            style: ButtonStyle(
              foregroundColor: getColor(
                  Colors.black, const Color.fromARGB(255, 122, 238, 226)),
              backgroundColor: getColor(
                  const Color.fromARGB(255, 109, 241, 228),
                  const Color.fromARGB(255, 118, 242, 230)),
            ),
            onPressed: () {
              setState(
                () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const CommentsScreen(),
                    ),
                  );
                },
              );
            },
            child: const Icon(Icons.comment_rounded),
          ),
          ElevatedButton(
            style: ButtonStyle(
              foregroundColor: getColor(
                  Colors.black, const Color.fromARGB(255, 106, 236, 223)),
              backgroundColor: getColor(const Color.fromARGB(255, 97, 227, 214),
                  const Color.fromARGB(255, 106, 236, 223)),
            ),
            onPressed: () {
              setState(() {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      backgroundColor: const Color.fromARGB(255, 131, 156, 168),
                      actionsAlignment: MainAxisAlignment.spaceEvenly,
                      title: const Center(
                        child: Text(
                          "Logout",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 25,
                          ),
                        ),
                      ),
                      content: const Text(
                        "Are You sure You Want To Log Out Of Your Account?",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) =>
                                    const HomeScreendailyCommUpdates(),
                              ),
                            );
                          },
                          child: const Text(
                            "Cancel",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            FirebaseAuth.instance.signOut();
                            navigatorKey.currentState!
                                .popUntil((route) => route.isFirst);
                          },
                          child: const Text(
                            "Logout",
                            style: TextStyle(
                              fontSize: 18,
                              color: Color.fromARGB(255, 167, 39, 39),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                );
              });
            },
            child: const Icon(Icons.logout_outlined),
          ),
        ],
      ),
    );
  }

  MaterialStateProperty<Color> getColor(Color color, Color colorPressed) {
    getColor(Set<MaterialState> states) {
      if (states.contains(MaterialState.pressed)) {
        return colorPressed;
      } else {
        return color;
      }
    }

    return MaterialStateProperty.resolveWith(getColor);
  }
}
