import 'package:daikita/src/blocs/memberBloc.dart';
import 'package:daikita/src/ui/utils/colorses.dart';
import 'package:daikita/src/ui/utils/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:toast/toast.dart';


class LupaPassword extends StatefulWidget {
  @override
  _LupaPasswordState createState() => _LupaPasswordState();
}

class _LupaPasswordState extends State<LupaPassword> {
  var _email = TextEditingController();
  bool _validate = false;
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
                            "Lupa Password",
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
            child: Text("Lupa Password?",style: TextStyle(fontSize: 31,fontWeight: FontWeight.bold),),
          ),
          Container(
            margin: EdgeInsets.only(top: 12,left: 30),
            width: MediaQuery.of(context).size.width/2 + 50,
            child: Text("Masukkan email yang terhubung dengan akun Anda",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
          ),
          Container(
            margin: EdgeInsets.only(top: 12,left: 30),
            width: MediaQuery.of(context).size.width/2 + 50,
            child: Text("Kami akan mengirimkan kode password ke email Anda \n Jika di Kotak Masuk tidak ada, silahkan cek email spam anda",style: TextStyle(fontSize: 14,color: Colors.grey),),
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
              controller: _email,
              cursorColor: colorses.hijaudasar,
              decoration: InputDecoration(
                hintText: "Email",
                border: InputBorder.none,
                errorText: _email.text.length < 3 && _validate ? 'Email harus diisi !' : null,
              ),
            ),
          ),

          SizedBox(height: 50,),
          InkWell(
            onTap: (){
              if(_email.text.isEmpty){
                setState(() {
                  _validate= true;
                });
              }else{
                // if(_password.text == _konfPassword.text){
                //   Dialogs.showLoading(context,"Loading");
                  memberBloc.lupaPassword(_email.text);
                  memberBloc.resLupaPassword.listen((data) {
                    if(data.hasil){
                      FocusScope.of(context).requestFocus(new FocusNode());
                      Dialogs.dismiss(context);
                      Future.delayed(Duration(seconds: 1)).then((value) {
                        // setNama(data.data.namaLengkap);
                        // setUsername(data.data.username);
                        // setKdUser(data.data.nopol);
                        Toast.show(data.message, context,
                            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
                        Navigator.pushReplacementNamed(context, "/login");
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
                // }else{
                //   Toast.show("Konfirmasi password harus sama!", context,
                //       duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
                // }
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
              child: Center(child: Text("Kirim",style: TextStyle(color: Colors.white),)),
            ),
          )
        ],
      ),
    );
  }
}
