import 'package:daikita/src/blocs/fiturBloc.dart';
import 'package:daikita/src/blocs/memberBloc.dart';
import 'package:daikita/src/models/getJadwalUstadzModel.dart';
import 'package:daikita/src/models/getListUndanganModel.dart';
import 'package:daikita/src/pref/preferences.dart';
import 'package:daikita/src/resources/publicUrl.dart';
import 'package:daikita/src/ui/doaPilihan.dart';
import 'package:daikita/src/ui/jadwalSholat.dart';
import 'package:daikita/src/ui/kompasView.dart';
import 'package:daikita/src/ui/undanganSayaUstadz.dart';
import 'package:daikita/src/ui/utils/colorses.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:toast/toast.dart';

class BerandaUstadz extends StatefulWidget {
  @override
  _BerandaUstadzState createState() => _BerandaUstadzState();
}

class _BerandaUstadzState extends State<BerandaUstadz> {
  List<DaiService> _daiServiceList = [];
  String nama="";
  String fotos="";

  RefreshController _refreshController =
  RefreshController(initialRefresh: false);

  void _onRefresh() async {
    await Future.delayed(Duration(milliseconds: 1000));
    getToken().then((value) {
      blocFitur.listUndangan(value,"Pending");
      memberBloc.getProfil(value);
    });
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    getToken().then((value) {
      blocFitur.listUndangan(value,"Pending");
      memberBloc.getProfil(value);
    });
    _refreshController.loadComplete();
  }
  @override
  void initState() {
    _daiServiceList.add(DaiService(image: 'assets/mn_shalat.svg', title: "Jadwal Sholat"));
    _daiServiceList.add(DaiService(image: 'assets/mn_kiblatarah.svg', title: "Kiblat"));
    _daiServiceList.add(DaiService(image: 'assets/podium.svg', title: "Naskah Khutbah"));
    _daiServiceList.add(DaiService(image: 'assets/mn_hukum.svg', title: "Event"));
    getToken().then((value) {
      blocFitur.listUndangan(value,"Pending");
      memberBloc.getProfil(value);
    });
    memberBloc.resProfil.listen((value) {
      if(mounted)
        setState(() {
          nama = value.result[0].fullName;
          fotos = value.result[0].foto;
        });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SmartRefresher(
        enablePullDown: true,
        enablePullUp: false,
        controller: _refreshController,
        onRefresh: _onRefresh,
        onLoading: _onLoading,
        header: WaterDropMaterialHeader(
          backgroundColor: colorses.hijaucerahg1,
        ),
        child: ListView(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height / 2 - 100,
              color: Colors.white,
              child: Stack(
                children: <Widget>[
                  Container(
                    height: MediaQuery.of(context).size.height / 3,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [colorses.biru2, colorses.biru1]),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 40),
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(bottomRight: Radius.circular(0)),
                        child: SvgPicture.asset('assets/masjid.svg',
                            color: Colors.black45,
                            width: MediaQuery.of(context).size.width / 2 - 50,
                            height: 120,
                            fit: BoxFit.cover),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(50), color: colorses.hijaudasar,image: DecorationImage(
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
                            SizedBox(
                              height: 12,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Text(
                                "Halo",
                                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(
                              height: 12,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Text(
                                "$nama",
                                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                              ),
                            ),
                            // SizedBox(height: 8,),
                            // Text("Ashar, 14:43",style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold)),
                            // SizedBox(height: 8,),
                            // Text("Menuju Ashar",style: TextStyle(color: Colors.amber))
                          ],
                        ),
                        // Padding(
                        //   padding: const EdgeInsets.only(bottom:8.0),
                        //   child: Text("Selasa, 06 April 2021",style: TextStyle(color: Colors.white,fontSize: 12),),
                        // ),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: SafeArea(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Image.asset('assets/logo1.png', width: 180, height: 30, fit: BoxFit.cover),
                            Container(
                              width: 80,
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
                    child: Container(
                      height: 90,
                      width: MediaQuery.of(context).size.width - 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          image: DecorationImage(
                              image: AssetImage(
                                "assets/covid.png",
                              ),
                              fit: BoxFit.fill)),
                    ),
                  )
                ],
              ),
            ),
            // Text("Features"),
            _buildDaiServicesMenu(),
            SizedBox(
              height: 12,
            ),
            Container(
              padding: EdgeInsets.all(12),
              height: 200,
              width: MediaQuery.of(context).size.width,
              color: Colors.white,
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text("Undangan"),
                      Text("Selengkapnya"),
                    ],
                  ),
                  Expanded(
                    child: StreamBuilder(
                        stream: blocFitur.resUndanganList,
                        builder: (context, AsyncSnapshot<GetListUndanganModel> snapshot) {
                          if (snapshot.hasData) {
                            return snapshot.data.result.isEmpty
                                ? Center(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      //Image.asset("assets/imagelogin.png",scale: 3,),
                                      Text("Belum ada Undangan Masuk"),
                                    ],
                                  ))
                                : ListView.builder(
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    padding: EdgeInsets.only(top: 3),
                                    itemCount: snapshot.data.result.length < 5 ? snapshot.data.result.length : 5,
                                    itemBuilder: (BuildContext context, int i) {
                                      return InkWell(
                                        onTap: (){
                                          Navigator.push(
                                              context,
                                              PageTransition(
                                                  type: PageTransitionType.rightToLeft,
                                                  duration: Duration(milliseconds: 200),
                                                  child: UndanganSayaUstadz(index: 0,)));
                                        },
                                        child: Container(
                                            margin: EdgeInsets.only(left: 12),
                                            padding: EdgeInsets.all(12),
                                            width: MediaQuery.of(context).size.width - 80,
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.black)),
                                            child: Stack(
                                              children: <Widget>[
                                                Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Text(snapshot.data.result[i].jenis,style: TextStyle(fontWeight: FontWeight.bold),),
                                                    SizedBox(height: 12,),
                                                    Text(snapshot.data.result[i].tema,style: TextStyle(color: Colors.grey),),
                                                    SizedBox(height: 8,),
                                                    Container(
                                                      width: 200,
                                                        child: Text("Lokasi : "+snapshot.data.result[i].lokasi,style: TextStyle(color: Colors.black),)),
                                                  ],
                                                ),
                                                Align(
                                                  alignment: Alignment.topRight,
                                                  child: Container(
                                                    width: 100,
                                                    height: 100,
                                                    decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(12), color: colorses.biru2),
                                                    child: Column(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: <Widget>[
                                                        Text(
                                                          "${DateFormat('EEEE',"id_ID").format(snapshot.data.result[i].tanggal)}",
                                                          style: TextStyle(color: Colors.white,fontSize: 16),
                                                        ),
                                                        Text(
                                                          "${snapshot.data.result[i].tanggal.day}",
                                                          style: TextStyle(color: Colors.white,fontSize: 18),
                                                        ),
                                                        Text(
                                                          "${DateFormat('MMMM',"id_ID").format(snapshot.data.result[i].tanggal)}",
                                                          style: TextStyle(color: Colors.white,fontSize: 16),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                )
                                              ],
                                            )),
                                      );
                                    });
                          } else {
                            return Center(child: CircularProgressIndicator());
                          }
                        }),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 12,
            ),
            Container(
              height: 200,
              width: MediaQuery.of(context).size.width,
              color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Text("Postingan Anda"),
                  ),
                  Center(
                    child: Container(
                      height: 130,
                      width: MediaQuery.of(context).size.width - 100,
                      color: Colors.white,
                      child: Image.asset(
                        "assets/quote-logo.png",
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  //Build menu
  Widget _buildDaiServicesMenu() {
    return new SizedBox(
        width: double.infinity,
        height: 150,
        child: new Container(
            color: Colors.white,
            margin: EdgeInsets.only(top: 0.0, bottom: 0.0),
            padding: EdgeInsets.only(top: 14, left: 12, right: 12),
            child: GridView.builder(
                padding: EdgeInsets.zero,
                physics: ClampingScrollPhysics(),
                itemCount: 4,
                gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4, mainAxisSpacing: 20),
                itemBuilder: (context, position) {
                  return _rowSafiraService(_daiServiceList[position]);
                })));
  }

  //Build row item menu
  Widget _rowSafiraService(DaiService daiService) {
    return InkWell(
      onTap: () {
        if (daiService.title == "Tanya Ustadz") {
          Navigator.of(context).pushNamedAndRemoveUntil('/controllPage2', (Route<dynamic> route) => false);
        } else if (daiService.title == "Jadwal Sholat") {
          Navigator.push(context,
              PageTransition(type: PageTransitionType.rightToLeft, duration: Duration(milliseconds: 200), child: JadwalSholat()));
        } else if (daiService.title == "Kiblat") {
          Navigator.push(context,
              PageTransition(type: PageTransitionType.rightToLeft, duration: Duration(milliseconds: 200), child: CompassView()));
        } else if (daiService.title == "Naskah Khutbah") {
          Navigator.push(context,
              PageTransition(type: PageTransitionType.rightToLeft, duration: Duration(milliseconds: 200), child: DoaPilihan(kode: 'SoTgPpOaWT',label: "Naskah Khutbah",)));
        } else {
          Toast.show("Fitur dalam pengembangan", context,
              duration: Toast.LENGTH_LONG, gravity: Toast.CENTER);
          // Navigator.push(
          //     context,
          //     PageTransition(
          //         type: PageTransitionType.rightToLeft, duration: Duration(milliseconds: 400), child: ProdukPage(param: "%")));
        }
        // print(safiraService.title);
      },
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                  color: colorses.biru2,
                  border: Border.all(color: Colors.grey[200], width: 1.0),
                  borderRadius: new BorderRadius.all(new Radius.circular(20.0)),
                  boxShadow: [BoxShadow(color: Colors.grey[200], spreadRadius: 0.3, blurRadius: 0.3, offset: Offset(0, 3))]),
              child: Container(
                height: 24,
                width: 24,
                child: new SvgPicture.asset(
                  daiService.image,
                  color: Colors.white,
                  //size: 32.0,
                ),
              ),
            ),
            new Padding(
              padding: EdgeInsets.only(top: 6.0),
            ),
            Container(
                width: 60,
                child: Center(
                    child: new Text(
                  daiService.title,
                  style: new TextStyle(fontSize: 12.0, color: daiService.title == "Lainnya" ? Colors.grey : Colors.black),
                  textAlign: TextAlign.center,
                ))),
          ],
        ),
      ),
    );
  }
}

//Model menu
class DaiService {
  String image;
  String title;

  DaiService({this.image, this.title});
}
