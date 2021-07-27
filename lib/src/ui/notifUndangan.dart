import 'package:daikita/src/models/getUndanganModel.dart';
import 'package:daikita/src/ui/utils/colorses.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class NotifUndangan extends StatefulWidget {
  NotifUndangan({this.undangan});

  GetUndanganModel undangan;

  @override
  _NotifUndanganState createState() => _NotifUndanganState();
}

class _NotifUndanganState extends State<NotifUndangan> {
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
                    Image.asset("assets/tiket.png"),
                    Positioned(
                      top: 170,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
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
                                      "Penerima",
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Text("${widget.undangan.penerima}"),
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
                          Container(
                            margin: EdgeInsets.only(top: 8,left: 14),
                            width: MediaQuery.of(context).size.width - 100,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  "Nomor Undangan",
                                  style: TextStyle(color: Colors.grey),
                                ),
                                Text(
                                  "Jenis Kegiatan",
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 8,left: 14),
                            width: MediaQuery.of(context).size.width - 100,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  "${widget.undangan.nomorUndangan}",
                                  style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "${widget.undangan.jenisKegiatan}",
                                  style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 8,left: 14),
                            width: MediaQuery.of(context).size.width - 100,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  "Tanggal",
                                  style: TextStyle(color: Colors.grey),
                                ),
                                Text(
                                  "Waktu",
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 8,left: 14),
                            width: MediaQuery.of(context).size.width - 100,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  "${widget.undangan.tanggal.day}/${widget.undangan.tanggal.month}/${widget.undangan.tanggal.year}",
                                  style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "${widget.undangan.waktuMulai}-${widget.undangan.waktuSelesai}",
                                  style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 8,left: 14),
                            width: MediaQuery.of(context).size.width - 100,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  "Jumlah Peserta",
                                  style: TextStyle(color: Colors.grey),
                                ),
                                Text(
                                  "Lokasi",
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 8,left: 14),
                            width: MediaQuery.of(context).size.width - 100,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  "${widget.undangan.jumlahPeserta}",
                                  style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "${widget.undangan.lokasi}",
                                  style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 8,left: 14),
                            width: MediaQuery.of(context).size.width - 100,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  "Akomodasi",
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 8,left: 14),
                            width: MediaQuery.of(context).size.width - 100,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  "${widget.undangan.akomodasi}",
                                  style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
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
                    "Undangan akan sampai dalam 2x24 jam. Silahkan tunggu konfirmasi Penerima",
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
