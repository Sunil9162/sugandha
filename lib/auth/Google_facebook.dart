import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:sugandha/Main/homepage.dart';
import 'package:sugandha/auth/emaisignuppage.dart';

import 'controller.dart';

class GoogleFacebookButton extends StatefulWidget {
  const GoogleFacebookButton({Key? key}) : super(key: key);

  @override
  _GoogleFacebookButtonState createState() => _GoogleFacebookButtonState();
}

class _GoogleFacebookButtonState extends State<GoogleFacebookButton> {
  @override
  Widget build(BuildContext context) {
    var _firestore = FirebaseFirestore.instance;
    var size = MediaQuery.of(context).size;
    var uid = '';

    return Container(
      height: size.height * 0.2,
      width: size.width - 40,
      child: Column(
        children: [
          OutlinedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => EmailSignUpPage(),
                ),
              );
            },
            style: OutlinedButton.styleFrom(
              backgroundColor:
                  Theme.of(context).scaffoldBackgroundColor.withOpacity(0.7),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: Container(
              width: size.width - 75,
              height: size.height * 0.065,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.email_rounded,
                    color: Colors.black,
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    'Continue with Email',
                    style: TextStyle(
                      color: Colors.black.withOpacity(0.8),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              OutlinedButton(
                onPressed: () async {
                  var facebook = FacebookAuth.instance;
                  await facebook.login(
                    permissions: ['email', 'public_profile'],
                    loginBehavior: LoginBehavior.dialogOnly,
                  );

                  facebook.getUserData().then((data) {
                    _firestore
                        .collection("Users")
                        .doc(data['id'])
                        .get()
                        .then((value) async {
                      if (value.exists == false) {
                        await _firestore
                            .collection('Users')
                            .doc(data['id'])
                            .set({
                          'Name': data['name'],
                          'Email': data['email'],
                          'Type': 'Facebook',
                          'Image': data['picture']['data']['url'],
                        });
                      }
                    });
                    setState(() {
                      uid = data['id'];
                    });
                    print(uid);
                    if (uid != '') {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (_) => HomePage(
                            user: uid,
                          ),
                        ),
                      );
                      storedata('Facebook', uid);
                    }
                  });
                },
                style: OutlinedButton.styleFrom(
                  backgroundColor: Theme.of(context)
                      .scaffoldBackgroundColor
                      .withOpacity(0.7),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: SizedBox(
                  width: size.width / 2 - 60,
                  height: 42,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 25,
                        width: 25,
                        child: CachedNetworkImage(
                          imageUrl:
                              'https://cdn.freebiesupply.com/logos/large/2x/facebook-logo-2019.png',
                          fit: BoxFit.fill,
                        ),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Text(
                        'Facebook',
                        style: TextStyle(
                          color: Colors.black.withOpacity(0.8),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              OutlinedButton(
                onPressed: () {
                  try {
                    googleSIgnIn().whenComplete(
                      () {
                        User? user = FirebaseAuth.instance.currentUser;
                        _firestore
                            .collection("Users")
                            .doc(user!.uid)
                            .get()
                            .then((value) {
                          if (value.exists == false) {
                            makecollection(user.uid, user);
                          }
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('You have sucessfully Logged In!'),
                          ),
                        );
                        storedata('Google', user.uid);
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (_) => HomePage(
                              user: user.uid,
                            ),
                          ),
                        );
                      },
                    );
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          e.toString(),
                        ),
                      ),
                    );
                  }
                },
                style: OutlinedButton.styleFrom(
                  backgroundColor: Theme.of(context)
                      .scaffoldBackgroundColor
                      .withOpacity(0.7),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: SizedBox(
                  width: size.width / 2 - 60,
                  height: 42,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 25,
                        width: 25,
                        child: CachedNetworkImage(
                          imageUrl:
                              'https://upload.wikimedia.org/wikipedia/commons/thumb/5/53/Google_%22G%22_Logo.svg/600px-Google_%22G%22_Logo.svg.png',
                          fit: BoxFit.fill,
                        ),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Text(
                        'Google',
                        style: TextStyle(
                          color: Colors.black.withOpacity(0.8),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
