import 'package:daikita/src/blocs/chatBloc.dart';
import 'package:daikita/src/models/getChatListDetailModel.dart';
import 'package:daikita/src/pref/preferences.dart';
import 'package:daikita/src/resources/publicUrl.dart';
import 'package:daikita/src/ui/utils/colorses.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

class ChatRoom extends StatefulWidget {
  ChatRoom({this.email, this.nama, this.foto});

  String nama;
  String email;
  String foto;

  @override
  _ChatRoomState createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  var _pesan = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    getToken().then((token) {
      blocChat.checkChatDetail(token, widget.email);
      blocChat.resCheckChatDetail.listen((value) {
        if (value.topik != "") {
          blocChat.chatListDetail(token, widget.email, value.topik);
        } else {
          blocChat.chatListDetail(token, widget.email, "");
        }
        setState(() {});
      });
    });
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70.0),
        child: AppBar(
          backgroundColor: colorses.biru2,
          centerTitle: false,
          title: Padding(
            padding: const EdgeInsets.only(top: 12.0),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 23,
                  backgroundImage: widget.foto == null
                      ? NetworkImage(
                          "https://3.bp.blogspot.com/-a6eXQ7JDago/WR6wYhHcp3I/AAAAAAAAB98/3QxH69fmBN85FPA5_PBATBSejiC2w-JHgCLcB/s1600/Flat%2BMusth%2B2.png",
                        )
                      : NetworkImage('${urlVps + widget.foto}'),
                  // fit: BoxFit.cover,
                ),
                SizedBox(
                  width: 8,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${widget.nama}",
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    Text(
                      'online',
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                  ],
                ),
              ],
            ),
          ),
          actions: [
            // IconButton(
            //     icon: Icon(
            //       Icons.videocam,
            //       size: 28,
            //     ),
            //     onPressed: () {}),
            // IconButton(
            //     icon: Icon(
            //       Icons.call,
            //       size: 28,
            //     ),
            //     onPressed: () {
            //       Toast.show("Fitur dalam pengembangan", context, duration: Toast.LENGTH_LONG, gravity: Toast.CENTER);
            //     })
          ],
          elevation: 0,
        ),
      ),
      backgroundColor: colorses.biru2,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Column(
          children: [
            Expanded(
              child: Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                  child: StreamBuilder(
                      stream: blocChat.resChatListDetail,
                      builder: (context, AsyncSnapshot<GetChatListDetailModel> snapshot) {
                        if (snapshot.hasData) {
                          return snapshot.data.pesan.isEmpty
                              ? Container(
                                  child: Center(child: Text("Belum ada pesan")),
                                )
                              : ListView.builder(
                                  reverse: true,
                                  itemCount: snapshot.data.pesan.length,
                                  itemBuilder: (context, int index) {
                                    final message = snapshot.data.pesan[index];
                                    bool isMe = message.ke == widget.email;
                                    return Container(
                                      margin: EdgeInsets.only(top: 10),
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.end,
                                            children: [
                                              // if (!isMe)
                                              //   CircleAvatar(
                                              //     radius: 15,
                                              //     backgroundImage: AssetImage(user.avatar),
                                              //   ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Container(
                                                padding: EdgeInsets.all(10),
                                                constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.6),
                                                decoration: BoxDecoration(
                                                    color: isMe ? colorses.hijaucerahg2 : Colors.grey[200],
                                                    borderRadius: BorderRadius.only(
                                                      topLeft: Radius.circular(16),
                                                      topRight: Radius.circular(16),
                                                      bottomLeft: Radius.circular(isMe ? 12 : 0),
                                                      bottomRight: Radius.circular(isMe ? 0 : 12),
                                                    )),
                                                child: Text(
                                                  snapshot.data.pesan[index].isi,
                                                  style: colorses.bodyTextMessage
                                                      .copyWith(color: isMe ? Colors.white : Colors.grey[800]),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(top: 5),
                                            child: Row(
                                              mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
                                              children: [
                                                if (!isMe)
                                                  SizedBox(
                                                    width: 40,
                                                  ),
                                                Icon(
                                                  Icons.done_all,
                                                  size: 20,
                                                  color: message.read ? Colors.blue : colorses.bodyTextTime.color,
                                                ),
                                                SizedBox(
                                                  width: 8,
                                                ),
                                                Text(
                                                  message.createdAt.hour.toString() + ":" + message.createdAt.minute.toString(),
                                                  style: colorses.bodyTextTime,
                                                )
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    );
                                  });
                        } else {
                          return Center(child: CircularProgressIndicator());
                        }
                      }),
                ),
              ),
            ),
            buildChatComposer()
          ],
        ),
      ),
    );
  }

  Container buildChatComposer() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      color: Colors.white,
      height: 100,
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 14),
              height: 60,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(30),
              ),
              child: Row(
                children: [
                  // Icon(
                  //   Icons.insert_emoticon,
                  //   color: Colors.grey[500],
                  // ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: TextField(
                      controller: _pesan,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Type your message ...',
                        hintStyle: TextStyle(color: Colors.grey[500]),
                      ),
                    ),
                  ),
                  // Icon(
                  //   Icons.attach_file,
                  //   color: Colors.grey[500],
                  // )
                ],
              ),
            ),
          ),
          SizedBox(
            width: 16,
          ),
          InkWell(
            onTap: () {
              if (_pesan.text.isNotEmpty) {
                getToken().then((token) {
                  blocChat.sendChat(token, widget.email, _pesan.text);
                  blocChat.resSendChat.listen((value) {
                    if (value.hasil) {
                      _pesan.clear();
                      blocChat.chatListDetail(token, widget.email, value.topik);
                      setState(() {});
                    }
                  });
                });
              }
            },
            child: CircleAvatar(
              backgroundColor: colorses.hijaucerahg2,
              child: Icon(
                Icons.send,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
    );
  }
}
