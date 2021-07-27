import 'package:daikita/src/pref/preferences.dart';
import 'package:daikita/src/ui/beranda.dart';
import 'package:daikita/src/ui/berandaUstadz.dart';
import 'package:daikita/src/ui/controllHome.dart';
import 'package:daikita/src/ui/controllUstadz.dart';
import 'package:daikita/src/ui/pesan.dart';
import 'package:daikita/src/ui/profile.dart';
import 'package:daikita/src/ui/ustadz.dart';
import 'package:daikita/src/ui/utils/colorses.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

class ControllerPage extends StatefulWidget {
  ControllerPage({this.selected});

  int selected;

  @override
  _ControllerPageState createState() => _ControllerPageState();
}

class _ControllerPageState extends State<ControllerPage> {
  int _selectedIndex;
  final PageStorageBucket bucket = PageStorageBucket();
  DateTime currentBackPressTime;
  String tipe;
  final List<Widget> _widgetOptions = [
    ControllHome(),
    ControllUstadz(),
    Pesan(),
    Profile(),
  ];

  Future<bool> _onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null || now.difference(currentBackPressTime) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      Toast.show("Tekan sekali lagi untuk keluar", context, duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      return Future.value(false);
    }
    return Future.value(true);
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    widget.selected == null ? _selectedIndex = 0 : _selectedIndex = widget.selected;
    getTipe().then((value) {
      setState(() {
        tipe = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(child: PageStorage(bucket: bucket, child: _widgetOptions[_selectedIndex]), onWillPop: _onWillPop),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Beranda'),
          ),
          tipe == "Guest"
              ? BottomNavigationBarItem(
                  icon: Icon(Icons.search),
                  title: Text('Cari Ustadz'),
                )
              : BottomNavigationBarItem(
                  icon: Icon(Icons.content_paste),
                  title: Text('Undangan'),
                ),
          BottomNavigationBarItem(
            icon: Icon(Icons.mail_outline),
            title: Text('Pesan'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            title: Text('Profile'),
          ),
        ],
        elevation: 16,
        unselectedItemColor: const Color(0xFFbdbfbe),
        backgroundColor: Colors.white,
        currentIndex: _selectedIndex,
        selectedItemColor: Colorses().hijaudasar,
        onTap: _onItemTapped,
      ),
    );
  }
}
