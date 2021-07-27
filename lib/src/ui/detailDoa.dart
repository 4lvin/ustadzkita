import 'package:daikita/src/blocs/fiturBloc.dart';
import 'package:daikita/src/pref/preferences.dart';
import 'package:daikita/src/ui/utils/colorses.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/svg.dart';
import 'package:toast/toast.dart';

class DetailDoa extends StatefulWidget {
  DetailDoa({this.artikel,this.judul});
  String artikel;
  String judul;
  @override
  _DetailDoaState createState() => _DetailDoaState();
}

class _DetailDoaState extends State<DetailDoa> {

  String isi;
  String judul;
  String tok;
  String artikel;
  bool mark = false;
  @override
  void initState() {
    getToken().then((token){
      blocFitur.detailDoa(token, widget.artikel);
      if(mounted)
      setState(() {
        tok = token;
      });
    });
    blocFitur.resDetailDoa.listen((value) {
      if(mounted)
      setState(() {
        isi = value.result.isi;
        judul = value.result.judul;
        mark = value.mark;
        artikel = value.result.kode;
      });
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
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
                            "${widget.judul}",
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
                    padding: EdgeInsets.only(left: 12,right: 12),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(topRight: Radius.circular(18),topLeft: Radius.circular(18)), color: Colors.white),
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                          Text(judul??""),
                          InkWell(
                          onTap: (){
                            print(tok);
                            blocFitur.markArtikel(tok, artikel);
                            blocFitur.resMarkArtikel.listen((value) {
                              if(value.hasil){
                                Toast.show("Berhasil ditandai!", context,
                                    duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
                                setState(() {
                                  mark = value.mark;
                                });
                              }else{
                                Toast.show("Gagal ditandai!"+value.message, context,
                                    duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
                              }
                            });
                          },
                            child: Icon(mark?Icons.bookmark:Icons.bookmark_border,color: Colors.orangeAccent,))
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width-45,
                      child: Html(data: isi??"")),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
