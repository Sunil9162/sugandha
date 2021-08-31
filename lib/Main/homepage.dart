import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sugandha/Main/widgets/appbar.dart';
import 'package:sugandha/Main/widgets/profiepicture.dart';
import 'package:sugandha/pages/laundrypage.dart';

class HomePage extends StatefulWidget {
  final user;

  const HomePage({Key? key, required this.user}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: Theme.of(context).scaffoldBackgroundColor,
      // statusBarColor: Color(0xFFA86D6D),
    ));
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, scrolled) => [
          SliverAppBar(
            automaticallyImplyLeading: false,
            brightness: Brightness.light,
            collapsedHeight: AppBar().preferredSize.height,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            title: LocationAppBar(),
            actions: [
              ProfilePicture(
                user: widget.user,
              ),
            ],
          ),
        ],
        body: LaundryPage(),
      ),
    );
  }
}
