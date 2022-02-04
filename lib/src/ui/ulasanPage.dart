import 'package:daikita/src/blocs/fiturBloc.dart';
import 'package:daikita/src/pref/preferences.dart';
import 'package:daikita/src/ui/utils/colorses.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class UlasanPage extends StatefulWidget {
  UlasanPage({this.nama,this.kode});
  String nama;
  String kode;

  @override
  _UlasanPageState createState() => _UlasanPageState();
}

class _UlasanPageState extends State<UlasanPage> {
  double rating = 0;
  var _komentar = TextEditingController();
  String token;

  @override
  void initState() {
    getToken().then((value){
      if(mounted)
        setState(() {
          token = value;
        });
    });
    super.initState();
  }
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
                              "Undangan Saya",
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
                child: Stack(
                  children: <Widget>[
                    Image.asset("assets/tiketulasan.png"),
                    Positioned(
                      top: 170,
                      child: Container(
                        width: MediaQuery.of(context).size.width - 80,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.only(left: 12),
                                  height: 80,
                                  width: 80,
                                  decoration: BoxDecoration(color: Colors.grey, borderRadius: BorderRadius.circular(12)),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        "Ustadz Pilihan Anda",
                                        style: TextStyle(color: Colors.grey),
                                      ),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      Text("${widget.nama}"),
                                      SizedBox(
                                        height: 12,
                                      ),
                                      Text(
                                        "Penceramah",
                                        style: TextStyle(color: Colors.orange),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 21,
                            ),
                            Text("Berikan Penilaian Pengalaman Anda",style: TextStyle(color: Colors.grey),),
                            SizedBox(
                              height: 21,
                            ),
                            Center(
                              child: SmoothStarRating(
                                  allowHalfRating: false,
                                  onRated: (v) {
                                    setState(() {
                                        rating = v;
                                    });
                                  },
                                  starCount: 5,
                                  rating: rating,
                                  size: 40.0,
                                  isReadOnly:false,
                                  color: Colors.amber,
                                  borderColor: Colors.amber,
                                  spacing:0.0
                              ),
                            ),
                            SizedBox(
                              height: 21,
                            ),
                            Text("Komentar Anda",style: TextStyle(fontWeight: FontWeight.bold),),
                            Container(
                              width: MediaQuery.of(context).size.width - 100,
                              height: 100,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(width: 1, color: Colors.black),
                              ),
                              child: TextField(
                                controller: _komentar,
                                decoration: InputDecoration(
                                    // border: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: BorderSide.none),
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  disabledBorder: InputBorder.none,
                                  // labelText: 'Komentar',
                                  hintText: 'Komentar',
                                  hintStyle: TextStyle(fontSize: 16.0, color: Colors.grey),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Center(
              child: InkWell(
                onTap: (){
                  blocFitur.ulasan(token, widget.kode, rating.toInt().toString(), _komentar.text);
                  Navigator.of(context)
                      .pushNamedAndRemoveUntil('/controllerPage', (Route<dynamic> route) => false);
                },
                child: Container(
                    width: MediaQuery.of(context).size.width - 80,
                    height: 50,
                    decoration: BoxDecoration(
                        color: colorses.biru2,
                        borderRadius: BorderRadius.circular(8)
                    ),
                    child: Center(
                        child: Text(
                          "Kirim Ulasan",
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
