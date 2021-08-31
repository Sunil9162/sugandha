import 'package:flutter/material.dart';
import 'package:sugandha/auth/controller.dart';
import 'package:sugandha/auth/phonenumberloginpage.dart';

class OtpPage extends StatefulWidget {
  final otp;
  final number;

  const OtpPage({Key? key, required this.otp, required this.number})
      : super(key: key);
  @override
  _OtpPageState createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  var _otp = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Enter OTP',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
            child: TextField(
              controller: _otp,
              style: TextStyle(
                color: Colors.black.withOpacity(0.8),
                fontSize: 17,
              ),
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                labelText: 'OTP',
                labelStyle: TextStyle(
                  color: Colors.grey,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          OutlinedButton(
            onPressed: () {
              if (_otp.text == widget.otp) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => PhoneNumberLogin(),
                  ),
                );
              } else {
                print(widget.otp);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Invalid otp'),
                  ),
                );
              }
            },
            child: SizedBox(
              height: 45,
              width: MediaQuery.of(context).size.width - 50,
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  'Verify',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
            style: OutlinedButton.styleFrom(
              backgroundColor: Color(0xE0000000),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          )
        ],
      ),
    );
  }
}
