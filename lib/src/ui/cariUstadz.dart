import 'package:daikita/src/blocs/fiturBloc.dart';
import 'package:daikita/src/models/getListUstadzModel.dart';
import 'package:daikita/src/pref/preferences.dart';
import 'package:daikita/src/resources/publicUrl.dart';
import 'package:daikita/src/ui/buatJadwal.dart';
import 'package:daikita/src/ui/chatRoom.dart';
import 'package:daikita/src/ui/detailUndangan.dart';
import 'package:daikita/src/ui/profileUstadz.dart';
import 'package:daikita/src/ui/utils/colorses.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:page_transition/page_transition.dart';
import 'package:toast/toast.dart';

class CariUstadz extends StatefulWidget {
  @override
  _CariUstadzState createState() => _CariUstadzState();
}

class _CariUstadzState extends State<CariUstadz> {
  List<Result> ustadzList = List<Result>();
  List<Result> ustadzListDisplay;
  var _cari = TextEditingController();

  @override
  void initState() {
    getKota().then((kota) {
      getToken().then((token) {
        blocFitur.getListUstadz(kota, token);
      });
    });
    blocFitur.resListUstadz.listen((value) {
      if (mounted)
        setState(() {
          if (ustadzList.isNotEmpty) {
            if (mounted)
              setState(() {
                ustadzList.clear();
              });
          } else {
            ustadzList.addAll(value.result);
            ustadzListDisplay = ustadzList;
          }
        });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[300],
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height / 4 - 50,
              color: Colors.grey[300],
              child: Stack(
                children: <Widget>[
                  Container(
                    height: MediaQuery.of(context).size.height / 4 - 70,
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            InkWell(
                              onTap: () {
                                Navigator.of(context).pop();
                              },
                              child: Icon(
                                Icons.arrow_back_ios,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "Cari Ustadz",
                              style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            Container(
                              width: 50,
                              height: 50,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12), color: Colors.white, border: Border.all(color: Colors.grey)),
                      height: 50,
                      width: MediaQuery.of(context).size.width - 50,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Container(
                            width: 180,
                            child: TextField(
                              cursorColor: Color(0xff740e13),
                              style: TextStyle(fontSize: 16),
                              decoration: InputDecoration(
                                hintText: "Cari",
                              ),
                              keyboardType: TextInputType.text,
                              onChanged: (value) {
                                setState(() {
                                  ustadzListDisplay = ustadzList.where((element) {
                                    var namaUstadz = element.fullName.toLowerCase();
                                    return namaUstadz.contains(value);
                                  }).toList();
                                });
                              },
                            ),
                          ),
                          Icon(
                            Icons.search,
                            size: 25,
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.all(12),
                child: StreamBuilder(
                    stream: blocFitur.resListUstadz,
                    builder: (context, AsyncSnapshot<GetListUstadzModel> snapshot) {
                      if (snapshot.hasData) {
                        return ustadzListDisplay == null
                            ? Container(
                                child: Center(child: Text("Belum ada data")),
                              )
                            : ListView.builder(
                                itemCount: ustadzListDisplay.length,
                                padding: EdgeInsets.zero,
                                itemBuilder: (context, i) {
                                  return Container(
                                    // height: 160.0,
                                    margin: EdgeInsets.only(top: 1, bottom: 8),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      // border: Border(
                                      //   bottom: BorderSide(
                                      //     color: Colors.grey[300],
                                      //     width: 1.0,
                                      //   ),
                                      // ),
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(color: Colors.white, spreadRadius: 1),
                                      ],
                                    ),
                                    child: ListTile(
                                      dense: true,
                                      contentPadding: EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0, bottom: 10.0),
                                      title: Container(
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            InkWell(
                                              onTap: () {
                                                Navigator.push(
                                                    context,
                                                    PageTransition(
                                                        type: PageTransitionType.rightToLeft,
                                                        duration: Duration(milliseconds: 200),
                                                        child: ProfileUstadz(
                                                            data: ustadzListDisplay[i], image: ustadzListDisplay[i].foto)));
                                              },
                                              child: Container(
                                                  height: 80,
                                                  width: 80,
                                                  margin: EdgeInsets.only(right: 12),
                                                  decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(8),
                                                      image: DecorationImage(
                                                          image: ustadzListDisplay[i].foto == null
                                                              ? NetworkImage(
                                                                  "https://3.bp.blogspot.com/-a6eXQ7JDago/WR6wYhHcp3I/AAAAAAAAB98/3QxH69fmBN85FPA5_PBATBSejiC2w-JHgCLcB/s1600/Flat%2BMusth%2B2.png")
                                                              : NetworkImage(urlVps + ustadzListDisplay[i].foto),
                                                          // "http://jongjava.tech/tumbas/assets/foto_produk/" + produkListDisplay[i].gambar),
                                                          fit: BoxFit.cover))),
                                            ),
                                            Expanded(
                                              child: Container(
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Container(
                                                        width: 150,
                                                        child: Text(ustadzListDisplay[i].fullName,
                                                            style: TextStyle(fontSize: 16.0, color: Colors.black))),
                                                    Container(
                                                        margin: EdgeInsets.only(bottom: 8),
                                                        width: 210,
                                                        child: Text("Penceramah",
                                                            style: TextStyle(fontSize: 12.0, color: Colors.orange))),
                                                    Container(
                                                        margin: EdgeInsets.only(bottom: 8),
                                                        width: 210,
                                                        child: Row(
                                                          children: <Widget>[
                                                            Icon(Icons.location_on),
                                                            Text(ustadzListDisplay[i].kecamatan,
                                                                style: TextStyle(fontSize: 12.0, color: Colors.black)),
                                                          ],
                                                        )),
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: <Widget>[
                                                        InkWell(
                                                          onTap: () {
                                                            Navigator.push(
                                                                context,
                                                                PageTransition(
                                                                    type: PageTransitionType.rightToLeft,
                                                                    duration: Duration(milliseconds: 200),
                                                                    child: ProfileUstadz(
                                                                        data: ustadzListDisplay[i],
                                                                        image: ustadzListDisplay[i].foto)));
                                                            // Toast.show("Segera hadir", context,
                                                            //     duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
                                                          },
                                                          child: Container(
                                                            width: 100,
                                                            height: 35,
                                                            decoration: BoxDecoration(
                                                                borderRadius: BorderRadius.circular(12),
                                                                color: Colors.white,
                                                                border: Border.all(color: Colors.green)),
                                                            child: Center(
                                                                child: Text(
                                                              "CHAT",
                                                              style: TextStyle(color: Colors.green),
                                                            )),
                                                          ),
                                                        ),
                                                        InkWell(
                                                          onTap: () {
                                                            Navigator.push(
                                                                context,
                                                                PageTransition(
                                                                    type: PageTransitionType.rightToLeft,
                                                                    duration: Duration(milliseconds: 200),
                                                                    child: ProfileUstadz(
                                                                        data: ustadzListDisplay[i],
                                                                        image: ustadzListDisplay[i].foto)));
                                                          },
                                                          child: Container(
                                                            width: 100,
                                                            height: 35,
                                                            decoration: BoxDecoration(
                                                                borderRadius: BorderRadius.circular(12), color: Colors.green),
                                                            child: Center(
                                                                child: Text("UNDANG", style: TextStyle(color: Colors.white))),
                                                          ),
                                                        )
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                            // Container(
                                            //   width: 100,
                                            //   padding: EdgeInsets.all(8),
                                            //   decoration: BoxDecoration(borderRadius: BorderRadius.circular(18), color: colorses.kuning),
                                            //   child: Text(
                                            //     snapshot.data.data[i].statusKirim == " ()"
                                            //         ? "Mencari Kurir"
                                            //         : snapshot.data.data[i].statusKirim,
                                            //     style: TextStyle(color: Colors.white),
                                            //     overflow: TextOverflow.ellipsis,
                                            //   ),
                                            // )
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                });
                      } else {
                        return Center(child: CircularProgressIndicator());
                      }
                    }),
              ),
            ),
          ],
        ));
  }
}
