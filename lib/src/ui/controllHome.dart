import 'package:daikita/src/pref/preferences.dart';
import 'package:daikita/src/ui/beranda.dart';
import 'package:daikita/src/ui/berandaUstadz.dart';
import 'package:flutter/material.dart';

class ControllHome extends StatefulWidget {
  @override
  _ControllHomeState createState() => _ControllHomeState();
}

class _ControllHomeState extends State<ControllHome> {
  String tipe;

  @override
  void initState() {
    getTipe().then((value) {
      setState(() {
        tipe = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (tipe == "Guest") {
      return Beranda();
    } else if (tipe == "Ustadz") {
      return BerandaUstadz();
    }else{
      return Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }
  }
}
