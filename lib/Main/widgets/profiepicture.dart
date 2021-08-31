import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sugandha/auth/controller.dart';

class ProfilePicture extends StatefulWidget {
  final user;

  const ProfilePicture({
    Key? key,
    this.user,
  }) : super(key: key);

  @override
  _ProfilePictureState createState() => _ProfilePictureState();
}

class _ProfilePictureState extends State<ProfilePicture> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        stream: FirebaseFirestore.instance
            .collection("Users")
            .doc(widget.user)
            .snapshots(),
        builder: (context, snapshot) {
          return GestureDetector(
            onTap: () {
              logout(context);
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: CircleAvatar(
                backgroundColor: Colors.grey.withOpacity(0.3),
                backgroundImage: NetworkImage(
                  snapshot.hasData ? snapshot.data!['Image'] ?? '' : '',
                ),
              ),
            ),
          );
        });
  }
}
