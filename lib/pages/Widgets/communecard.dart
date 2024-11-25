import 'package:flutter/material.dart';

class CommuneCard extends StatelessWidget {
  const CommuneCard({
    super.key, // required this.map,
    required this.onTap,
    required this.title,
    required this.subtitle,
  });
  
  final void Function()? onTap;
  final Widget title;
  final Widget subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          color: const Color.fromARGB(255, 206, 231, 238),
          elevation: 15,
          shadowColor: Colors.black,
          child: Padding(
            padding: const EdgeInsets.all(25),
            child: ListTile(
              title: title,
              subtitle: subtitle,
              onTap: onTap,
            ),
          ),
        ),
      ],
    );
  }
}
