import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class FlutterRatingBar extends StatefulWidget {
  const FlutterRatingBar({super.key});

  @override
  State<FlutterRatingBar> createState() => _FlutterRatingBarState();
}

class _FlutterRatingBarState extends State<FlutterRatingBar> {
  double rating = 0;
  final user = FirebaseAuth.instance.currentUser!;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        RatingBar.builder(
          itemSize: 60,
          itemPadding: const EdgeInsets.all(5),
          initialRating: 3,
          minRating: 1,
          direction: Axis.horizontal,
          allowHalfRating: true,
          itemCount: 5,
          itemBuilder: (context, _) => const Icon(
            Icons.emoji_emotions_rounded,
            color: Colors.orangeAccent,
          ),
          onRatingUpdate: (rating) {
            setState(
              () {
                this.rating = rating;
                addUserRatings(rating.toString(), user.email!);
              },
            );
          },
        ),
        Text(
          "Rating: $rating",
          style: const TextStyle(fontSize: 20),
        ),
      ],
    );
  }

  Future addUserRatings(String rate, String username) async {
    await FirebaseFirestore.instance.collection("ratings").add({
      'rate': rate,
      'username': username,
    });
  }
}
