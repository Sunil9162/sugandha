import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sugandha/Main/homepage.dart';
import 'package:sugandha/auth/signin_signup_page.dart';

import 'OtpPage.dart';

FirebaseAuth auth = FirebaseAuth.instance;
final googleSignIn = GoogleSignIn();
var _firestore = FirebaseFirestore.instance;

Future<bool> googleSIgnIn() async {
  GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();

  if (googleSignInAccount != null) {
    GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;

    AuthCredential credential = GoogleAuthProvider.credential(
      idToken: googleSignInAuthentication.idToken,
      accessToken: googleSignInAuthentication.accessToken,
    );

    UserCredential result = await auth.signInWithCredential(credential);
    User? user = result.user;
  }
  return Future.value(true);
}

Future<bool> emailsignUp(
  String email,
  String password,
  String name,
  BuildContext context,
) async {
  var result = await auth.createUserWithEmailAndPassword(
      email: email, password: password);

  User? user = result.user;
  if (user != null) {
    _firestore.collection("Users").doc(user.uid).get().then((value) {
      if (value.exists == false) {
        var _firestore = FirebaseFirestore.instance;
        _firestore.collection('Users').doc(user.uid).set({
          'Name': name,
          'Email': user.email,
          'Type': 'Google',
          'Image': user.photoURL,
        });
      }
    });
    storedata('Google', user.uid);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => HomePage(
          user: user.uid,
        ),
      ),
    );
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Fill all details correctly'),
      ),
    );
  }

  return Future.value(true);
}

emaillogout(BuildContext context) async {
  await auth.signOut();
  storedata('null', '');
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(
      builder: (_) => SignInSignUpPage(),
    ),
  );
}

addphone() {}
String otpcode = '';
Future<bool> phoneLogin(String number, BuildContext context) async {
  await auth
      .verifyPhoneNumber(
    phoneNumber: "+91" + number,
    verificationCompleted: (phoneAuthCredential) {},
    verificationFailed: (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('$e'),
        ),
      );
    },
    codeSent: (code, sms) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => OtpPage(
            otp: sms,
            number: number,
          ),
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Code Sent Sucessfully'),
        ),
      );
    },
    codeAutoRetrievalTimeout: (String verificationId) {},
  )
      .catchError((e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$e'),
      ),
    );
  });
  return Future.value(true);
}

Future<bool> emailLogIn(
  String email,
  String password,
  String name,
  BuildContext context,
) async {
  var result =
      await auth.signInWithEmailAndPassword(email: email, password: password);
  User? user = result.user;
  if (user != null) {
    _firestore.collection("Users").doc(user.uid).get().then((value) {
      if (value.exists == false) {
        var _firestore = FirebaseFirestore.instance;
        _firestore.collection('Users').doc(user.uid).set({
          'Name': name,
          'Email': user.email,
          'Type': 'Google',
          'Image': user.photoURL,
        });
      }
    });
    storedata('Google', user.uid);

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => HomePage(
          user: user.uid,
        ),
      ),
    );
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Fill all details correctly'),
      ),
    );
  }

  return Future.value(true);
}

void makecollection(uid, User? user) async {
  var _firestore = FirebaseFirestore.instance;
  await _firestore.collection('Users').doc(uid).set({
    'Name': user!.displayName,
    'Email': user.email,
    'Type': 'Google',
    'Image': user.photoURL,
  });
}

logout(BuildContext context) async {
  await googleSignIn.signOut();
  await auth.signOut();
  storedata('null', '');
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(
      builder: (_) => SignInSignUpPage(),
    ),
  );
}

storedata(String type, String uid) async {
  var prefs = await SharedPreferences.getInstance();
  await prefs.setString('type', type);
  await prefs.setString('uid', uid);
}

Future<Map<String, Object>> getData() async {
  var prefs = await SharedPreferences.getInstance();
  var type = prefs.getString('type');
  var uid = prefs.getString('uid');
  return {
    "type": type.toString(),
    'uid': uid.toString(),
  };
}

facebooksignout() async {
  var facebook = FacebookAuth.instance;
  await facebook.logOut();
  storedata('null', '');
}

signInwithemail(String email, String password) async {
  await auth.signInWithEmailAndPassword(email: email, password: password);
}
