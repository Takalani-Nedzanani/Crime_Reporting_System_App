//import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:flutter/material.dart';

/*class GetUsername extends StatelessWidget {
  const GetUsername({
    super.key,
    required this.documentId,
  });
  final String documentId;

  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(documentId).get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          return Center(
            child: Text(
              "Welcome ${data['first name']}",
              style: const TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
              ),
            ),
          );
        }
        return const Center(
          child: Text("loading..."),
        );
      },
    );
  }
}*/
