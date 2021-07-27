import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:daikita/src/blocs/fiturBloc.dart';
import 'package:daikita/src/blocs/memberBloc.dart';
import 'package:daikita/src/models/getBannerQuotesModel.dart';
import 'package:daikita/src/models/getBannerTengahModel.dart';
import 'package:daikita/src/pref/preferences.dart';
import 'package:daikita/src/ui/doaPilihan.dart';
import 'package:daikita/src/ui/jadwalSholat.dart';
import 'package:daikita/src/ui/kompasView.dart';
import 'package:daikita/src/ui/utils/colorses.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shimmer/shimmer.dart';

class Beranda extends StatefulWidget {
  @override
  _BerandaState createState() => _BerandaState();
}

class _BerandaState extends State<Beranda> {
  List<DaiService> _daiServiceList = [];
  String nama;
  String waktu;
  String sholat;
  DateTime jam;
  var now = DateTime.now();
  int _current = 0;
  String bannerATas = "";

  @override
  void initState() {
    _daiServiceList.add(DaiService(image: 'assets/mn_tanyadai.svg', title: "Tanya Ustadz"));
    _daiServiceList.add(DaiService(image: 'assets/mn_shalat.svg', title: "Jadwal Sholat"));
    _daiServiceList.add(DaiService(image: 'assets/mn_kiblatarah.svg', title: "Kiblat"));
    _daiServiceList.add(DaiService(image: 'assets/mn_lapor.svg', title: "Tabayyun"));
    _daiServiceList.add(DaiService(image: 'assets/mn_doa.svg', title: "Do'a Pilihan"));
    _daiServiceList.add(DaiService(image: 'assets/mn_hukum.svg', title: "Hukum Islam"));
    _daiServiceList.add(DaiService(image: 'assets/podium.svg', title: "Naskah Khutbah"));
    _daiServiceList.add(DaiService(image: 'assets/mn_lapor.svg', title: "Lainnya"));
    getNama().then((value) {
      setState(() {
        nama = value;
      });
    });
    memberBloc.bannerQuotes();
    memberBloc.bannerTengah();
    memberBloc.bannerAtas();
    memberBloc.resBannerAtas.listen((value) {
      if(mounted)
        setState(() {
          bannerATas = value.result.image;
        });
    });
    getKota().then((value) async{
      final DateFormat formatter = DateFormat('HH:mm');
      final DateFormat formatterDate = DateFormat('yyyy-MM-dd');
      jam = DateTime(now.year, now.month, now.day, now.hour, now.minute);
      blocFitur.jadwalSholatTerdekat(formatter.format(jam), value, formatterDate.format(DateTime.now()));
    });
    blocFitur.resJadwalTerdekat.listen((value) {
      if(mounted)
        setState(() {
          waktu = value.result.waktu;
          sholat = value.result.sholat;
        });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height / 3,
              color: Colors.white,
              child: Stack(
                children: <Widget>[
                  Container(
                    height: MediaQuery.of(context).size.height / 3 - 50,
                    color: Colors.grey,
                    child: Image.network(
                      "http://185.201.9.208/$bannerATas",
                      fit: BoxFit.cover,
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height / 3 - 50,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [Colors.black, Colors.black12]),
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
                                  Icon(
                                    Icons.notifications,
                                    color: Colors.white,
                                    size: 30,
                                  ),
                                  Icon(Icons.settings, color: Colors.white)
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
                      height: 100,
                      width: MediaQuery.of(context).size.width - 50,
                      child: Stack(
                        children: <Widget>[
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [colorses.biru2, colorses.biru1]),
                            ),
                            height: 100,
                            width: MediaQuery.of(context).size.width - 50,
                          ),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: ClipRRect(
                              borderRadius: BorderRadius.only(bottomRight: Radius.circular(12)),
                              child: SvgPicture.asset('assets/masjid.svg',
                                  color: Colors.black45, width: 120, height: 80, fit: BoxFit.cover),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 12),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                        width: 174,
                                        child: Text(
                                          "Halo, $nama",
                                          style: TextStyle(color: Colors.white),
                                          overflow: TextOverflow.ellipsis,
                                        )),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Text("$sholat, $waktu",
                                        style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Text("Menuju $sholat", style: TextStyle(color: Colors.amber))
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 8.0),
                                  child: Text(
                                    "${DateFormat('EEEE', "id_ID").format(DateTime.now())}, ${DateTime.now().day} ${DateFormat('MMMM', "id_ID").format(DateTime.now())} 2021",
                                    style: TextStyle(color: Colors.white, fontSize: 12),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            _buildDaiServicesMenu(),
            SizedBox(
              height: 12,
            ),
            Container(
              height: 100,
              width: MediaQuery.of(context).size.width,
              // decoration: BoxDecoration(
              //   borderRadius: BorderRadius.circular(12),
              color: Colors.white,
              // ),
              padding: EdgeInsets.only(left: 30, right: 30, top: 12, bottom: 12),
              child: StreamBuilder(
                  stream: memberBloc.resBannerTengah,
                  builder: (context, AsyncSnapshot<GetBannerTengahModel> snapshot) {
                    if(snapshot.hasData){
                      return Container(
                        //margin: EdgeInsets.only(top: 8),
                        height: 100,
                        child: CarouselSlider(
                          height: 80,
                          initialPage: 0,
                          autoPlay: false,
                          enlargeCenterPage: true,
                          viewportFraction: 0.95,
                          enableInfiniteScroll: false,
                          // autoPlayInterval: Duration(seconds: 5),
                          onPageChanged: (index) {
                            setState(() {
                              _current = index;
                            });
                          },
                          items: snapshot.data.result.map((imgUrl) {
                            return Builder(builder: (BuildContext context) {
                              return InkWell(
                                onTap: (){
                                  // print(imgUrl.bannerExt);
                                  // if(imgUrl.bannerExt=="0"){
                                  //   Navigator.push(
                                  //       context, SlideLeftRoute(page: DetailProjectPage(id: imgUrl.idProject)));
                                  // }else{
                                  //   _launchURL(imgUrl.url);
                                  // }
                                },
                                child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    margin: EdgeInsets.symmetric(horizontal: 5.0),
                                    decoration: BoxDecoration(
                                      // boxShadow: [
                                      //   BoxShadow(
                                      //     color: Colors.grey[400],
                                      //     blurRadius: 3.0,
                                      //     // has the effect of softening the shadow
                                      //     spreadRadius: 0.0,
                                      //     // has the effect of extending the shadow
                                      //     offset: Offset(
                                      //       3.0, // horizontal, move right 10
                                      //       5.0, // vertical, move down 10
                                      //     ),
                                      //   )
                                      // ],
                                    ),
                                    child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10.0),
                                        child: CachedNetworkImage(
                                          imageUrl: "http://185.201.9.208/"+imgUrl.image,
                                          imageBuilder: (context, imageProvider) =>
                                              Container(
                                                decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                    image: imageProvider,
                                                    fit: BoxFit.fill,
//                                          colorFilter:
//                                          ColorFilter.mode(Colors.red, BlendMode.colorBurn)
                                                  ),
                                                ),
                                              ),
                                          // placeholder: (context, url) =>
                                          //     Lottie.asset(
                                          //         'assets/loadingcoffee.json',
                                          //         height: 150,
                                          //         width: 150),
                                          errorWidget: (context, url, error) =>
                                              Icon(Icons.error),
                                          fadeInCurve: Curves.easeIn,
                                          fadeInDuration:
                                          Duration(microseconds: 1000),
                                        ))),
                              );
                            });
                          }).toList(),
                        ),
                      );
                    }else {
                      return Container(
                        margin: EdgeInsets.only(top: 16),
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height / 6,
                        // padding: EdgeInsets.all(12),
                        child: Shimmer.fromColors(
                            baseColor: Colors.grey[300],
                            highlightColor: Colors.grey[100],
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Expanded(
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (_, __) => Padding(
                                      padding: const EdgeInsets.only(left: 12.0),
                                      child: Container(
                                        height: 140,
                                        child: Container(
                                          height: 140,
                                          width: MediaQuery.of(context).size.width -50,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(8),
                                              color: Colors.grey
                                          ),
                                        ),
                                      ),
                                    ),
                                    itemCount: 2,
                                  ),
                                ),
                              ],
                            )),
                      );
                    }
                  }
              ),
            ),
            SizedBox(
              height: 12,
            ),
            Container(
              height: 250,
              width: MediaQuery.of(context).size.width,
              color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Text("Quote hari ini"),
                  ),
                  StreamBuilder(
                      stream: memberBloc.resBannerQuote,
                      builder: (context, AsyncSnapshot<GetBannerQuoteModel> snapshot) {
                        if(snapshot.hasData){
                          return Container(
                            //margin: EdgeInsets.only(top: 8),
                            height: MediaQuery.of(context).size.height / 5 + 20,
                            child: CarouselSlider(
                              height: MediaQuery.of(context).size.height / 5 - 20,
                              initialPage: 0,
                              autoPlay: false,
                              enlargeCenterPage: true,
                              viewportFraction: 0.95,
                              enableInfiniteScroll: false,
                              // autoPlayInterval: Duration(seconds: 5),
                              onPageChanged: (index) {
                                setState(() {
                                  _current = index;
                                });
                              },
                              items: snapshot.data.result.map((imgUrl) {
                                return Builder(builder: (BuildContext context) {
                                  return InkWell(
                                    onTap: (){
                                      // print(imgUrl.bannerExt);
                                      // if(imgUrl.bannerExt=="0"){
                                      //   Navigator.push(
                                      //       context, SlideLeftRoute(page: DetailProjectPage(id: imgUrl.idProject)));
                                      // }else{
                                      //   _launchURL(imgUrl.url);
                                      // }
                                    },
                                    child: Container(
                                        width: MediaQuery.of(context).size.width,
                                        margin: EdgeInsets.symmetric(horizontal: 5.0),
                                        decoration: BoxDecoration(
                                          // boxShadow: [
                                          //   BoxShadow(
                                          //     color: Colors.grey[400],
                                          //     blurRadius: 3.0,
                                          //     // has the effect of softening the shadow
                                          //     spreadRadius: 0.0,
                                          //     // has the effect of extending the shadow
                                          //     offset: Offset(
                                          //       3.0, // horizontal, move right 10
                                          //       5.0, // vertical, move down 10
                                          //     ),
                                          //   )
                                          // ],
                                        ),
                                        child: ClipRRect(
                                            borderRadius: BorderRadius.circular(10.0),
                                            child: CachedNetworkImage(
                                              imageUrl: "http://185.201.9.208/"+imgUrl.image,
                                              imageBuilder: (context, imageProvider) =>
                                                  Container(
                                                    decoration: BoxDecoration(
                                                      image: DecorationImage(
                                                        image: imageProvider,
                                                        fit: BoxFit.fill,
//                                          colorFilter:
//                                          ColorFilter.mode(Colors.red, BlendMode.colorBurn)
                                                      ),
                                                    ),
                                                  ),
                                              // placeholder: (context, url) =>
                                              //     Lottie.asset(
                                              //         'assets/loadingcoffee.json',
                                              //         height: 150,
                                              //         width: 150),
                                              errorWidget: (context, url, error) =>
                                                  Icon(Icons.error),
                                              fadeInCurve: Curves.easeIn,
                                              fadeInDuration:
                                              Duration(microseconds: 1000),
                                            ))),
                                  );
                                });
                              }).toList(),
                            ),
                          );
                        }else {
                          return Container(
                            margin: EdgeInsets.only(top: 16),
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height / 6,
                            // padding: EdgeInsets.all(12),
                            child: Shimmer.fromColors(
                                baseColor: Colors.grey[300],
                                highlightColor: Colors.grey[100],
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Expanded(
                                      child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: (_, __) => Padding(
                                          padding: const EdgeInsets.only(left: 12.0),
                                          child: Container(
                                            height: 140,
                                            child: Container(
                                              height: 140,
                                              width: MediaQuery.of(context).size.width -50,
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(8),
                                                  color: Colors.grey
                                              ),
                                            ),
                                          ),
                                        ),
                                        itemCount: 2,
                                      ),
                                    ),
                                  ],
                                )),
                          );
                        }
                      }
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
        height: 230,
        child: new Container(
            color: Colors.white,
            margin: EdgeInsets.only(top: 0.0, bottom: 0.0),
            padding: EdgeInsets.only(top: 14, left: 12, right: 12),
            child: GridView.builder(
                padding: EdgeInsets.zero,
                physics: ClampingScrollPhysics(),
                itemCount: 8,
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
        } else if (daiService.title == "Do'a Pilihan") {
          Navigator.push(context,
              PageTransition(type: PageTransitionType.rightToLeft, duration: Duration(milliseconds: 200), child: DoaPilihan(kode: 'wFcYshwvZG',label: "Do'a Pilihan",)));
        }else if(daiService.title == "Hukum Islam"){
          Navigator.push(context,
              PageTransition(type: PageTransitionType.rightToLeft, duration: Duration(milliseconds: 200), child: DoaPilihan(kode: 'oqkuxtSvHk',label: "Hukum Islam",)));
        }else if(daiService.title == "Naskah Khutbah"){
          Navigator.push(context,
              PageTransition(type: PageTransitionType.rightToLeft, duration: Duration(milliseconds: 200), child: DoaPilihan(kode: 'SoTgPpOaWT',label: "Naskah Khutbah",)));
        } else {
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
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [colorses.hijaucerahg2, colorses.hijaucerahg1]),
                  border: Border.all(color: Colors.grey[200], width: 1.0),
                  borderRadius: new BorderRadius.all(new Radius.circular(31.0)),
                  boxShadow: [BoxShadow(color: Colors.grey[200], spreadRadius: 0.3, blurRadius: 0.3, offset: Offset(0, 3))]),
              child: Container(
                height: 24,
                width: 24,
                child: daiService.title == "Lainnya"
                    ? Icon(
                        Icons.apps,
                        color: Colors.black45,
                      )
                    : new SvgPicture.asset(
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
