import 'dart:async';

import 'package:daikita/src/pref/preferences.dart';
import 'package:daikita/src/ui/utils/colorses.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String token;

  @override
  void initState() {
    getToken().then((value) {
      setState(() {
        if (value == null) {
          token = "0";
        } else {
          token = value;
        }
      });
    });
    Timer(Duration(seconds: 2), () {
      token == "0"
          ? Navigator.pushReplacementNamed(context, '/login')
          : Navigator.pushReplacementNamed(context, '/controllerPage');
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: colorses.colorCustom[900],
        // decoration: BoxDecoration(
        // gradient: LinearGradient(
        //     begin: Alignment.topCenter,
        //     end: Alignment.bottomCenter,
        //     colors: [Color(0xff89E5DF), Color(0xff319C95)])
        // ),
        child: Stack(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height,
              child: Column(
                children: <Widget>[
                  Container(
                      height: MediaQuery.of(context).size.height / 3,
                      child: SvgPicture.asset(
                        'assets/bg.svg',
                        color: Colors.greenAccent[700],
                        fit: BoxFit.cover,
                      )),
                  Container(
                      height: MediaQuery.of(context).size.height / 3,
                      child: SvgPicture.asset(
                        'assets/bg.svg',
                        color: Colors.greenAccent[700],
                        fit: BoxFit.cover,
                      )),
                  Container(
                      height: MediaQuery.of(context).size.height / 3,
                      child: SvgPicture.asset(
                        'assets/bg.svg',
                        color: Colors.greenAccent[700],
                        fit: BoxFit.cover,
                      )),
                ],
              ),
            ),
            Center(
              child: Container(width: 150, height: 150, child: Image.asset('assets/logo.png')),
            ),
          ],
        ),
      ),
    );
  }
}
