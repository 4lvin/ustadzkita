import 'package:daikita/src/blocs/fiturBloc.dart';
import 'package:daikita/src/models/getListKategoriModel.dart';
import 'package:daikita/src/models/getListMarkArtikelModel.dart';
import 'package:daikita/src/pref/preferences.dart';
import 'package:daikita/src/resources/publicUrl.dart';
import 'package:daikita/src/ui/detailDoa.dart';
import 'package:daikita/src/ui/listDoa.dart';
import 'package:daikita/src/ui/utils/colorses.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:page_transition/page_transition.dart';

class DoaPilihan extends StatefulWidget {
  DoaPilihan({this.kode,this.label});
  String kode;
  String label;
  @override
  _DoaPilihanState createState() => _DoaPilihanState();
}

class _DoaPilihanState extends State<DoaPilihan> with SingleTickerProviderStateMixin {
  TabController _tabController;
  var _cari = TextEditingController();

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Column(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height / 4 - 50,
            color: Colors.white,
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
                            "${widget.label}",
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
                          width: 200,
                          child: TextField(
                            controller: _cari,
                            cursorColor: Color(0xff740e13),
                            style: TextStyle(fontSize: 16),
                            decoration: InputDecoration(
                              hintText: "Cari",
                            ),
                            keyboardType: TextInputType.text,
                            onChanged: (value) {
                              setState(() {
                                // ustadzListDisplay = ustadzList.where((element) {
                                //   var namaUstadz = element.fullName.toLowerCase();
                                //   return namaUstadz.contains(value);
                                // }).toList();
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
          Container(
            height: 50,
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: TabBar(
              controller: _tabController,
              indicator: UnderlineTabIndicator(
                borderSide: BorderSide(color: colorses.hijaudasar, width: 5),
                // insets: EdgeInsets.fromLTRB(50.0, 0.0, 50.0, 40.0),
              ),
              labelColor: Colors.black,
              unselectedLabelColor: Colors.grey,
              tabs: [
                Tab(
                  text: 'Kategori Pilihan',
                ),
                Tab(
                  text: 'Ditandai',
                ),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [KategoriPilihan(kode: widget.kode,cari: _cari.text,judul: widget.label,), DiTandai(kode: widget.kode,cari: _cari.text,judul: widget.label,)],
            ),
          ),
        ],
      ),
    );
  }
}

class KategoriPilihan extends StatefulWidget {
  KategoriPilihan({this.kode,this.cari,this.judul});
  String kode;
  String cari;
  String judul;
  @override
  _KategoriPilihanState createState() => _KategoriPilihanState();
}

class _KategoriPilihanState extends State<KategoriPilihan> {
  List<Datum> kategoriList = List<Datum>();
  List<Datum> kategoriListDisplay;

  @override
  void initState() {
    blocFitur.listKategori(widget.kode);
    blocFitur.resListKategori.listen((value) {
      if (mounted)
        setState(() {
          if (kategoriList.isNotEmpty) {
            if (mounted)
              setState(() {
                kategoriList.clear();
              });
          } else {
            kategoriList.addAll(value.data);
            kategoriListDisplay = kategoriList;
          }
        });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    kategoriListDisplay = kategoriList.where((element) {
      var namaUstadz = element.nama.toLowerCase();
      return namaUstadz.contains(widget.cari);
    }).toList();
    return Scaffold(
      body: Container(
        margin: EdgeInsets.all(12),
        child: StreamBuilder(
            stream: blocFitur.resListKategori,
            builder: (context, AsyncSnapshot<GetListKategoriModel> snapshot) {
              if (snapshot.hasData) {
                return kategoriListDisplay == null
                    ? Container(
                        child: Center(child: Text("Belum ada data")),
                      )
                    : ListView.builder(
                        itemCount: kategoriListDisplay.length,
                        padding: EdgeInsets.zero,
                        itemBuilder: (context, i) {
                          return InkWell(
                            onTap: (){
                              Navigator.push(
                                  context,
                                  PageTransition(
                                      type: PageTransitionType.rightToLeft,
                                      duration: Duration(milliseconds: 200),
                                      child: ListDoa(label: kategoriListDisplay[i].kode,judul: widget.judul,)));
                            },
                            child: Container(
                              height: 160.0,
                              margin: EdgeInsets.only(top: 1, bottom: 8),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                image: DecorationImage(
                                    image: NetworkImage("$urlVps" + kategoriListDisplay[i].image), fit: BoxFit.cover),
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
                              child: Stack(
                                children: <Widget>[
                                  Center(
                                    child: Text(
                                      kategoriListDisplay[i].nama,
                                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 28),
                                    ),
                                  ),
                                  Positioned(
                                      bottom: 20,
                                      right: 20,
                                      child: Container(
                                          height: 40,
                                          width: 40,
                                          decoration: BoxDecoration(color: Colors.black45, borderRadius: BorderRadius.circular(21)),
                                          child: Center(
                                              child: Text(
                                                kategoriListDisplay[i].jumlah.toString(),
                                            style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                                          ))))
                                ],
                              ),
                            ),
                          );
                        });
              } else {
                return Center(child: CircularProgressIndicator());
              }
            }),
      ),
    );
  }
}

class DiTandai extends StatefulWidget {
  DiTandai({this.kode,this.cari,this.judul});
  String kode;
  String cari;
  String judul;
  @override
  _DiTandaiState createState() => _DiTandaiState();
}

class _DiTandaiState extends State<DiTandai> {

  List<Result> kategoriList = List<Result>();
  List<Result> kategoriListDisplay;
  @override
  void initState() {
    getToken().then((value){
      blocFitur.listMarkArtikel(value,widget.kode);
    });

    blocFitur.resListMarkArtikel.listen((value) {
      if (mounted)
        setState(() {
          if (kategoriList.isNotEmpty) {
            if (mounted)
              setState(() {
                kategoriList.clear();
              });
          } else {
            kategoriList.addAll(value.result);
            kategoriListDisplay = kategoriList;
          }
        });
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    kategoriListDisplay = kategoriList.where((element) {
      var namaUstadz = element.artikel.judul.toLowerCase();
      return namaUstadz.contains(widget.cari);
    }).toList();
    return Scaffold(
      body: StreamBuilder(
          stream: blocFitur.resListMarkArtikel,
          builder: (context, AsyncSnapshot<GetListMarkArtikelModel> snapshot) {
            if (snapshot.hasData) {
              return kategoriListDisplay == null
                  ? Container(
                child: Center(child: Text("Belum ada data")),
              )
                  : ListView.builder(
                  itemCount: kategoriListDisplay.length,
                  padding: EdgeInsets.zero,
                  itemBuilder: (context, i) {
                    return InkWell(
                      onTap: (){
                        Navigator.push(
                            context,
                            PageTransition(
                                type: PageTransitionType.rightToLeft,
                                duration: Duration(milliseconds: 200),
                                child: DetailDoa(artikel: kategoriListDisplay[i].artikel.kode,judul: widget.judul,)));
                      },
                      child: Container(
                        height: 50.0,
                        margin: EdgeInsets.only(top: 1, bottom: 8,right: 20,left: 20),
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
                        child: Row(
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(right: 12),
                              width: 9,
                              color: colorses.hijaudasar,
                            ),
                            Text(kategoriListDisplay[i].artikel.judul),
                            Spacer(),
                            Container(margin: EdgeInsets.only(right: 12),child: Icon(Icons.arrow_forward_ios,size: 14,))
                          ],
                        ),
                      ),
                    );
                  });
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}

