import 'package:daikita/src/blocs/chatBloc.dart';
import 'package:daikita/src/models/getChatListModel.dart';
import 'package:daikita/src/pref/preferences.dart';
import 'package:daikita/src/ui/chatRoom.dart';
import 'package:daikita/src/ui/utils/colorses.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:page_transition/page_transition.dart';

class Pesan extends StatefulWidget {
  @override
  _PesanState createState() => _PesanState();
}

class _PesanState extends State<Pesan> {
  @override
  void initState() {
    getToken().then((value) {
      blocChat.chatList(value);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Column(
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
                      padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "Pesan",
                            style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: StreamBuilder(
                stream: blocChat.resChatList,
                builder: (context, AsyncSnapshot<GetChatListModel> snapshot) {
                  if (snapshot.hasData) {
                    return snapshot.data.data.isNotEmpty
                        ? ListView.builder(
                            shrinkWrap: true,
                            padding: EdgeInsets.only(top: 3),
                            itemCount: snapshot.data.data.length,
                            itemBuilder: (BuildContext context, int i) {
                              return Column(
                                children: <Widget>[
                                  Center(
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            PageTransition(
                                                type: PageTransitionType.rightToLeft,
                                                duration: Duration(milliseconds: 200),
                                                child: ChatRoom(
                                                  email: snapshot.data.data[i].email,
                                                  nama: snapshot.data.data[i].nama,
                                                )));
                                      },
                                      child: Container(
                                        height: 80,
                                        padding: EdgeInsets.all(12),
                                        color: Colors.white,
                                        child: Row(
                                          children: <Widget>[
                                            Container(
                                              margin: EdgeInsets.only(right: 12),
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(50), color: colorses.hijaudasar),
                                              width: 50,
                                              height: 50,
                                              child: Icon(
                                                Icons.person,
                                                size: 40,
                                                color: Colors.white,
                                              ),
                                            ),
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: <Widget>[
                                                Text(
                                                  "${snapshot.data.data[i].nama}",
                                                  style: TextStyle(fontWeight: FontWeight.bold),
                                                ),
                                                Container(
                                                    width: MediaQuery.of(context).size.width - 110,
                                                    child: Text(
                                                      "${snapshot.data.data[i].isi}",
                                                      style: TextStyle(fontSize: 12, color: Colors.grey),
                                                      overflow: TextOverflow.ellipsis,
                                                    )),
                                              ],
                                            ),
                                            snapshot.data.data[i].read == 0
                                                ? Container()
                                                : Container(
                                                    width: 20,
                                                    height: 20,
                                                    decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(20), color: Colors.green),
                                                    child: Center(
                                                        child: Text(
                                                      "${snapshot.data.data[i].read}",
                                                      style: TextStyle(color: Colors.white),
                                                    )),
                                                  )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Divider(
                                    height: 2,
                                  )
                                ],
                              );
                            })
                        : Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  "Belum Ada pesan",
                                  style: TextStyle(color: Colors.grey),
                                )
                              ],
                            ),
                          );
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
