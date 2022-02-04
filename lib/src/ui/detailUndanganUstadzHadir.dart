import 'package:daikita/src/blocs/fiturBloc.dart';
import 'package:daikita/src/pref/preferences.dart';
import 'package:daikita/src/ui/undanganSayaUstadz.dart';
import 'package:daikita/src/ui/utils/colorses.dart';
import 'package:daikita/src/ui/utils/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import 'package:toast/toast.dart';

class DetailUndanganUstadzHadir extends StatefulWidget {
  DetailUndanganUstadzHadir({this.kode,this.nama,this.jenis,this.tema,this.tgl,this.jam,this.akomodasi,this.alamat});
  String kode,nama,jenis,tema,jam,akomodasi,alamat;
  DateTime tgl;
  @override
  _DetailUndanganUstadzHadirState createState() => _DetailUndanganUstadzHadirState();
}

class _DetailUndanganUstadzHadirState extends State<DetailUndanganUstadzHadir> {
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
                    "Konfirmasi Undangan",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Divider(color: Colors.black,),
                  Text("Nomor Undangan",style: TextStyle(fontWeight: FontWeight.bold),),
                  SizedBox(
                    height: 8,
                  ),
                  Text("${widget.kode}",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.red),),
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
                          "Undangan",
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Text("${widget.nama}"),
                        Text("${widget.tgl.day} ${DateFormat('MMMM',"id_ID").format(widget.tgl)} ${widget.tgl.year}"),
                        Text("${widget.jam}"),
                        Text("${widget.jenis}"),
                        Text("${widget.tema}"),
                        Text("${widget.alamat}"),
                        Text("${widget.akomodasi}"),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              height: 5,
            ),
          ),
          InkWell(
            onTap: () {
              Dialogs.showLoading(context, "Loading");
              getToken().then((value) => blocFitur.ustadzKonfirm(widget.kode, "Finish", value));
              blocFitur.resustadzKonfirmasi.listen((data) {
                if(data.hasil){
                  Dialogs.dismiss(context);
                  Future.delayed(Duration(seconds: 2)).then((value) {
                    Dialogs.dismiss(context);
                    Navigator.of(context)
                        .pushNamedAndRemoveUntil('/undanganSayaUstadz3', (Route<dynamic> route) => false);
                  });
                }else{
                  Dialogs.dismiss(context);
                  Future.delayed(Duration(seconds: 1)).then((value) {
                    Dialogs.dismiss(context);
                    FocusScope.of(context).requestFocus(new FocusNode());
                    Toast.show(value.message, context,
                        duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
                  });
                }
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
                      "Dihadiri",
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
