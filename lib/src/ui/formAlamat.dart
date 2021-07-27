import 'package:daikita/src/blocs/memberBloc.dart';
import 'package:daikita/src/models/getKecamatanModel.dart';
import 'package:daikita/src/models/getKotaModel.dart';
import 'package:daikita/src/models/getProvinsiModel.dart';
import 'package:daikita/src/pref/preferences.dart';
import 'package:daikita/src/ui/utils/colorses.dart';
import 'package:daikita/src/ui/utils/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:toast/toast.dart';

class FormAlamat extends StatefulWidget {
  FormAlamat({this.email});
  String email;
  @override
  _FormAlamatState createState() => _FormAlamatState();
}

class _FormAlamatState extends State<FormAlamat> {

  int _provinsi;
  int _kota;
  int _kecamatan;
  String _selectedProvinsi;
  String _selectedKota;
  String _selectedKecamatan;

  @override
  void initState() {
    memberBloc.getProvinsi();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
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
                            InkWell(
                              onTap: (){
                                Navigator.of(context).pop();
                              },
                              child: Icon(
                                Icons.arrow_back_ios,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "Daftar Baru",
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
              margin: EdgeInsets.only(left: 30),
              width: MediaQuery.of(context).size.width/2 + 50,
              child: Text("Daftarkan Diri Anda Sekarang!",style: TextStyle(fontSize: 31,fontWeight: FontWeight.bold),),
            ),
            Container(
              margin: EdgeInsets.only(top: 12,left: 30),
              width: MediaQuery.of(context).size.width/2 + 50,
              child: Text("Dengan melengkapi alamat Anda.",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
            ),
            SizedBox(height: 20,),
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
                                child: new Text(value.provinsi,style: TextStyle(fontSize: 14.0),)),
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
                  margin: EdgeInsets.only(top: 5,left: 30),
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 1),
                  width: MediaQuery.of(context).size.width * 0.8 /2 ,
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
                          child: Center(child: Text("Kota")),);
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
            SizedBox(height: 25,),
            InkWell(
              onTap: (){
                if(_selectedProvinsi== null||_selectedKota==null || _selectedKecamatan==null){
                  setState(() {
                    Toast.show("Lengkapi alamat anda", context,
                        duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
                  });
                }else{
                    Dialogs.showLoading(context,"Loading");
                    memberBloc.afterLoginGmail(widget.email, _selectedProvinsi, _selectedKota, _selectedKecamatan);
                    memberBloc.resAfterLoginGmail.listen((data) {
                      if(data.hasil){
                        FocusScope.of(context).requestFocus(new FocusNode());
                        Dialogs.dismiss(context);
                        Future.delayed(Duration(seconds: 1)).then((value) {
                          setToken(data.data.token);
                          setKota(data.data.kota);
                          setNama(data.data.fullname);
                          setTipe(data.type);
                          Navigator.pushReplacementNamed(context, '/controllerPage');
                        });
                      }else{
                        Dialogs.dismiss(context);
                        Future.delayed(Duration(seconds: 1)).then((value) {
                          Dialogs.dismiss(context);
                          FocusScope.of(context).requestFocus(new FocusNode());
                          Toast.show(data.message, context,
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
                }
              },
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 5,horizontal: 30),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 1),
                width: MediaQuery.of(context).size.width * 0.8,
                height: 50,
                decoration: BoxDecoration(
                    color: colorses.hijaudasar,
                    borderRadius: BorderRadius.circular(12)
                ),
                child: Center(child: Text("Daftar",style: TextStyle(color: Colors.white),)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
