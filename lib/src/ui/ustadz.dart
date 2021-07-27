import 'package:daikita/src/blocs/fiturBloc.dart';
import 'package:daikita/src/models/getListUstadzModel.dart';
import 'package:daikita/src/pref/preferences.dart';
import 'package:daikita/src/ui/buatJadwal.dart';
import 'package:daikita/src/ui/cariUstadz.dart';
import 'package:daikita/src/ui/profileUstadz.dart';
import 'package:daikita/src/ui/utils/colorses.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:page_transition/page_transition.dart';

class Ustadz extends StatefulWidget {
  @override
  _UstadzState createState() => _UstadzState();
}

class _UstadzState extends State<Ustadz> {


  @override
  void initState() {
    getKota().then((kota){
      getToken().then((token){
        blocFitur.getListUstadz(kota, token);
      });
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
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
                        Icon(
                          Icons.arrow_back_ios,
                          color: Colors.white,
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
                child: InkWell(
                  onTap: (){
                    Navigator.push(
                        context,
                        PageTransition(
                            type: PageTransitionType.rightToLeft,
                            duration: Duration(milliseconds: 200),
                            child: CariUstadz()));
                  },
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
                          child: Text(
                            "Cari Nama atau Lokasi",
                            style: TextStyle(fontSize: 14, color: Colors.grey),
                          ),
                        ),
                        Icon(
                          Icons.search,
                          size: 25,
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        SizedBox(
          height: 40,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                "Populer",
                style: TextStyle(color: Colors.black, fontSize: 16),
              ),
              Text(
                "Lihat Semua",
                style: TextStyle(color: Colors.grey, fontSize: 12),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 20,
        ),
        // Container(
        //   margin: EdgeInsets.only(left: 20),
        //   height: 120,
        //   child: Stack(
        //     children: <Widget>[
        //       Container(
        //         height: 120,
        //         width: 120,
        //         decoration: BoxDecoration(
        //             borderRadius: BorderRadius.circular(8),
        //             image: DecorationImage(
        //                 image: NetworkImage("https://static.republika.co.id/uploads/images/inpicture_slide/ustadz-dasad_200323174952-769.jpg"), fit: BoxFit.cover)),
        //       ),
        //       Positioned(
        //         bottom: 0,
        //         child: Container(
        //           height: 120,
        //           width: 120,
        //           decoration: BoxDecoration(
        //             borderRadius: BorderRadius.circular(8),
        //             gradient: new LinearGradient(
        //               colors: [Colors.white12,colorses.biru2],
        //               begin: Alignment.topCenter,
        //               end: Alignment.bottomCenter,
        //             ),
        //           ),
        //         ),
        //       ),
        //       Positioned(
        //           bottom: 12,
        //           right: 12,
        //           left: 12,
        //           child: Container(
        //             width: MediaQuery.of(context).size.width,
        //             child: Column(
        //               crossAxisAlignment: CrossAxisAlignment.start,
        //               children: <Widget>[
        //                 Text(
        //                   "Nama",
        //                   style: TextStyle(color: Colors.white,),
        //                 ),
        //                 Text(
        //                   "Alamat",
        //                   style: TextStyle(color: Colors.yellow,fontSize: 12),
        //                 ),
        //               ],
        //             ),
        //           )),
        //     ],
        //   ),
        // ),
        SizedBox(
          height: 40,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                "Rekomendasi",
                style: TextStyle(color: Colors.black, fontSize: 16),
              ),
              Text(
                "Lihat Semua",
                style: TextStyle(color: Colors.grey, fontSize: 12),
              ),
            ],
          ),
        ),
        Expanded(
          child: Container(
            margin: EdgeInsets.all(12),
            child: StreamBuilder(
                stream: blocFitur.resListUstadz,
                builder: (context, AsyncSnapshot<GetListUstadzModel> snapshot) {
                  if(snapshot.hasData){
                    return GridView.builder(
                        itemCount: snapshot.data.result.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3,crossAxisSpacing: 8,mainAxisSpacing: 8),
                        itemBuilder: (BuildContext context, int i) {
                          return InkWell(
                            onTap: (){
                              Navigator.push(
                                  context,
                                  PageTransition(
                                      type: PageTransitionType.rightToLeft,
                                      duration: Duration(milliseconds: 200),
                                      child: ProfileUstadz(data: snapshot.data.result[i],image:snapshot.data.result[i].foto)));
                            },
                            child: Stack(
                              children: <Widget>[
                                Container(
                                  height: 120,
                                  width: 120,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      image: DecorationImage(
                                          image: snapshot.data.result[i].foto== null?NetworkImage("https://3.bp.blogspot.com/-a6eXQ7JDago/WR6wYhHcp3I/AAAAAAAAB98/3QxH69fmBN85FPA5_PBATBSejiC2w-JHgCLcB/s1600/Flat%2BMusth%2B2.png"): NetworkImage(
                                             snapshot.data.result[i].foto),
                                          fit: BoxFit.cover)),
                                ),
                                Positioned(
                                  bottom: 0,
                                  child: Container(
                                    height: 120,
                                    width: 120,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      gradient: new LinearGradient(
                                        colors: [Colors.white12, colorses.biru2],
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                    bottom: 12,
                                    right: 12,
                                    left: 12,
                                    child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            "${snapshot.data.result[i].fullName}",
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 13,
                                            ),
                                          ),
                                          Text(
                                            "${snapshot.data.result[i].kecamatan}",
                                            style: TextStyle(color: Colors.yellow, fontSize: 12),
                                          ),
                                        ],
                                      ),
                                    )),
                              ],
                            ),
                          );
                        });
                  }else{
                    return Center(child: CircularProgressIndicator());
                  }
                }),
          ),
        ),
      ],
    ));
  }
}
