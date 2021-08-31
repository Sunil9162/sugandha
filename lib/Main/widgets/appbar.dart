import 'package:flutter/material.dart';

class LocationAppBar extends StatefulWidget {
  const LocationAppBar({Key? key}) : super(key: key);

  @override
  _LocationAppBarState createState() => _LocationAppBarState();
}

class _LocationAppBarState extends State<LocationAppBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: GestureDetector(
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Location Chosen: Kharkhura'),
            ),
          );
        },
        child: Row(
          children: [
            Icon(
              Icons.pin_drop_rounded,
              color: Colors.red,
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              "Kharkhura",
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
