import 'package:daikita/src/blocs/fiturBloc.dart';
import 'package:daikita/src/models/getKategoriLabelModel.dart';
import 'package:daikita/src/models/getLabelModel.dart';
import 'package:daikita/src/pref/preferences.dart';
import 'package:daikita/src/ui/notifPostingArtikel.dart';
import 'package:daikita/src/ui/utils/colorses.dart';
import 'package:daikita/src/ui/utils/loading.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:toast/toast.dart';
class PostArtikel extends StatefulWidget {

  @override
  _PostArtikelState createState() => _PostArtikelState();
}

class _PostArtikelState extends State<PostArtikel> {
  // HtmlEditorController _artikel = HtmlEditorController();
  var _judul = TextEditingController();
  var _artikel = TextEditingController();
  bool _validate = false;
  int _kategori;
  int _label;
  String _selectedLabel="";

  @override
  void initState() {
    blocFitur.kategoriLabel();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Posting Artikel"),
      ),
      body: ListView(
        children: [
          Container(
            margin: EdgeInsets.only(left: 12, right: 12, top: 12),
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 1),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(8), border: Border.all(color: Colors.grey)),
            child: StreamBuilder(
                stream: blocFitur.resKategoriLabel,
                builder: (context, AsyncSnapshot<GetKategoriLabelModel> snapshot) {
                  if (snapshot.hasData) {
                    return new DropdownButton<ResultKatLbl>(
                      isExpanded: true,
                      items: snapshot.data.result.map((ResultKatLbl value) {
                        return new DropdownMenuItem<ResultKatLbl>(
                          value: value,
                          child: Container(
                              width: 140.0,
                              child: new Text(
                                "${value.nama}",
                                style: TextStyle(fontSize: 14.0),
                              )),
                        );
                      }).toList(),
                      value: _kategori == null ? null : snapshot.data.result[_kategori],
                      hint: Text(
                        "pilih Kategori",
                        style: TextStyle(fontSize: 14.0),
                      ),
                      onChanged: (value) {
                        setState(() {
                          FocusScope.of(context).requestFocus(new FocusNode());
                          _kategori = snapshot.data.result.indexOf(value);
                          blocFitur.getLabel(value.kode);
                        });
                      },
                    );
                  }
                  return Container(
                    child: Text("loading.."),
                  );
                }),
          ),
          Container(
            margin: EdgeInsets.only(left: 12, right: 12, top: 12),
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 1),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(8), border: Border.all(color: Colors.grey)),
            child: StreamBuilder(
                stream: blocFitur.resLabel,
                builder: (context, AsyncSnapshot<GetLabelModel> snapshot) {
                  if (snapshot.hasData) {
                    return new DropdownButton<Datum>(
                      isExpanded: true,
                      items: snapshot.data.data.map((Datum value) {
                        return new DropdownMenuItem<Datum>(
                          value: value,
                          child: Container(
                              width: 140.0,
                              child: new Text(
                                "${value.nama}",
                                style: TextStyle(fontSize: 14.0),
                              )),
                        );
                      }).toList(),
                      value: _label == null ? null : snapshot.data.data[_label],
                      hint: Text(
                        "pilih Label",
                        style: TextStyle(fontSize: 14.0),
                      ),
                      onChanged: (value) {
                        setState(() {
                          FocusScope.of(context).requestFocus(new FocusNode());
                          _label = snapshot.data.data.indexOf(value);
                          _selectedLabel = value.kode;

                        });
                      },
                    );
                  }
                  return Container(
                    padding: EdgeInsets.only(top: 8),
                    height: 30,
                    child: Text("Pilih kategori terlebih dahulu"),
                  );
                }),
          ),
          Container(
            margin: EdgeInsets.only(left: 12, right: 12, top: 12),
            child: TextField(
              controller: _judul,
              cursorColor: Color(0xff740e13),
              style: TextStyle(fontSize: 16),
              decoration: InputDecoration(
                errorText: _judul.text.length < 3 && _validate ? 'Tema/Topik !' : null,
                labelText: "Judul",
                contentPadding: EdgeInsets.only(bottom: 1, left: 12),
                border: OutlineInputBorder(
                  borderRadius: const BorderRadius.all(
                    const Radius.circular(8.0),
                  ),
                ),
              ),
              keyboardType: TextInputType.text,
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 12, right: 12, top: 12),
            child: TextField(
              controller: _artikel,
              cursorColor: Color(0xff740e13),
              style: TextStyle(fontSize: 16),
              keyboardType: TextInputType.multiline,
              minLines: 5,//Normal textInputField will be displayed
              maxLines: 7,//
              decoration: InputDecoration(
                helperMaxLines: 5,
                errorText: _artikel.text.length < 3 && _validate ? 'Aetikel !' : null,
                labelText: "Artikel",
                contentPadding: EdgeInsets.only(bottom: 1, left: 12,top: 8),
                border: OutlineInputBorder(
                  borderRadius: const BorderRadius.all(
                    const Radius.circular(8.0),
                  ),
                ),
              ),
            ),
          ),
          InkWell(
            onTap: (){
              Dialogs.showLoading(context, "Loading");
              getToken().then((value) {
                blocFitur.postArtikel(_selectedLabel, _judul.text, "", _artikel.text, value);
              });
              blocFitur.resPostArtikel.listen((respon) {
                if(respon.hasil){
                  Dialogs.dismiss(context);
                  Future.delayed(Duration(seconds: 2)).then((value) {
                    Dialogs.dismiss(context);
                    Navigator.push(
                        context,
                        PageTransition(
                            type: PageTransitionType.leftToRight, duration: Duration(milliseconds: 200), child: NotifPostArtikel()));
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
            child: Container(
              width: MediaQuery.of(context).size.width - 12,
              height: 50,
              margin: EdgeInsets.only(left: 12, right: 12, bottom: 12,top: 50),
              decoration: BoxDecoration(color: colorses.biru2, borderRadius: BorderRadius.circular(12)),
              child: Center(
                  child: Text(
                    "Simpan",
                    style: TextStyle(color: Colors.white),
                  )),
            ),
          ),
      //   HtmlEditor(
      //   controller: , //required
      //   options: HtmlEditorOptions(
      //     height: 400
      //     //initalText: "text content initial, if any",
      //   ),
      // )
        ],
      ),
    );
  }
}
