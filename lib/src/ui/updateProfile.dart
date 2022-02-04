import 'dart:async';
import 'dart:io';

import 'package:daikita/src/blocs/memberBloc.dart';
import 'package:daikita/src/models/getKecamatanModel.dart';
import 'package:daikita/src/models/getKotaModel.dart';
import 'package:daikita/src/models/getProvinsiModel.dart';
import 'package:daikita/src/pref/preferences.dart';
import 'package:daikita/src/resources/publicUrl.dart';
import 'package:daikita/src/ui/utils/colorses.dart';
import 'package:daikita/src/ui/utils/loading.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:toast/toast.dart';

class UpdateProfile extends StatefulWidget {
  @override
  _UpdateProfileState createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  var _nama = TextEditingController();
  var _statusNikah = TextEditingController();
  var _alamat = TextEditingController();
  var _negara = TextEditingController();
  bool _validate = false;
  PickedFile imageFile;
  String token;
  String fotos;
  int _provinsi = 0;
  int _kota =0;
  int _kecamatan = 0;
  String _selectedProvinsi;
  String _selectedKota;
  String _selectedKecamatan;

  Future getImage(int type) async {
    PickedFile pickedImage =
        await ImagePicker().getImage(source: type == 1 ? ImageSource.camera : ImageSource.gallery, imageQuality: 50);
    return pickedImage;
  }

  @override
  void initState() {
    getToken().then((value) {
      memberBloc.getProfil(value);
      token = value;
    });
    memberBloc.getProvinsi();
    memberBloc.resProfil.listen((value) {
      if (mounted)
        setState(() {
          _nama.text = value.result[0].fullName;
          fotos = value.result[0].foto;
          _statusNikah.text = value.result[0].statusPernikahan;
          _negara.text = value.result[0].kewarganegaraan;
          _alamat.text = value.result[0].alamatDetail;
          _selectedProvinsi = value.result[0].provinsiId.kode;
          _selectedKota = value.result[0].kotaId.kode;
          _selectedKecamatan = value.result[0].kecamatanId.kode;
          memberBloc.getKecamatan(value.result[0].provinsiId.kode,value.result[0].kotaId.kode);
          memberBloc.getKota(value.result[0].provinsiId.kode);
        });
    });
      memberBloc.resProvinsi.listen((prov) {
        for (var i = 0; i < prov.result.length; i++) {
          if (prov.result[i].kode == _selectedProvinsi) {
            if (mounted)
              setState(() {
                // _provinsi.text = prov.result[i].provinsi;
                _provinsi = i;
              });
          }
        }
      });
      memberBloc.resKota.listen((kota) {
        for (var i = 0; i < kota.result.length; i++) {
          if (kota.result[i].kode == _selectedKota) {
            if (mounted)
              setState(() {
                _kota = i;
              });
          }
        }
      });
      memberBloc.resKecamatan.listen((kec) {
        for (var i = 0; i < kec.result.length; i++) {
          if (kec.result[i].kode == _selectedKecamatan) {
            if (mounted)
              setState(() {
                // _provinsi.text = prov.result[i].provinsi;
                _kecamatan = i;
              });
          }
        }
      });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit profile"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            imageFile == null && fotos == null
                ? InkWell(
                    onTap: () async {
                      final tmpFile = await getImage(2);

                      setState(() {
                        imageFile = tmpFile;
                      });
                    },
                    child: Container(
                      height: MediaQuery.of(context).size.width * 0.3,
                      width: MediaQuery.of(context).size.width * 0.34,
                      margin: EdgeInsets.only(top: 21, bottom: 21),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 4,
                            blurRadius: 4,
                            offset: Offset(0, 2), // changes position of shadow
                          ),
                        ],
                        borderRadius: BorderRadius.all(
                          Radius.circular(20.0),
                        ),
                        border: Border.all(
                          width: 2,
                          color: colorses.hijaudasar,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.camera_alt, color: colorses.hijaudasar, size: 35),
                          Text(
                            'Unggah Foto',
                            style: TextStyle(fontSize: 16, color: colorses.hijaudasar),
                          ),
                        ],
                      ),
                    ),
                  )
                : fotos != null
                    ? InkWell(
                        onTap: () async {
                          final tmpFile = await getImage(2);

                          setState(() {
                            imageFile = tmpFile;
                          });
                        },
                        child: Container(
                          height: MediaQuery.of(context).size.width * 0.3,
                          width: MediaQuery.of(context).size.width * 0.34,
                          margin: EdgeInsets.only(top: 21, bottom: 21),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.3),
                                spreadRadius: 4,
                                blurRadius: 4,
                                offset: Offset(0, 2), // changes position of shadow
                              ),
                            ],
                            borderRadius: BorderRadius.all(
                              Radius.circular(8.0),
                            ),
                            image: DecorationImage(
                              image: NetworkImage('${urlVps + fotos}'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      )
                    : InkWell(
                        onTap: () async {
                          final tmpFile = await getImage(2);

                          setState(() {
                            imageFile = tmpFile;
                          });
                        },
                        child: Container(
                          height: MediaQuery.of(context).size.width * 0.3,
                          width: MediaQuery.of(context).size.width * 0.34,
                          margin: EdgeInsets.only(top: 21, bottom: 21),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.3),
                                spreadRadius: 4,
                                blurRadius: 4,
                                offset: Offset(0, 2), // changes position of shadow
                              ),
                            ],
                            borderRadius: BorderRadius.all(
                              Radius.circular(8.0),
                            ),
                            image: DecorationImage(
                              image: FileImage(
                                File(imageFile.path),
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 5, horizontal: 30),
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 1),
              width: MediaQuery.of(context).size.width * 0.8,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(8),
              ),
              child: TextField(
                controller: _nama,
                cursorColor: colorses.hijaudasar,
                decoration: InputDecoration(
                  hintText: "Nama Lengkap",
                  border: InputBorder.none,
                  errorText: _nama.text.length < 3 && _validate ? 'Nama Lengkap harus diisi !' : null,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 5,horizontal: 30),
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 1),
              width: MediaQuery.of(context).size.width * 0.8,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(8),
              ),
              child: StreamBuilder(
                  stream: memberBloc.resProvinsi,
                  builder: (context, AsyncSnapshot<GetProvinsiModel> snapshot) {
                    if(snapshot.hasData){
                      return new DropdownButton<ResultProv>(
                        isExpanded: true,
                        items: snapshot.data.result.map((ResultProv value) {
                          return new DropdownMenuItem<ResultProv>(
                            value: value,
                            child: Container(
                                width: 140.0,
                                child: new Text("${value.provinsi}",style: TextStyle(fontSize: 14.0),)),
                          );
                        }).toList(),
                        value: _provinsi == null? null:snapshot.data.result[_provinsi],
                        hint: Text(
                          "pilih Provinsi",
                          style: TextStyle(fontSize: 14.0),
                        ),
                        onChanged: (value) {
                          setState(() {
                            FocusScope.of(context).requestFocus(new FocusNode());
                            _provinsi = snapshot.data.result.indexOf(value);
                            _selectedProvinsi = value.kode;
                            memberBloc.getKota(_selectedProvinsi);
                          });
                        },
                      );
                    }
                    return Container(
                      child: Text("loading.."),);
                  }
              ),
            ),

            Row(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: 5,left: 40),
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 1),
                  width: MediaQuery.of(context).size.width * 0.8 /2 - 5 ,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: StreamBuilder(
                      stream: memberBloc.resKota,
                      builder: (context, AsyncSnapshot<GetKotaModel> snapshot) {
                        if(snapshot.hasData){
                          return new DropdownButton<ResultKota>(
                            isExpanded: true,
                            items: snapshot.data.result.map((ResultKota value) {
                              return new DropdownMenuItem<ResultKota>(
                                value: value,
                                child: Container(
                                    width: 140.0,
                                    child: new Text(value.kota,style: TextStyle(fontSize: 14.0),)),
                              );
                            }).toList(),
                            value: _kota == null? null:snapshot.data.result[_kota],
                            hint: Text(
                              "pilih Kota",
                              style: TextStyle(fontSize: 14.0),
                            ),
                            onChanged: (value) {
                              setState(() {
                                FocusScope.of(context).requestFocus(new FocusNode());
                                _kota = snapshot.data.result.indexOf(value);
                                _selectedKota = value.kode;
                                memberBloc.getKecamatan(_selectedProvinsi,value.kode);
                              });
                            },
                          );
                        }
                        return Container(
                          height: 45,
                          child: Center(child: Text("kota")),);
                      }
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 5,left: 5),
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 1),
                  width: MediaQuery.of(context).size.width * 0.8 /2 ,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: StreamBuilder(
                      stream: memberBloc.resKecamatan,
                      builder: (context, AsyncSnapshot<GetKecamatanModel> snapshot) {
                        if(snapshot.hasData){
                          return new DropdownButton<ResultKecamatan>(
                            isExpanded: true,
                            items: snapshot.data.result.map((ResultKecamatan value) {
                              return new DropdownMenuItem<ResultKecamatan>(
                                value: value,
                                child: Container(
                                    width: 140.0,
                                    child: new Text(value.kecamatan,style: TextStyle(fontSize: 14.0),)),
                              );
                            }).toList(),
                            value: _kecamatan == null? null:snapshot.data.result[_kecamatan],
                            hint: Text(
                              "pilih Kecamatan",
                              style: TextStyle(fontSize: 14.0),
                            ),
                            onChanged: (value) {
                              setState(() {
                                FocusScope.of(context).requestFocus(new FocusNode());
                                _kecamatan = snapshot.data.result.indexOf(value);
                                _selectedKecamatan = value.kode;
                              });
                            },
                          );
                        }
                        return Container(
                          height: 45,
                          child: Center(child: Text("Kecamatan")),);
                      }
                  ),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 5, horizontal: 30),
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 1),
              width: MediaQuery.of(context).size.width * 0.8,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(8),
              ),
              child: TextField(
                controller: _statusNikah,
                cursorColor: colorses.hijaudasar,
                decoration: InputDecoration(
                  hintText: "Status Pernikahan",
                  border: InputBorder.none,
                  errorText: _statusNikah.text.length < 3 && _validate ? 'Status Pernikahan harus diisi !' : null,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 5, horizontal: 30),
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 1),
              width: MediaQuery.of(context).size.width * 0.8,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(8),
              ),
              child: TextField(
                controller: _negara,
                cursorColor: colorses.hijaudasar,
                decoration: InputDecoration(
                  hintText: "Kewarganegaraan",
                  border: InputBorder.none,
                  errorText: _negara.text.length < 3 && _validate ? 'Kewarganegaraan harus diisi !' : null,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 5, horizontal: 30),
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 1),
              width: MediaQuery.of(context).size.width * 0.8,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(8),
              ),
              child: TextField(
                controller: _alamat,
                cursorColor: colorses.hijaudasar,
                decoration: InputDecoration(
                  hintText: "Alamat",
                  border: InputBorder.none,
                  errorText: _alamat.text.length < 3 && _validate ? 'Alamat harus diisi !' : null,
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Dialogs.showLoading(context, "Loading...");
                File file = imageFile != null ? File(imageFile.path) : null;
                if(file == null){
                  memberBloc.updateProfile2(_nama.text,_selectedKecamatan, _statusNikah.text, _negara.text, _alamat.text, token).then((value){
                    if (value != 200) {
                      Dialogs.dismiss(context);
                      Future.delayed(Duration(seconds: 1)).then((value) {
                        Toast.show("Gagal Menyimpan Data", context, duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
                      });
                    } else {
                      Dialogs.dismiss(context);
                      Future.delayed(Duration(seconds: 1)).then((value) {
                        Toast.show("Berhasil Menyimpan Data", context, duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
                        Navigator.pushReplacementNamed(context, '/controllerPage');
                      });
                    }
                  }).onError((error, stackTrace){
                    Dialogs.dismiss(context);
                    Toast.show("Coba lagi", context, duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
                  });
                }else {
                  memberBloc.updateProfile(token, file).then((value) {
                    if (value != 200) {
                      Dialogs.dismiss(context);
                      Future.delayed(Duration(seconds: 1)).then((value) {
                        Toast.show("Gagal Menyimpan Data", context, duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
                      });
                    } else {
                      Dialogs.dismiss(context);
                      Future.delayed(Duration(seconds: 1)).then((value) {
                        Navigator.pushReplacementNamed(context, '/controllerPage');
                      });
                    }
                  });
                }
              },
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 1),
                width: MediaQuery.of(context).size.width * 0.8,
                height: 50,
                decoration: BoxDecoration(color: colorses.hijaudasar, borderRadius: BorderRadius.circular(12)),
                child: Center(
                    child: Text(
                  "Simpan",
                  style: TextStyle(color: Colors.white),
                )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
