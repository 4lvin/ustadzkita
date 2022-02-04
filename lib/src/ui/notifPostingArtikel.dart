import 'package:daikita/src/models/getUndanganModel.dart';
import 'package:daikita/src/resources/publicUrl.dart';
import 'package:daikita/src/ui/utils/colorses.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class NotifPostArtikel extends StatefulWidget {

  @override
  _NotifPostArtikelState createState() => _NotifPostArtikelState();
}

class _NotifPostArtikelState extends State<NotifPostArtikel> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorses.hijaucerahg3,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height / 6 - 20,
              color: colorses.hijaucerahg3,
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
                          colors: [colorses.colorCustom[100], colorses.hijaucerahg3]),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: SafeArea(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "Posting Artikel",
                              style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Center(
              child: Container(
                width: MediaQuery.of(context).size.width - 60,
                child: Image.asset("assets/posting.png"),
              ),
            ),
            SizedBox(
              height: 18,
            ),
            Center(
              child: Container(
                  width: MediaQuery.of(context).size.width - 80,
                  child: Center(
                      child: Text(
                        "Artikel Anda akan di tinjau dan segera di publikasikan",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white,fontSize: 16),
                      ))),
            ),
            SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: (){
                Navigator.of(context)
                    .pushNamedAndRemoveUntil('/controllerPage', (Route<dynamic> route) => false);
              },
              child: Center(
                child: Container(
                    width: MediaQuery.of(context).size.width - 80,
                    height: 50,
                    decoration: BoxDecoration(
                        color: colorses.biru2,
                        borderRadius: BorderRadius.circular(8)
                    ),
                    child: Center(
                        child: Text(
                          "Kembali",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white,fontSize: 16),
                        ))),
              ),
            )
          ],
        ),
      ),
    );
  }
}
