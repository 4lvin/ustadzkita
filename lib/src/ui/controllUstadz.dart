
import 'package:daikita/src/pref/preferences.dart';
import 'package:daikita/src/ui/ustadz.dart';
import 'package:daikita/src/ui/undanganSayaUstadz.dart';
import 'package:flutter/material.dart';

class ControllUstadz extends StatefulWidget {
  @override
  _ControllUstadzState createState() => _ControllUstadzState();
}

class _ControllUstadzState extends State<ControllUstadz> {
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
      return Ustadz();
    } else if (tipe == "Ustadz") {
      return UndanganSayaUstadz(index: 0,);
    }else{
      return Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }
  }
}
