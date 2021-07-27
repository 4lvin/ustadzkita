import 'package:daikita/src/blocs/fiturBloc.dart';
import 'package:daikita/src/pref/preferences.dart';
import 'package:daikita/src/ui/notifUndangan.dart';
import 'package:daikita/src/ui/utils/colorses.dart';
import 'package:daikita/src/ui/utils/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:page_transition/page_transition.dart';
import 'package:toast/toast.dart';

class KonfirmasiJadwal extends StatefulWidget {
  KonfirmasiJadwal(
      {this.ustadz,
      this.namaUstadz,
      this.tgl,
      this.jamMulai,
      this.jamSelesai,
      this.jenisKegiatan,
      this.tema,
      this.jmlhPeserta,
      this.provinsi,
      this.kota,
      this.kecamatan,
      this.alamat,
      this.akomodasi,
      this.namaKota});

  String ustadz,
      namaUstadz,
      tgl,
      jamMulai,
      jamSelesai,
      jenisKegiatan,
      tema,
      jmlhPeserta,
      provinsi,
      kota,
      kecamatan,
      alamat,
      akomodasi,
      namaKota;

  @override
  _KonfirmasiJadwalState createState() => _KonfirmasiJadwalState();
}

class _KonfirmasiJadwalState extends State<KonfirmasiJadwal> {

  String namaPengundang;
  String telpPengundang;
  String kotaPengundang;
  @override
  void initState() {
    getNama().then((value){
      if(mounted)
        setState(() {
          namaPengundang = value;
        });
    });
    getTelp().then((value){
      if(mounted)
        setState(() {
          telpPengundang = value;
        });
    });
    getKota().then((value){
      if(mounted)
        setState(() {
          kotaPengundang = value;
        });
    });
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
                          Icon(
                            Icons.arrow_back_ios,
                            color: Colors.white,
                          ),
                          Text(
                            "Buat Jadwal",
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
            height: 60,
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Container(
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.check_circle,
                        color: colorses.hijaucerahg1,
                      ),
                      Text(
                        "  Buat Jadwal",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
                Container(
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.looks_two,
                        color: colorses.hijaucerahg1,
                      ),
                      Text(
                        "  Konfirmasi",
                        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          Container(
            height: 8,
            width: MediaQuery.of(context).size.width,
            color: colorses.hijaucerahg1,
          ),
          SizedBox(
            height: 12,
          ),
          Center(
            child: Container(
              height: 130,
              padding: EdgeInsets.all(18),
              width: MediaQuery.of(context).size.width - 40,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: Colors.white),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Konfirmasi data Anda",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Text("Lihat kembali data yang Anda masukkan untuk konfirmasi")
                ],
              ),
            ),
          ),
          SizedBox(
            height: 12,
          ),
          Center(
            child: Container(
              width: MediaQuery.of(context).size.width - 40,
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
                      height: 230,
                      width: 5,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(topLeft: Radius.circular(15), bottomLeft: Radius.circular(15)),
                          color: colorses.hijaucerahg1)),
                  Container(
                    width: MediaQuery.of(context).size.width - 50,
                    padding: EdgeInsets.all(18),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Mengundang",
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Text("${widget.namaUstadz}"),
                        Text("${widget.tgl}"),
                        Text("${widget.jamMulai + " - " + widget.jamSelesai}"),
                        Text("${widget.jenisKegiatan}"),
                        Text("${widget.jmlhPeserta} orang"),
                        Text("${widget.namaKota}"),
                        Text("${widget.alamat}"),
                        Text("Akomodasi : ${widget.akomodasi}"),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 12,
          ),
          // Center(
          //   child: Container(
          //     width: MediaQuery.of(context).size.width - 40,
          //     decoration: BoxDecoration(
          //         borderRadius: BorderRadius.only(
          //             topRight: Radius.circular(20),
          //             bottomRight: Radius.circular(20),
          //             bottomLeft: Radius.circular(8),
          //             topLeft: Radius.circular(8)),
          //         color: Colors.white),
          //     child: Row(
          //       children: <Widget>[
          //         Container(
          //             height: 230,
          //             width: 5,
          //             decoration: BoxDecoration(
          //                 borderRadius: BorderRadius.only(topLeft: Radius.circular(15), bottomLeft: Radius.circular(15)),
          //                 color: colorses.hijaucerahg1)),
          //         Container(
          //           width: MediaQuery.of(context).size.width - 50,
          //           padding: EdgeInsets.all(18),
          //           child: Column(
          //             crossAxisAlignment: CrossAxisAlignment.start,
          //             children: <Widget>[
          //               Text(
          //                 "Data Pengundang",
          //                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          //               ),
          //               SizedBox(
          //                 height: 12,
          //               ),
          //               Text("$namaPengundang"),
          //               Text("$telpPengundang"),
          //               Text("$kotaPengundang"),
          //               Text("${widget.jenisKegiatan}"),
          //               Text("${widget.akomodasi}"),
          //             ],
          //           ),
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
          SizedBox(
            height: 50,
          ),
          InkWell(
            onTap: () {
              Dialogs.showLoading(context, "Loading");
              getToken().then((value) {
                blocFitur.undangan(
                    widget.ustadz,
                    widget.tgl,
                    widget.jamMulai,
                    widget.jamSelesai,
                    widget.jenisKegiatan,
                    widget.provinsi,
                    widget.kota,
                    widget.kecamatan,
                    widget.tema,
                    widget.jmlhPeserta,
                    widget.alamat,
                    widget.akomodasi,
                    value);
              });
              blocFitur.resUndangan.listen((respon) {
                if(respon.hasil){
                  Dialogs.dismiss(context);
                  Future.delayed(Duration(seconds: 2)).then((value) {
                    Dialogs.dismiss(context);
                    Navigator.push(
                        context,
                        PageTransition(
                            type: PageTransitionType.leftToRight, duration: Duration(milliseconds: 200), child: NotifUndangan(undangan: respon,)));
                  });
                }else{
                  Dialogs.dismiss(context);
                  Future.delayed(Duration(seconds: 1)).then((value) {
                    Dialogs.dismiss(context);
                    FocusScope.of(context).requestFocus(new FocusNode());
                    Toast.show(respon.message, context,
                        duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
                  });
                }
              }).onError((e){
                Dialogs.dismiss(context);
                Future.delayed(Duration(seconds: 1)).then((value) {
                  Dialogs.dismiss(context);
                  FocusScope.of(context).requestFocus(new FocusNode());
                  Toast.show(e, context,
                      duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
                });
                });
            },
            child: Center(
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 50,
                margin: EdgeInsets.only(left: 15, right: 15, bottom: 12),
                decoration: BoxDecoration(color: colorses.biru2, borderRadius: BorderRadius.circular(12)),
                child: Center(
                    child: Text(
                  "Lanjutkan",
                  style: TextStyle(color: Colors.white),
                )),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
