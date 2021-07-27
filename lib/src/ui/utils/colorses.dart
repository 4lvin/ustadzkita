import 'package:flutter/material.dart';

class Colorses {
  final Color hijaudasar = Color(0xff229653);
  final Color hijaucerahg1 = Color(0xff31a34b);
  final Color hijaucerahg2 = Color(0xff39c157);
  final Color hijaucerahg3 = Color(0xff30a14a);
  final Color hijaupelet = Color(0xff1ABC9C);
  final Color biru1 = Color(0xff245684);
  final Color biru2 = Color(0xff223346);

// final List<Color> gradient = [Color(0xff9C1511), Colors.red];
  static Map<int, Color> color = {
    50: Color.fromRGBO(38, 174, 96, .1),
    100: Color.fromRGBO(38, 174, 96, .2),
    200: Color.fromRGBO(38, 174, 96, .3),
    300: Color.fromRGBO(38, 174, 96, .4),
    400: Color.fromRGBO(38, 174, 96, .5),
    500: Color.fromRGBO(38, 174, 96, .6),
    600: Color.fromRGBO(38, 174, 96, .7),
    700: Color.fromRGBO(38, 174, 96, .8),
    800: Color.fromRGBO(38, 174, 96, .9),
    900: Color.fromRGBO(38, 174, 96, 1),
  };

  MaterialColor colorCustom = MaterialColor(0xFF26AE60, color);

  // static final TextStyle kAppTitle = GoogleFonts.grandHotel(fontSize: 36);

  static final TextStyle heading2 = TextStyle(
    color: Color(0xff686795),
    fontSize: 18,
    fontWeight: FontWeight.w600,
    letterSpacing: 1.5,
  );

   final TextStyle bodyText1 =
      TextStyle(color: Color(0xffAEABC9), fontSize: 14, letterSpacing: 1.2, fontWeight: FontWeight.w500);

   final TextStyle bodyTextMessage = TextStyle(fontSize: 13, letterSpacing: 1.5, fontWeight: FontWeight.w600);

   final TextStyle bodyTextTime = TextStyle(
    color: Color(0xffAEABC9),
    fontSize: 11,
    fontWeight: FontWeight.bold,
    letterSpacing: 1,
  );
}

final colorses = Colorses();
