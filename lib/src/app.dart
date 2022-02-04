import 'package:daikita/src/ui/controllerPage.dart';
import 'package:daikita/src/ui/formAlamat.dart';
import 'package:daikita/src/ui/login.dart';
import 'package:daikita/src/ui/splashScreen.dart';
import 'package:daikita/src/ui/undanganSayaUstadz.dart';
import 'package:daikita/src/ui/utils/colorses.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: colorses.colorCustom),
      home: Scaffold(
        body: SplashScreen(),
      ),
      routes: <String,WidgetBuilder>{
        '/controllerPage': (BuildContext context)=> new ControllerPage(),
        '/login': (BuildContext context)=> new Login(),
        '/controllPage2':(BuildContext context)=> new ControllerPage(selected: 1,),
        '/formAlamat':(BuildContext context)=> new FormAlamat(),
        '/undanganSayaUstadz2':(BuildContext context)=> new UndanganSayaUstadz(index: 1,),
        '/undanganSayaUstadz3':(BuildContext context)=> new UndanganSayaUstadz(index: 2,),
        '/undanganSayaUstadz4':(BuildContext context)=> new UndanganSayaUstadz(index: 3,),
      },
    );
  }
}