import 'package:daikita/src/blocs/fiturBloc.dart';
import 'package:daikita/src/pref/preferences.dart';
import 'package:daikita/src/ui/utils/colorses.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class JadwalSholat extends StatefulWidget {
  @override
  _JadwalSholatState createState() => _JadwalSholatState();
}

class _JadwalSholatState extends State<JadwalSholat> with TickerProviderStateMixin {

  var now = new DateTime.now();
  var formatter = new DateFormat('yyyy-MM-dd');
  int kota = 760;
  String tgl;
  String tglMasehi;
  String imsak;
  String subuh;
  String terbit;
  String duha;
  String zuhur;
  String ashar;
  String maghrib;
  String isya;
  var selisih;
  var m;
  DateTime jam;
  AnimationController controller;
  DateTime sekarang;

  String waktu;
  String sholat;
  // hitungselisih(maghrib) {
  //   // DateTime magh = DateTime.parse('${formatter.format(now)} $maghrib');
  //
  // }
  @override
  void initState() {
    if(mounted)
    setState(() {
      tgl = formatter.format(now);
    });
    blocFitur.getJadwalSholat(kota, tgl);
    blocFitur.resJadwalSholat.listen((value) {
      if(mounted)
      setState(() {
        imsak = value.jadwal.data.imsak;
        subuh = value.jadwal.data.subuh;
        terbit = value.jadwal.data.terbit;
        duha = value.jadwal.data.dhuha;
        zuhur = value.jadwal.data.dzuhur;
        ashar = value.jadwal.data.ashar;
        maghrib = value.jadwal.data.maghrib;
        isya = value.jadwal.data.isya;
        tglMasehi = value.jadwal.data.tanggal;
      });
    });
    getKota().then((value) async{
      final DateFormat formatter = DateFormat('HH:mm');
      final DateFormat formatterDate = DateFormat('yyyy-MM-dd');
      jam = DateTime(now.year, now.month, now.day, now.hour, now.minute);
      blocFitur.jadwalSholatTerdekat(formatter.format(jam), value, formatterDate.format(DateTime.now()));
    });
    blocFitur.resJadwalTerdekat.listen((value) {
      var parsedEndDate = DateTime.parse('${formatter.format(now)} ${value.result.waktu}');
      if(mounted)
      setState(() {
        waktu = value.result.waktu;
        sholat = value.result.sholat;
        m = parsedEndDate.difference(sekarang).inMinutes;
        selisih = parsedEndDate.difference(sekarang).inHours;
        controller = AnimationController(
            vsync: this,
            duration: Duration(
                hours: selisih,
                minutes: m - selisih * 60,
                seconds: parsedEndDate.second));
        controller.reverse(
            from: controller.value == 0.0 ? 1.0 : controller.value);
        print("selisih");
        print(selisih);
      });
    });
    super.initState();
  }

  String get timerString {
    Duration duration = controller.duration * controller.value;
    return '${duration.inHours} : ${duration.inMinutes - selisih * 60} : ${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
  }

  @override
  void dispose() {
    if (controller != null) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      sekarang = new DateTime.now();
    });
    return Scaffold(
      body: SlidingUpPanel(
        parallaxEnabled: true,
        color: colorses.biru2,
        parallaxOffset: .3,
        minHeight: MediaQuery.of(context).size.height/4 + 50,
        borderRadius: BorderRadius.only(topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0)),

        panelBuilder:(sc){
            return Container(
              margin: EdgeInsets.only(top: 50),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(topRight: Radius.circular(20),topLeft: Radius.circular(20)),
                gradient: LinearGradient(
                    begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [colorses.biru2, colorses.biru1]),
              ),
              child: ListView(
                controller: sc,
                shrinkWrap: true,
                padding: EdgeInsets.symmetric(horizontal: 20),
                children: <Widget>[
                  // Container()
                  Container(
                    width: 200,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Text("Imsak",style: TextStyle(color: Colors.white),),
                        Text("$imsak",style: TextStyle(color: Colors.white)),
                        Container(
                          width: 70,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Icon(Icons.notifications_none,color: Colors.white,),
                              Icon(Icons.volume_up,color: Colors.white,),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 35),
                    width: 200,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Text("Subuh",style: TextStyle(color: Colors.white),),
                        Text("$subuh",style: TextStyle(color: Colors.white)),
                        Container(
                          width: 70,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Icon(Icons.notifications_none,color: Colors.white,),
                              Icon(Icons.volume_up,color: Colors.white,),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 35),
                    width: 200,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Text("Terbit",style: TextStyle(color: Colors.white),),
                        Text("$terbit",style: TextStyle(color: Colors.white)),
                        Container(
                          width: 70,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Icon(Icons.notifications_none,color: Colors.white,),
                              Icon(Icons.volume_up,color: Colors.white,),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 35),
                    width: 200,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Text("Dhuha",style: TextStyle(color: Colors.white),),
                        Text("$duha",style: TextStyle(color: Colors.white)),
                        Container(
                          width: 70,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Icon(Icons.notifications_none,color: Colors.white,),
                              Icon(Icons.volume_up,color: Colors.white,),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 35),
                    width: 200,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Text("Dzuhur",style: TextStyle(color: Colors.white),),
                        Text("$zuhur",style: TextStyle(color: Colors.white)),
                        Container(
                          width: 70,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Icon(Icons.notifications_none,color: Colors.white,),
                              Icon(Icons.volume_up,color: Colors.white,),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 35),
                    width: 200,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Text("Ashar",style: TextStyle(color: Colors.white),),
                        Text("$ashar",style: TextStyle(color: Colors.white)),
                        Container(
                          width: 70,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Icon(Icons.notifications_none,color: Colors.white,),
                              Icon(Icons.volume_up,color: Colors.white,),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 35),
                    width: 200,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Text("Maghrib",style: TextStyle(color: Colors.white),),
                        Text("$maghrib",style: TextStyle(color: Colors.white)),
                        Container(
                          width: 70,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Icon(Icons.notifications_none,color: Colors.white,),
                              Icon(Icons.volume_up,color: Colors.white,),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 35),
                    width: 200,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Text("Isya",style: TextStyle(color: Colors.white),),
                        Text("$isya",style: TextStyle(color: Colors.white)),
                        Container(
                          width: 70,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Icon(Icons.notifications_none,color: Colors.white,),
                              Icon(Icons.volume_up,color: Colors.white,),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
        },
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [colorses.biru2, colorses.biru1]),
          ),
          child: Stack(
            children: <Widget>[
              Align(
                alignment: Alignment.centerRight,
                child: SvgPicture.asset('assets/masjid.svg',
                    color: Colors.black45,
                    alignment: Alignment.centerLeft,
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height/2,
                    fit: BoxFit.cover),
              ),
              Column(
                  children: <Widget>[
                    SafeArea(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            InkWell(
                              onTap: (){
                                Navigator.of(context).pop();
                              },
                              child: Icon(
                                Icons.arrow_back_ios,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "JADWAL SHALAT",
                              style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            Icon(Icons.settings, color: Colors.white)
                          ],
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 20),
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(Icons.location_on,color: Colors.white,size: 30,),
                          Text("  LOKASI",style: TextStyle(color: Colors.white,fontSize: 18),)
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 50),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(150),
                          color: colorses.colorCustom[200]
                      ),
                      width: 190,
                      height: 190,
                      child: Stack(
                        children: <Widget>[
                          Center(
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(150),
                                  color: colorses.colorCustom[500]
                              ),
                              width: 170,
                              height: 170,
                            ),
                          ),
                          Center(
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(150),
                                  color: Colors.white
                              ),
                              width: 140,
                              height: 140,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  AnimatedBuilder(
                                      animation: controller,
                                      builder: (BuildContext context, Widget child) {
                                        return Text(
                                          "$timerString",
                                          style: TextStyle(
                                              fontSize: 16.0,
                                              color: Colors.red,
                                              fontWeight: FontWeight.bold),
                                        );
                                      }),
                                  Container(
                                    margin: EdgeInsets.only(top: 12),
                                    width: 80,
                                      child: Center(child: Text("$selisih jam $m menit Menuju $sholat",style: TextStyle(color: Colors.black,fontSize: 12),textAlign: TextAlign.center,)))
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 40),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.orange
                      ),
                      width: 150,
                      height: 40,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          SvgPicture.asset('assets/ic_kiblat.svg',
                              color: Colors.white,
                              alignment: Alignment.center,
                              width: 25,
                              height: 25,
                              fit: BoxFit.cover),
                          Text("ARAH KIBLAT",style: TextStyle(color: Colors.white),),
                          Icon(Icons.arrow_forward_ios,size: 14,color: Colors.white,)
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 30),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.white24
                      ),
                      width: MediaQuery.of(context).size.width-100,
                      height: 50,
                      padding: EdgeInsets.only(left: 12,right: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Icon(Icons.arrow_back_ios,size: 14,color: Colors.white,),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text("$tglMasehi",style: TextStyle(color: Colors.amber),),
                              Text("Hijriah",style: TextStyle(color: Colors.white,fontSize: 14),),
                            ],
                          ),
                          Icon(Icons.arrow_forward_ios,size: 14,color: Colors.white,)
                        ],
                      ),
                    ),
                  ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
