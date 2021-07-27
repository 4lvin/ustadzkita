import 'package:daikita/src/blocs/memberBloc.dart';
import 'package:daikita/src/models/getKecamatanModel.dart';
import 'package:daikita/src/models/getKotaModel.dart';
import 'package:daikita/src/models/getProvinsiModel.dart';
import 'package:daikita/src/ui/otpPage.dart';
import 'package:daikita/src/ui/utils/colorses.dart';
import 'package:daikita/src/ui/utils/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:page_transition/page_transition.dart';
import 'package:toast/toast.dart';

class Daftar extends StatefulWidget {
  @override
  _DaftarState createState() => _DaftarState();
}

class _DaftarState extends State<Daftar> {
  TextEditingController _username = TextEditingController();
  TextEditingController _nama = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _noHp = TextEditingController();
  TextEditingController _password = TextEditingController();
  TextEditingController _konfPassword = TextEditingController();
  bool passwordVisible = true;
  bool konfPasswordVisible = true;
  bool _validate = false;
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
              child: Text("Dapatkan akses undang ustadz dan fitur lainnya",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
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
              child: TextField(
                controller: _username,
                cursorColor: colorses.hijaudasar,
                decoration: InputDecoration(
                  hintText: "Username",
                  border: InputBorder.none,
                  errorText: _username.text.length < 3 && _validate ? 'Username harus diisi !' : null,
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
              child: TextField(
                controller: _email,
                cursorColor: colorses.hijaudasar,
                decoration: InputDecoration(
                  hintText: "Alamat Email",
                  border: InputBorder.none,
                  errorText: _email.text.length < 3 && _validate ? 'Alamat Email harus diisi !' : null,
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
              child: TextField(
                controller: _noHp,
                cursorColor: colorses.hijaudasar,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: "Nomor Handphone",
                  border: InputBorder.none,
                  errorText: _noHp.text.length < 3 && _validate ? 'Nomor Handphone harus diisi !' : null,
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
            Container(
              margin: EdgeInsets.symmetric(vertical: 5,horizontal: 30),
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 1),
              width: MediaQuery.of(context).size.width * 0.8,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(8),
              ),
              child: TextField(
                obscureText: passwordVisible,
                controller: _password,
                cursorColor: colorses.hijaudasar,
                decoration: InputDecoration(
                  hintText: "Password",
                  suffixIcon: IconButton(
                    icon: Icon(
                      passwordVisible ? Icons.visibility_off : Icons.visibility,
                    ),
                    color: colorses.hijaudasar,
                    onPressed: () {
                      this.setState(() {
                        passwordVisible = !passwordVisible;
                      });
                    },
                  ),
                  errorText: _password.text.length < 3 && _validate ? 'Password harus diisi !' : null,
                  border: InputBorder.none,
                ),
                // onChanged: (value){
                //   FocusScope.of(context).requestFocus(new FocusNode());
                // },
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
              child: TextField(
                obscureText: konfPasswordVisible,
                controller: _konfPassword,
                cursorColor: colorses.hijaudasar,
                decoration: InputDecoration(
                  hintText: "Konfirmasi Password",
                  suffixIcon: IconButton(
                    icon: Icon(
                      konfPasswordVisible ? Icons.visibility_off : Icons.visibility,
                    ),
                    color: colorses.hijaudasar,
                    onPressed: () {
                      this.setState(() {
                        konfPasswordVisible = !konfPasswordVisible;
                      });
                    },
                  ),
                  errorText: _konfPassword.text.length < 3 && _validate ? 'Konfirmasi Password harus diisi !' : null,
                  border: InputBorder.none,
                ),
                // onChanged: (value){
                //   FocusScope.of(context).requestFocus(new FocusNode());
                // },
              ),
            ),
            SizedBox(height: 25,),
            InkWell(
              onTap: (){
                if(_username.text.isEmpty||_nama.text.isEmpty || _email.text.isEmpty || _noHp.text.isEmpty || _password.text.isEmpty || _konfPassword.text.isEmpty){
                  setState(() {
                    _validate= true;
                  });
                }else{
                  if(_password.text == _konfPassword.text){
                    Dialogs.showLoading(context,"Loading");
                    memberBloc.daftarGuest(_username.text, _password.text, _nama.text, _noHp.text, _email.text, _selectedProvinsi, _selectedKota, _selectedKecamatan);
                    memberBloc.resRegister.listen((data) {
                      if(data.hasil){
                        FocusScope.of(context).requestFocus(new FocusNode());
                        Dialogs.dismiss(context);
                        Future.delayed(Duration(seconds: 1)).then((value) {
                          // setNama(data.data.namaLengkap);
                          // setUsername(data.data.username);
                          // setKdUser(data.data.nopol);
                          Navigator.push(
                              context,
                              PageTransition(
                                  type: PageTransitionType.rightToLeft,
                                  duration: Duration(milliseconds: 200),
                                  child: OtpPage(email: _username.text,)));
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
                  }else{
                    Toast.show("Konfirmasi password harus sama!", context,
                        duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
                  }
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
