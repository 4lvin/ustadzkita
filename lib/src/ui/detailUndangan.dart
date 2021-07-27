import 'package:daikita/src/blocs/fiturBloc.dart';
import 'package:daikita/src/pref/preferences.dart';
import 'package:daikita/src/ui/utils/colorses.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class DetailUndangan extends StatefulWidget {
  DetailUndangan({this.kode});
  String kode;
  @override
  _DetailUndanganState createState() => _DetailUndanganState();
}

class _DetailUndanganState extends State<DetailUndangan> {

  String kode;
  String nama;
  String alamat;
  int length = 0;

  @override
  void initState() {
    getToken().then((value){
      blocFitur.detailUndangan(widget.kode, value);
    });
    blocFitur.resUndanganDetail.listen((value) {
      if(mounted)
      setState(() {
        kode = value.kodeUdangan;
        nama = value.ustadz.nama;
        alamat = value.ustadz.kota;
        length = value.list.length;
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
              height: MediaQuery.of(context).size.height / 4,
              color: Colors.grey[300],
              child: Stack(
                children: <Widget>[
                  Container(
                    height: MediaQuery.of(context).size.height / 4 - 60,
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
                            Icon(
                              Icons.arrow_back_ios,
                              color: Colors.white,
                            ),
                            Text(
                              "Detail Undangan",
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
                          borderRadius: BorderRadius.circular(12)),
                      height: 100,
                      width: MediaQuery.of(context).size.width - 50,
                      child: Stack(
                        children: <Widget>[
                          Image.asset("assets/tiket_detail.png"),
                          Container(
                            padding: EdgeInsets.only(top: 14,left: 27),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text("Nomor Undangan",style: TextStyle(color: Color(0xffF1C40F)),),
                                SizedBox(height: 12,),
                                Text("$kode",style: TextStyle(color: Colors.white,fontSize: 21,fontWeight: FontWeight.bold),)
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
            SizedBox(height: 12,),
            Center(
              child: Container(
                height: MediaQuery.of(context).size.height/2+115,
                width: MediaQuery.of(context).size.width-30,
                padding: EdgeInsets.all(18),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.white
                ),
                child: Stack(
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text("Penerima",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16)),
                        SizedBox(height: 12,),
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
                                Text("$nama",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),
                                SizedBox(height: 5,),
                                Text("Penceramah",style: TextStyle(color: Color(0xffE67E22),fontSize: 12),),
                                SizedBox(height: 5,),
                                Text("$alamat",style: TextStyle(color: Colors.grey,fontSize: 12)),
                              ],
                            )
                          ],
                        ),
                        SizedBox(height: 12,),
                        Text("Status Undangan",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16)),
                        SizedBox(height: 18,),
                        Row(
                          children: <Widget>[
                            Icon(Icons.brightness_1,color: Colors.white,),
                            Container(
                              margin: EdgeInsets.only(left: 8),
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.only(right: 8),
                                    width:50,
                                      height: 50,
                                      decoration: BoxDecoration(
                                        color: Color(0xff2ECC71),
                                        borderRadius: BorderRadius.circular(12)
                                      ),
                                      child: Icon(Icons.mail_outline,color: Colors.white,)),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text("Undangan Terikirim"),
                                      Container(
                                          width: 180,
                                          child: Text("Undangan telah dikirim. Silahkan tunggu konfirmasi dari penerima.",style: TextStyle(fontSize: 11,color: Colors.grey),)),

                                    ],
                                  )
                                ],
                              ),
                            ),
                            Text("11:00:19"),
                          ],
                        ),
                        SizedBox(height: 18,),
                        Row(
                          children: <Widget>[
                            Icon(Icons.brightness_1,color: Colors.white,),
                            Container(
                              margin: EdgeInsets.only(left: 8),
                              child: Row(
                                children: <Widget>[
                                  Container(
                                      margin: EdgeInsets.only(right: 8),
                                      width:50,
                                      height: 50,
                                      decoration: BoxDecoration(
                                          color: length>1?Color(0xff2ECC71):Colors.grey,
                                          borderRadius: BorderRadius.circular(12)
                                      ),
                                      child: Icon(Icons.mail_outline,color: Colors.white,)),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text("Dikonfirmasi"),
                                      Container(
                                          width: 180,
                                          child: Text("Undangan telah dikonfirmasi penerima.",style: TextStyle(fontSize: 11,color: Colors.grey),)),

                                    ],
                                  )
                                ],
                              ),
                            ),
                            Text("11:00:19"),
                          ],
                        ),
                        SizedBox(height: 18,),
                        Row(
                          children: <Widget>[
                            Icon(Icons.brightness_1,color: Colors.white,),
                            Container(
                              margin: EdgeInsets.only(left: 8),
                              child: Row(
                                children: <Widget>[
                                  Container(
                                      margin: EdgeInsets.only(right: 8),
                                      width:50,
                                      height: 50,
                                      decoration: BoxDecoration(
                                          color: length>2?Color(0xff2ECC71):Colors.grey,
                                          borderRadius: BorderRadius.circular(12)
                                      ),
                                      child: Icon(Icons.mail_outline,color: Colors.white,)),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text("Dihadiri"),
                                      Container(
                                          width: 180,
                                          child: Text("Ustadz pilihan Anda sedang menghadiri undangan yang Anda buat.",style: TextStyle(fontSize: 11,color: Colors.grey),)),

                                    ],
                                  )
                                ],
                              ),
                            ),
                            Text("11:00:19"),
                          ],
                        ),
                        SizedBox(height: 18,),
                        Row(
                          children: <Widget>[
                            Icon(Icons.brightness_1,color: Colors.white,),
                            Container(
                              margin: EdgeInsets.only(left: 8),
                              child: Row(
                                children: <Widget>[
                                  Container(
                                      margin: EdgeInsets.only(right: 8),
                                      width:50,
                                      height: 50,
                                      decoration: BoxDecoration(
                                          color: length>3?Color(0xffF1C40F):Colors.grey,
                                          borderRadius: BorderRadius.circular(12)
                                      ),
                                      child: Icon(Icons.star,color: Colors.white,)),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text("Selesai"),
                                      Container(
                                          width: 180,
                                          child: Text("Selamat undangan telah dihadiri.Berikan ulasan pengalaman Anda.",style: TextStyle(fontSize: 11,color: Colors.grey),)),

                                    ],
                                  )
                                ],
                              ),
                            ),
                            Text("11:00:19"),
                          ],
                        ),
                        SizedBox(height: 18,),
                        Container(
                          width: MediaQuery.of(context).size.width-50,
                          height: 50,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: colorses.biru2
                          ),
                          child: Center(child: Text("Beri Ulasan",style: TextStyle(color: Colors.white),)),
                        )
                      ],
                    ),
                    Positioned(
                      top: 160,
                      child: Column(
                        children: <Widget>[
                          Icon(Icons.brightness_1,color: Color(0xff2ECC71),),
                          Container(
                            height: 47,
                            width: 1,
                            color: length>1?Color(0xffF1C40F):Color(0xff95A5A6),
                          ),
                          Icon(Icons.brightness_1,color: length>1?Color(0xffF1C40F):Color(0xff95A5A6),),
                          Container(
                            height: 47,
                            width: 1,
                            color: length>2?Color(0xffF1C40F):Color(0xff95A5A6),
                          ),
                          Icon(Icons.brightness_1,color: length>2?Color(0xffF1C40F):Color(0xff95A5A6),),
                          Container(
                            height: 47,
                            width: 1,
                            color: length>3?Color(0xffF1C40F):Color(0xff95A5A6),
                          ),
                          Icon(Icons.brightness_1,color: length>3?Color(0xffF1C40F):Color(0xff95A5A6),),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
