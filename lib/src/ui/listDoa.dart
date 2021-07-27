import 'package:daikita/src/blocs/fiturBloc.dart';
import 'package:daikita/src/models/getListDoaModel.dart';
import 'package:daikita/src/ui/detailDoa.dart';
import 'package:daikita/src/ui/utils/colorses.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:page_transition/page_transition.dart';

class ListDoa extends StatefulWidget {
  ListDoa({this.label,this.judul});
  String label;
  String judul;
  @override
  _ListDoaState createState() => _ListDoaState();
}

class _ListDoaState extends State<ListDoa> {
  List<Result> kategoriList = List<Result>();
  List<Result> kategoriListDisplay;
  @override
  void initState() {
    blocFitur.listDoa(widget.label);
    blocFitur.resListDoa.listen((value) {
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
    return Scaffold(
      backgroundColor: Colors.grey[300],
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
          SizedBox(height: 12,),
          Expanded(
            child: StreamBuilder(
                stream: blocFitur.resListDoa,
                builder: (context, AsyncSnapshot<GetListDoaModel> snapshot) {
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
                                      child: DetailDoa(artikel: snapshot.data.result[i].kode,judul: widget.judul,)));
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
                                  Text(snapshot.data.result[i].judul),
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
          ),
        ],
      ),
    );
  }
}
