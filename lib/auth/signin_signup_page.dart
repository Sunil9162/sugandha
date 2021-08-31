import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sugandha/auth/controller.dart';

import 'Google_facebook.dart';

class SignInSignUpPage extends StatefulWidget {
  @override
  _SignInSignUpPageState createState() => _SignInSignUpPageState();
}

class _SignInSignUpPageState extends State<SignInSignUpPage> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Color(0xFF1277bd),
    ));
  }

  bool isLoading = false;
  TextEditingController _numbertext = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      extendBody: true,
      resizeToAvoidBottomInset: false,
      body: Container(
        height: size.height,
        width: size.width,
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage('assets/images/bg.JPG'),
          ),
        ),
        child: Scaffold(
          backgroundColor: Color(0x961276BD),
          resizeToAvoidBottomInset: false,
          body: Container(
            height: size.height,
            width: size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 60,
                ),
                SizedBox(
                  height: 100,
                ),
                Container(
                  height: size.height * 0.065,
                  width: size.width - 40,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      Text(
                        '+91  ',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 6),
                        height: double.infinity,
                        width: 2,
                        color: Colors.grey,
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: SizedBox(
                          child: TextField(
                            controller: _numbertext,
                            style: TextStyle(
                              color: Colors.black.withOpacity(0.8),
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                            onChanged: (e) {
                              setState(() {});
                            },
                            keyboardType: TextInputType.phone,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Phone Number',
                              hintStyle: TextStyle(
                                color: Colors.grey,
                                fontSize: 16,
                              ),
                              suffixIcon: _numbertext.text != ""
                                  ? IconButton(
                                      onPressed: () {
                                        setState(() {
                                          _numbertext.text = '';
                                        });
                                      },
                                      icon: Icon(
                                        Icons.clear,
                                      ),
                                    )
                                  : SizedBox(),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                OutlinedButton(
                  onPressed: () {
                    if (_numbertext.text.length == 10) {
                      phoneLogin(_numbertext.text, context);
                      setState(() {
                        isLoading = true;
                      });
                      Future.delayed(Duration(milliseconds: 2), () {
                        setState(() {
                          isLoading = false;
                        });
                      });
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Invalid phone number'),
                        ),
                      );
                      setState(() {
                        isLoading = false;
                      });
                    }
                  },
                  style: OutlinedButton.styleFrom(
                    backgroundColor: Colors.black87,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Container(
                    width: size.width - 75,
                    height: size.height * 0.065,
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        isLoading ? 'Sending Otp' : 'Send OTP',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 20,
                  width: size.width - 40,
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 1,
                          color: Colors.grey,
                        ),
                      ),
                      Text(
                        '   Or  ',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.6),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Expanded(
                        child: Container(
                          height: 1,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                GoogleFacebookButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
