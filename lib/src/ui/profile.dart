import 'package:daikita/src/blocs/memberBloc.dart';
import 'package:daikita/src/pref/preferences.dart';
import 'package:daikita/src/resources/publicUrl.dart';
import 'package:daikita/src/ui/doaPilihan.dart';
import 'package:daikita/src/ui/formGantiPassword.dart';
import 'package:daikita/src/ui/pesan.dart';
import 'package:daikita/src/ui/profileUstadzArtikel.dart';
import 'package:daikita/src/ui/undanganSaya.dart';
import 'package:daikita/src/ui/undanganSayaUstadz.dart';
import 'package:daikita/src/ui/updateProfile.dart';
import 'package:daikita/src/ui/utils/colorses.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:page_transition/page_transition.dart';
import 'package:toast/toast.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String nama="";
  String telp;
  String alamat;
  String fotos = "";
  String tipe="";

  @override
  void initState() {
    getToken().then((value){
      memberBloc.getProfil(value);
    });
    memberBloc.resProfil.listen((value) {
      if(mounted)
      setState(() {
        nama = value.result[0].fullName;
        fotos = value.result[0].foto;
      });
    });
    getTelp().then((value){
      setState(() {
        telp = value;
      });
    });
    getAlamat().then((value) {
      setState(() {
        alamat = value;
      });
    });
    getTipe().then((value){
      if(mounted)
      setState(() {
        tipe = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.grey[200],
        child: Column(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height / 4,
              color: Colors.grey[200],
              child: Stack(
                children: <Widget>[
                  Container(
                    height: MediaQuery.of(context).size.height / 4 - 50,
                    color: colorses.hijaudasar,
                    child: Stack(
                      children: <Widget>[
                        SvgPicture.asset('assets/bg.svg',
                            color: Colors.green,
                            alignment: Alignment.center,
                            width: MediaQuery.of(context).size.width,
                            fit: BoxFit.cover),
                        Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [colorses.colorCustom[100], colorses.hijaudasar]),
                          ),
                        )
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: SafeArea(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Text(""),
                            Text(
                              "Profil",
                              style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            Container(
                              // width: 80,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  // Icon(
                                  //   Icons.notifications,
                                  //   color: Colors.white,
                                  //   size: 30,
                                  // ),
                                  // Icon(Icons.settings, color: Colors.white)
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: InkWell(
                      onTap: (){
                        Navigator.push(context,
                            PageTransition(type: PageTransitionType.rightToLeft, duration: Duration(milliseconds: 200), child: UpdateProfile()));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.white,
                        ),
                        height: 100,
                        width: MediaQuery.of(context).size.width - 50,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Container(
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(50), color: colorses.hijaudasar,
                              image: DecorationImage(
                                image: NetworkImage('${urlVps + fotos}'),
                                fit: BoxFit.cover,
                              )),
                              width: 70,
                              height: 70,
                              // child: Icon(
                              //   Icons.person,
                              //   size: 60,
                              //   color: Colors.white,
                              // ),
                            ),
                            Container(
                              width: 180,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    "$nama",
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  Text(
                                    "$alamat",
                                    style: TextStyle(fontSize: 14, color: Colors.grey),
                                  ),
                                  Text(
                                    "$telp",
                                    style: TextStyle(fontSize: 14, color: Colors.grey),
                                  )
                                ],
                              ),
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              size: 16,
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 18,
            ),
            InkWell(
              onTap: () {
                    Navigator.push(
                        context,
                        PageTransition(
                            type: PageTransitionType.rightToLeft,
                            duration: Duration(milliseconds: 200),
                            child: GantiPassword()));
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Colors.white,
                ),
                height: 55,
                width: MediaQuery.of(context).size.width - 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Icon(Icons.vpn_key),
                    Container(
                      width: 200,
                      child: Text(
                        "Ganti Password",
                        textAlign: TextAlign.left,
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 16,
                    )
                  ],
                ),
              ),
            ),
            Container(
                margin: EdgeInsets.only(left: 30),
                width: MediaQuery.of(context).size.width,
                child: Text(
                  "Event Aplikasi",
                  style: TextStyle(fontWeight: FontWeight.bold),
                )),
            SizedBox(
              height: 18,
            ),
            InkWell(
              onTap: () {
                getTipe().then((value) {
                  if (value == "Guest") {
                    Navigator.push(
                        context,
                        PageTransition(
                            type: PageTransitionType.rightToLeft, duration: Duration(milliseconds: 200), child: UndanganSaya()));
                  } else {
                    Navigator.push(
                        context,
                        PageTransition(
                            type: PageTransitionType.rightToLeft,
                            duration: Duration(milliseconds: 200),
                            child: ProfileUstadzArtikel(nama: nama,noHp: telp,kecamatan: alamat,image: fotos,)));
                  }
                });
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Colors.white,
                ),
                height: 55,
                width: MediaQuery.of(context).size.width - 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Icon(Icons.mail_outline),
                    Container(
                      width: 200,
                      child: Text(
                        "${tipe=="Guest"?"Undangan Saya":"Artikel Saya"}",
                        textAlign: TextAlign.left,
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 16,
                    )
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: (){
                Navigator.push(
                    context,
                    PageTransition(
                        type: PageTransitionType.rightToLeft,
                        duration: Duration(milliseconds: 200),
                        child: Pesan()));
              },
              child: Container(
                margin: EdgeInsets.only(top: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Colors.white,
                ),
                height: 55,
                width: MediaQuery.of(context).size.width - 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Icon(Icons.message),
                    Container(
                      width: 200,
                      child: Text(
                        "Chat",
                        textAlign: TextAlign.left,
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 16,
                    )
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    PageTransition(
                        type: PageTransitionType.rightToLeft,
                        duration: Duration(milliseconds: 200),
                        child: DoaPilihan(
                          kode: 'wFcYshwvZG',
                          label: "Do'a Pilihan",
                        )));
              },
              child: Container(
                margin: EdgeInsets.only(top: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Colors.white,
                ),
                height: 55,
                width: MediaQuery.of(context).size.width - 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Icon(Icons.done_outline),
                    Container(
                      width: 200,
                      child: Text(
                        "Do'a-Do'a Pilihan",
                        textAlign: TextAlign.left,
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 16,
                    )
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    PageTransition(
                        type: PageTransitionType.rightToLeft,
                        duration: Duration(milliseconds: 200),
                        child: DoaPilihan(
                          kode: 'oqkuxtSvHk',
                          label: "Hukum Islam",
                        )));
              },
              child: Container(
                margin: EdgeInsets.only(top: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Colors.white,
                ),
                height: 55,
                width: MediaQuery.of(context).size.width - 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Icon(Icons.content_paste),
                    Container(
                      width: 200,
                      child: Text(
                        "Hukum Islam",
                        textAlign: TextAlign.left,
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 16,
                    )
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: (){
                Toast.show("Fitur dalam pengembangan", context,
                    duration: Toast.LENGTH_LONG, gravity: Toast.CENTER);
              },
              child: Container(
                margin: EdgeInsets.only(top: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Colors.white,
                ),
                height: 55,
                width: MediaQuery.of(context).size.width - 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Icon(Icons.warning),
                    Container(
                      width: 200,
                      child: Text(
                        "Lapor",
                        textAlign: TextAlign.left,
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 16,
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            InkWell(
              onTap: () {
                rmvToken();
                rmvAlamat();
                rmvTelp();
                Navigator.pushReplacementNamed(context, "/login");
              },
              child: Container(
                margin: EdgeInsets.only(top: 5),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16), color: Colors.red[100], border: Border.all(color: Colors.red)),
                height: 55,
                width: MediaQuery.of(context).size.width - 50,
                child: Center(
                    child: Text(
                  "Logout",
                  style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: 18),
                )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
