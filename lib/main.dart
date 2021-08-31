import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sugandha/auth/controller.dart';
import 'package:sugandha/auth/signin_signup_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:sugandha/splashscreen.dart';

import 'Main/homepage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sugandha',
      theme: ThemeData(
        primarySwatch: Colors.red,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
          brightness: Brightness.light,
        ),
      ),
      home: FutureBuilder<Map<String, Object>>(
          future: getData(),
          builder: (_, builder) {
            if (builder.hasData) {
              if (builder.data!['type'] == 'Facebook') {
                return HomePage(user: builder.data!['uid']);
              } else if (builder.data!['type'] == 'Google') {
                return HomePage(user: user!.uid);
              } else if (builder.data!['type'] == 'Mobile') {
                return HomePage(user: builder.data!['uid']);
              } else {
                return SignInSignUpPage();
              }
            } else {
              return SplashScreen();
            }
          }),
    );
  }
}
