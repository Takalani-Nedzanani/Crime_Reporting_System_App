import 'package:flutter/material.dart';

class HomeCard extends StatelessWidget {
  const HomeCard({
    super.key,
    required this.text,
  });
  final Widget text;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          color: const Color.fromARGB(255, 206, 231, 238),
          elevation: 5,
          shadowColor: Colors.black,
          child: Padding(
              padding: const EdgeInsets.all(25),
              child: ListTile(
                subtitle: text,
                
              )),
        ),
      ],
    );
  }
}
