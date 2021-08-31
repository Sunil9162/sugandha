import 'package:flutter/cupertino.dart';

final foods = <Foods>[
  Foods(AssetImage('assets/images/1.JPG'), 'Pratha'),
  Foods(AssetImage('assets/images/2.JPG'), 'Roti'),
  Foods(AssetImage('assets/images/3.JPG'), 'Biryani'),
  Foods(AssetImage('assets/images/4.JPG'), 'Healthy'),
  Foods(AssetImage('assets/images/5.JPG'), 'Paneer'),
  Foods(AssetImage('assets/images/6.JPG'), 'Cake'),
  Foods(AssetImage('assets/images/7.JPG'), 'Bugger'),
  Foods(AssetImage('assets/images/8.JPG'), 'Cake'),
  Foods(AssetImage('assets/images/7.JPG'), 'Samosa'),
  Foods(AssetImage('assets/images/3.JPG'), 'Biryani'),
  Foods(AssetImage('assets/images/4.JPG'), 'Healthy'),
  Foods(AssetImage('assets/images/5.JPG'), 'Paneer'),
  Foods(AssetImage('assets/images/8.JPG'), 'Cake'),
  Foods(AssetImage('assets/images/3.JPG'), 'Biryani'),
  Foods(AssetImage('assets/images/4.JPG'), 'Healthy'),
  Foods(AssetImage('assets/images/5.JPG'), 'Paneer'),
];

class Foods {
  final AssetImage image;
  final String name;

  Foods(this.image, this.name);
}
