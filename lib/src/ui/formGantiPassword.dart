import 'package:daikita/src/blocs/memberBloc.dart';
import 'package:daikita/src/pref/preferences.dart';
import 'package:daikita/src/ui/utils/colorses.dart';
import 'package:daikita/src/ui/utils/loading.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

class GantiPassword extends StatefulWidget {

  @override
  _GantiPasswordState createState() => _GantiPasswordState();
}

class _GantiPasswordState extends State<GantiPassword> {
  TextEditingController _password = TextEditingController();
  TextEditingController _passwordLama = TextEditingController();
  TextEditingController _konfPassword = TextEditingController();
  bool passwordVisible = true;
  bool passwordLamaVisible = true;
  bool konfPasswordVisible = true;
  bool _validate = false;
  String token;

  @override
  void initState() {
    getToken().then((value){
      if(mounted)
        setState(() {
          token = value;
        });
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ganti Password"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 18,),
            Container(
              width: MediaQuery.of(context).size.width * 0.8,
              child: Text("Password minimal 8 karakter dan hanya bisa huruf dan angka",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
            ),
            SizedBox(height: 18,),
            Container(
              margin: EdgeInsets.symmetric(vertical: 5,horizontal: 30),
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 1),
              width: MediaQuery.of(context).size.width * 0.8,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(8),
              ),
              child: TextField(
                obscureText: passwordLamaVisible,
                controller: _passwordLama,
                cursorColor: colorses.hijaudasar,
                decoration: InputDecoration(
                  hintText: "Password Lama",
                  suffixIcon: IconButton(
                    icon: Icon(
                      passwordLamaVisible ? Icons.visibility_off : Icons.visibility,
                    ),
                    color: colorses.hijaudasar,
                    onPressed: () {
                      this.setState(() {
                        passwordLamaVisible = !passwordLamaVisible;
                      });
                    },
                  ),
                  errorText: _password.text.length < 3 && _validate ? 'Password Lama harus diisi !' : null,
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
            InkWell(
              onTap: (){
                if(_passwordLama.text.isEmpty || _password.text.isEmpty || _konfPassword.text.isEmpty){
                  setState(() {
                    _validate= true;
                  });
                }else{
                  if(_password.text == _konfPassword.text){
                    Dialogs.showLoading(context,"Loading");
                    memberBloc.updatePassword(_passwordLama.text, _password.text,token);
                        memberBloc.resUpdatePass.listen((respon) {
                          if(respon.hasil){
                            FocusScope.of(context).requestFocus(new FocusNode());
                            Dialogs.dismiss(context);
                            Future.delayed(Duration(seconds: 1)).then((value) {
                              Toast.show("Password berhasil di rubah!", context,
                                  duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
                              Navigator.pushReplacementNamed(context, '/controllerPage');
                            });
                          }else{
                            Dialogs.dismiss(context);
                            Future.delayed(Duration(seconds: 1)).then((value) {
                              Dialogs.dismiss(context);
                              FocusScope.of(context).requestFocus(new FocusNode());
                              Toast.show("${respon.message}", context,
                                  duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
                            });
                          }
                        }).onError((error, stackTrace){
                      Dialogs.dismiss(context);
                      Future.delayed(Duration(seconds: 1)).then((value) {
                        Dialogs.dismiss(context);
                        FocusScope.of(context).requestFocus(new FocusNode());
                        Toast.show(error.toString(), context,
                            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
                      });
                    });
                  }else{
                    Toast.show("Konfirmasi password baru harus sama!", context,
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
                child: Center(child: Text("Ubah",style: TextStyle(color: Colors.white),)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
