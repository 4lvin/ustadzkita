import 'package:daikita/src/blocs/fiturBloc.dart';
import 'package:daikita/src/models/getListUndanganBatalModel.dart';
import 'package:daikita/src/models/getListUndanganConfirmModel.dart';
import 'package:daikita/src/models/getListUndanganFinishModel.dart';
import 'package:daikita/src/models/getListUndanganModel.dart';
import 'package:daikita/src/pref/preferences.dart';
import 'package:daikita/src/resources/publicUrl.dart';
import 'package:daikita/src/ui/chatRoom.dart';
import 'package:daikita/src/ui/detailUndangan.dart';
import 'package:daikita/src/ui/utils/colorses.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:page_transition/page_transition.dart';

class UndanganSaya extends StatefulWidget {
  @override
  _UndanganSayaState createState() => _UndanganSayaState();
}

class _UndanganSayaState extends State<UndanganSaya> with SingleTickerProviderStateMixin{
  TabController _tabController;
  @override
  void initState() {
    _tabController = TabController(length: 4, vsync: this);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height / 6 - 20,
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
                            onTap: (){
                              Navigator.of(context).pop();
                            },
                            child: Icon(
                              Icons.arrow_back_ios,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            "Undangan Saya",
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
              indicator: BoxDecoration(
                color: Color(0xff1ABC9C),
              ),
              labelColor: Colors.white,
              unselectedLabelColor: Colors.black,
              tabs: [
                Tab(
                  text: 'Dibuat',
                ),
                Tab(
                  text: 'Dikonfirmasi',
                ),
                Tab(
                  text: 'Selesai',
                ),
                Tab(
                  text: 'Dibatalkan',
                ),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                Dibuat(),
                DiKonfirm(),
                Selesai(),
                Ditolak()
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Dibuat extends StatefulWidget {
  @override
  _DibuatState createState() => _DibuatState();
}

class _DibuatState extends State<Dibuat> {
  List bulan = [
    "Januari",
    "Februari",
    "Maret",
    "April",
    "Mei",
    "Juni",
    "Juli",
    "Agustus",
    "September",
    "Oktober",
    "November",
    "Desember",
  ];
  @override
  void initState() {
    getToken().then((value){
      blocFitur.listUndangan(value,"Pending");
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: StreamBuilder(
          stream: blocFitur.resUndanganList,
          builder: (context,
              AsyncSnapshot<GetListUndanganModel>
              snapshot) {
            if (snapshot.hasData) {
              return snapshot.data.result.isNotEmpty
                  ? ListView.builder(
                  shrinkWrap: true,
                  padding: EdgeInsets.only(top: 3),
                  itemCount: snapshot.data.result.length,
                  itemBuilder:
                      (BuildContext context, int i) {
                    return Center(
                      child: InkWell(
                        onTap: (){
                          Navigator.push(
                              context,
                              PageTransition(
                                  type: PageTransitionType.rightToLeft,
                                  duration: Duration(milliseconds: 200),
                                  child: DetailUndangan(status:"dibuat",kode:snapshot.data.result[i].kode,foto: snapshot.data.result[i].foto,)));
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width - 40,
                          margin: EdgeInsets.only(top: 12),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(20),
                                  bottomRight: Radius.circular(20),
                                  bottomLeft: Radius.circular(8),
                                  topLeft: Radius.circular(8)),
                              color: Colors.white),
                          child: Row(
                            children: <Widget>[
                              Container(
                                  height: 200,
                                  width: 5,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(topLeft: Radius.circular(15), bottomLeft: Radius.circular(15)),
                                      color: colorses.hijaupelet)),
                              Container(
                                width: MediaQuery.of(context).size.width - 50,
                                padding: EdgeInsets.all(18),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Text(
                                          "MENGUNDANG",
                                          style: TextStyle(fontSize: 14),
                                        ),
                                        Text(
                                          "Sudah dikirim",
                                          style: TextStyle(fontSize: 14, color: Color(0xff16A085)),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Row(
                                      children: <Widget>[
                                        Container(
                                          margin: EdgeInsets.only(right: 12),
                                          height: 70,
                                          width: 70,
                                          decoration: BoxDecoration(
                                            color: Colors.grey,
                                            borderRadius: BorderRadius.circular(12),
                                              image: DecorationImage(
                                                  image: NetworkImage("$urlVps/"+snapshot.data.result[i].foto),
                                                  fit: BoxFit.cover)
                                          ),
                                        ),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(snapshot.data.result[i].nama,style: TextStyle(fontWeight: FontWeight.bold),),
                                            SizedBox(height: 5,),
                                            Text(snapshot.data.result[i].tanggal.day.toString() +
                                                " " +
                                                bulan[snapshot.data.result[i].tanggal.month - 1] +
                                                " " +
                                                snapshot.data.result[i].tanggal.year.toString()),
                                            SizedBox(height: 5,),
                                            Text("${snapshot.data.result[i].jam}"),
                                            SizedBox(height: 5,),
                                            Text("${snapshot.data.result[i].jenis}"),
                                          ],
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 12,
                                    ),
                                    Divider(height: 2,color: Colors.grey,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            SizedBox(height: 8,),
                                            Text("STATUS",style: TextStyle(color: Colors.black,fontSize: 14)),
                                            SizedBox(height: 8,),
                                            Text("Belum dikonfirmasi",style: TextStyle(color: Colors.red,fontSize: 12),),
                                          ],
                                        ),
                                        InkWell(
                                          onTap: (){
                                            Navigator.push(
                                                context,
                                                PageTransition(
                                                    type: PageTransitionType.rightToLeft,
                                                    duration: Duration(milliseconds: 200),
                                                    child: ChatRoom(email:snapshot.data.result[i].email,nama:snapshot.data.result[i].nama,foto: snapshot.data.result[i].foto,)));
                                          },
                                          child: Container(
                                            height: 30,
                                            width: 130,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(8),
                                              color: Color(0xff16A085)
                                            ),
                                            child: Center(child: Text("Hubungi Ustadz",style: TextStyle(color: Colors.white,fontSize: 12),)),
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                      })
                  : Center(
                child: Column(
                  mainAxisAlignment:
                  MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Belum membuat Undangan",
                      style: TextStyle(
                          color: Colors.grey),
                    )
                  ],
                ),
              );
            } else {
              return Center(
                  child: CircularProgressIndicator()
              );
            }
          }),
    );
  }
}

class DiKonfirm extends StatefulWidget {
  @override
  _DiKonfirmState createState() => _DiKonfirmState();
}

class _DiKonfirmState extends State<DiKonfirm> {
  List bulan = [
    "Januari",
    "Februari",
    "Maret",
    "April",
    "Mei",
    "Juni",
    "Juli",
    "Agustus",
    "September",
    "Oktober",
    "November",
    "Desember",
  ];
  @override
  void initState() {
    getToken().then((value){
      blocFitur.listUndangan(value,"Confirm");
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: StreamBuilder(
          stream: blocFitur.resUndanganConfirm,
          builder: (context,
              AsyncSnapshot<GetListUndanganConfirmModel>
              snapshot) {
            if (snapshot.hasData) {
              return snapshot.data.result.isNotEmpty
                  ? ListView.builder(
                  shrinkWrap: true,
                  padding: EdgeInsets.only(top: 3),
                  itemCount: snapshot.data.result.length,
                  itemBuilder:
                      (BuildContext context, int i) {
                    return Center(
                      child: Container(
                        width: MediaQuery.of(context).size.width - 40,
                        margin: EdgeInsets.only(top: 12),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(20),
                                bottomRight: Radius.circular(20),
                                bottomLeft: Radius.circular(8),
                                topLeft: Radius.circular(8)),
                            color: Colors.white),
                        child: Row(
                          children: <Widget>[
                            Container(
                                height: 200,
                                width: 5,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(topLeft: Radius.circular(15), bottomLeft: Radius.circular(15)),
                                    color: colorses.hijaupelet)),
                            Container(
                              width: MediaQuery.of(context).size.width - 50,
                              padding: EdgeInsets.all(18),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text(
                                        "MENGUNDANG",
                                        style: TextStyle(fontSize: 14),
                                      ),
                                      Text(
                                        "Menunggu dihadiri",
                                        style: TextStyle(fontSize: 14, color: Color(0xff16A085)),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Container(
                                        margin: EdgeInsets.only(right: 12),
                                        height: 70,
                                        width: 70,
                                        decoration: BoxDecoration(
                                            color: Colors.grey,
                                            borderRadius: BorderRadius.circular(12),
                                            image: DecorationImage(
                                                image: NetworkImage("$urlVps/"+snapshot.data.result[i].foto),
                                                fit: BoxFit.cover)
                                        ),
                                      ),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(snapshot.data.result[i].nama,style: TextStyle(fontWeight: FontWeight.bold),),
                                          SizedBox(height: 5,),
                                          Text(snapshot.data.result[i].tanggal.day.toString() +
                                              " " +
                                              bulan[snapshot.data.result[i].tanggal.month - 1] +
                                              " " +
                                              snapshot.data.result[i].tanggal.year.toString()),
                                          SizedBox(height: 5,),
                                          Text("${snapshot.data.result[i].jam}"),
                                          SizedBox(height: 5,),
                                          Text("${snapshot.data.result[i].jenis}"),
                                        ],
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 12,
                                  ),
                                  Divider(height: 2,color: Colors.grey,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          SizedBox(height: 8,),
                                          Text("STATUS",style: TextStyle(color: Colors.black,fontSize: 14)),
                                          SizedBox(height: 8,),
                                          Text("Telah dikonfirmasi",style: TextStyle(color: Colors.red,fontSize: 12),),
                                        ],
                                      ),
                                      Container(
                                        height: 30,
                                        width: 130,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(8),
                                            color: Color(0xff16A085)
                                        ),
                                        child: Center(child: Text("Hubungi Ustadz",style: TextStyle(color: Colors.white,fontSize: 12),)),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  })
                  : Center(
                child: Column(
                  mainAxisAlignment:
                  MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Belum ada konfirmasi",
                      style: TextStyle(
                          color: Colors.grey),
                    )
                  ],
                ),
              );
            } else {
              return Center(
                child: CircularProgressIndicator()
              );
            }
          }),
    );
  }
}

class Selesai extends StatefulWidget {
  @override
  _SelesaiState createState() => _SelesaiState();
}

class _SelesaiState extends State<Selesai> {
  List bulan = [
    "Januari",
    "Februari",
    "Maret",
    "April",
    "Mei",
    "Juni",
    "Juli",
    "Agustus",
    "September",
    "Oktober",
    "November",
    "Desember",
  ];
  @override
  void initState() {
    getToken().then((value){
      blocFitur.listUndangan(value,"Finish");
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: StreamBuilder(
          stream: blocFitur.resUndanganFinish,
          builder: (context,
              AsyncSnapshot<GetListUndanganFinishModel>
              snapshot) {
            if (snapshot.hasData) {
              return snapshot.data.result.isNotEmpty
                  ? ListView.builder(
                  shrinkWrap: true,
                  padding: EdgeInsets.only(top: 3),
                  itemCount: snapshot.data.result.length,
                  itemBuilder:
                      (BuildContext context, int i) {
                    return InkWell(
                      onTap: (){
                        Navigator.push(
                            context,
                            PageTransition(
                                type: PageTransitionType.rightToLeft,
                                duration: Duration(milliseconds: 200),
                                child: DetailUndangan(status:"selesai",kode:snapshot.data.result[i].kode,ulasan: snapshot.data.result[i].ulasan,foto: snapshot.data.result[i].foto,)));
                      },
                      child: Center(
                        child: Container(
                          width: MediaQuery.of(context).size.width - 40,
                          margin: EdgeInsets.only(top: 12),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(20),
                                  bottomRight: Radius.circular(20),
                                  bottomLeft: Radius.circular(8),
                                  topLeft: Radius.circular(8)),
                              color: Colors.white),
                          child: Row(
                            children: <Widget>[
                              Container(
                                  height: 200,
                                  width: 5,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(topLeft: Radius.circular(15), bottomLeft: Radius.circular(15)),
                                      color: colorses.hijaupelet)),
                              Container(
                                width: MediaQuery.of(context).size.width - 50,
                                padding: EdgeInsets.all(18),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Text(
                                          "MENGUNDANG",
                                          style: TextStyle(fontSize: 14),
                                        ),
                                        snapshot.data.result[i].ulasan==1?Text(
                                          "Telah diulas",
                                          style: TextStyle(fontSize: 14, color: Color(0xff16A085)),
                                        ):Text(
                                          "Belum diulas",
                                          style: TextStyle(fontSize: 14, color: Color(0xff16A085)),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Row(
                                      children: <Widget>[
                                        Container(
                                          margin: EdgeInsets.only(right: 12),
                                          height: 70,
                                          width: 70,
                                          decoration: BoxDecoration(
                                              color: Colors.grey,
                                              borderRadius: BorderRadius.circular(12),
                                            image: DecorationImage(
                                                image: NetworkImage("$urlVps/"+snapshot.data.result[i].foto),
                                                fit: BoxFit.cover)
                                          ),
                                        ),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(snapshot.data.result[i].nama,style: TextStyle(fontWeight: FontWeight.bold),),
                                            SizedBox(height: 5,),
                                            Text(snapshot.data.result[i].tanggal.day.toString() +
                                                " " +
                                                bulan[snapshot.data.result[i].tanggal.month - 1] +
                                                " " +
                                                snapshot.data.result[i].tanggal.year.toString()),
                                            SizedBox(height: 5,),
                                            Text("${snapshot.data.result[i].jam}"),
                                            SizedBox(height: 5,),
                                            Text("${snapshot.data.result[i].jenis}"),
                                          ],
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 12,
                                    ),
                                    Divider(height: 2,color: Colors.grey,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            SizedBox(height: 8,),
                                            Text("STATUS",style: TextStyle(color: Colors.black,fontSize: 14)),
                                            SizedBox(height: 8,),
                                            Text("Telah dihadirii",style: TextStyle(color: Colors.red,fontSize: 12),),
                                          ],
                                        ),
                                        snapshot.data.result[i].ulasan==1?Container(
                                          height: 30,
                                          width: 130,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(8),
                                              color: Colors.grey
                                          ),
                                          child: Center(child: Text("Telah diulas",style: TextStyle(color: Colors.white,fontSize: 12),)),
                                        ):Container(
                                          height: 30,
                                          width: 130,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(8),
                                              color: Color(0xff16A085)
                                          ),
                                          child: Center(child: Text("Beri Ulasan",style: TextStyle(color: Colors.white,fontSize: 12),)),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  })
                  : Center(
                child: Column(
                  mainAxisAlignment:
                  MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Belum ada data Selesai",
                      style: TextStyle(
                          color: Colors.grey),
                    )
                  ],
                ),
              );
            } else {
              return Center(
                  child: CircularProgressIndicator()
              );
            }
          }),
    );
  }
}

class Ditolak extends StatefulWidget {
  @override
  _DitolakState createState() => _DitolakState();
}

class _DitolakState extends State<Ditolak> {
  List bulan = [
    "Januari",
    "Februari",
    "Maret",
    "April",
    "Mei",
    "Juni",
    "Juli",
    "Agustus",
    "September",
    "Oktober",
    "November",
    "Desember",
  ];
  @override
  void initState() {
    getToken().then((value){
      blocFitur.listUndangan(value,"Tolak");
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: StreamBuilder(
          stream: blocFitur.resUndanganBatal,
          builder: (context,
              AsyncSnapshot<GetListUndanganBatalModel>
              snapshot) {
            if (snapshot.hasData) {
              return snapshot.data.result.isNotEmpty
                  ? ListView.builder(
                  shrinkWrap: true,
                  padding: EdgeInsets.only(top: 3),
                  itemCount: snapshot.data.result.length,
                  itemBuilder:
                      (BuildContext context, int i) {
                    return Center(
                      child: Container(
                        width: MediaQuery.of(context).size.width - 40,
                        margin: EdgeInsets.only(top: 12),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(20),
                                bottomRight: Radius.circular(20),
                                bottomLeft: Radius.circular(8),
                                topLeft: Radius.circular(8)),
                            color: Colors.white),
                        child: Row(
                          children: <Widget>[
                            Container(
                                height: 200,
                                width: 5,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(topLeft: Radius.circular(15), bottomLeft: Radius.circular(15)),
                                    color: colorses.hijaupelet)),
                            Container(
                              width: MediaQuery.of(context).size.width - 50,
                              padding: EdgeInsets.all(18),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text(
                                        "MENGUNDANG",
                                        style: TextStyle(fontSize: 14),
                                      ),
                                      Text(
                                        "Dibatalkan",
                                        style: TextStyle(fontSize: 14, color: Color(0xff16A085)),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Container(
                                        margin: EdgeInsets.only(right: 12),
                                        height: 70,
                                        width: 70,
                                        decoration: BoxDecoration(
                                            color: Colors.grey,
                                            borderRadius: BorderRadius.circular(12)
                                        ),
                                      ),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(snapshot.data.result[i].nama,style: TextStyle(fontWeight: FontWeight.bold),),
                                          SizedBox(height: 5,),
                                          Text(snapshot.data.result[i].tanggal.day.toString() +
                                              " " +
                                              bulan[snapshot.data.result[i].tanggal.month - 1] +
                                              " " +
                                              snapshot.data.result[i].tanggal.year.toString()),
                                          SizedBox(height: 5,),
                                          Text("${snapshot.data.result[i].jam}"),
                                          SizedBox(height: 5,),
                                          Text("${snapshot.data.result[i].jenis}"),
                                        ],
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 12,
                                  ),
                                  Divider(height: 2,color: Colors.grey,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          SizedBox(height: 8,),
                                          Text("STATUS",style: TextStyle(color: Colors.black,fontSize: 14)),
                                          SizedBox(height: 8,),
                                          Text("Ditolak/ Dibatalkan",style: TextStyle(color: Colors.red,fontSize: 12),),
                                        ],
                                      ),
                                      Container(
                                        height: 30,
                                        width: 130,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(8),
                                            color: Color(0xff16A085)
                                        ),
                                        child: Center(child: Text("Hubungi Ustadz",style: TextStyle(color: Colors.white,fontSize: 12),)),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  })
                  : Center(
                child: Column(
                  mainAxisAlignment:
                  MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Belum ada Penolakan",
                      style: TextStyle(
                          color: Colors.grey),
                    )
                  ],
                ),
              );
            } else {
              return Center(
                  child: CircularProgressIndicator()
              );
            }
          }),
    );
  }
}




