import 'package:daikita/src/blocs/memberBloc.dart';
import 'package:daikita/src/pref/preferences.dart';
import 'package:daikita/src/ui/auth/auth.dart';
import 'package:daikita/src/ui/daftar.dart';
import 'package:daikita/src/ui/formAlamat.dart';
import 'package:daikita/src/ui/lupaPassword.dart';
import 'package:daikita/src/ui/utils/colorses.dart';
import 'package:daikita/src/ui/utils/loading.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:page_transition/page_transition.dart';
import 'package:toast/toast.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool passwordVisible = true;
  bool _validate = false;
  var _username = TextEditingController();
  var _password = TextEditingController();
  final GoogleSignIn googleSignIn = new GoogleSignIn();

  // FirebaseMessaging _firebaseMessaging = new FirebaseMessaging();

  Future _signIn() async {
    Dialogs.showLoading(context, "Loading...");
    GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    UserCredential signIn = await signIntoFirebase(googleSignInAccount).catchError((onError) {
      Dialogs.dismiss(context);
      Toast.show(onError.toString(), context, duration: 3, gravity: Toast.BOTTOM);
    });
    memberBloc.loginGmail(signIn.user.email, signIn.user.displayName);
    memberBloc.resLoginGmail.listen((login) {
      if (login.status == 1) {
        Dialogs.dismiss(context);
        Future.delayed(Duration(seconds: 1)).then((value) {
          setToken(login.data.token);
          setKota(login.data.kota.kode);
          setNama(login.data.fullname);
          setTipe(login.type);
          Navigator.pushReplacementNamed(context, '/controllerPage');
        });
      } else {
        Dialogs.dismiss(context);
        Future.delayed(Duration(seconds: 1)).then((value) {
          Navigator.of(context).pushReplacement(PageTransition(
              settings: const RouteSettings(name: '/formAlamat'),
              type: PageTransitionType.rightToLeft,
              duration: Duration(milliseconds: 400),
              child: FormAlamat(email: signIn.user.email,)));
        });
      }
    });
  }

  @override
  void initState() {
    Firebase.initializeApp().whenComplete(() {
      print("completed");
      setState(() {});
    });
    // _firebaseMessaging.getToken().then((token) {
    //   setState(() {
    //     // tokenUser = token;
    //   });
    //   print(token);
    // });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          //height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: Colors.white,
          child: Stack(
            children: <Widget>[
              Column(
                children: <Widget>[
                  SvgPicture.asset('assets/bg.svg',
                      color: Colors.grey[100],
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height / 3,
                      fit: BoxFit.cover),
                  SvgPicture.asset('assets/bg.svg',
                      color: Colors.grey[100],
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height / 3,
                      fit: BoxFit.cover),
                  SvgPicture.asset('assets/bg.svg',
                      color: Colors.grey[100],
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height / 3,
                      fit: BoxFit.cover),
                ],
              ),
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SafeArea(
                      child: Container(
                        height: 120,
                        margin: EdgeInsets.only(top: MediaQuery.of(context).size.height / 9, bottom: 8),
                        width: MediaQuery.of(context).size.width,
                        child: Image.asset("assets/responsive_logo.png"),
                      ),
                    ),
                    Text(
                      "Aplikasi konsultasi seputar keagamaan",
                      style: TextStyle(fontSize: 9),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 10),
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
                          hintText: "Email/Username",
                          border: InputBorder.none,
                          errorText: _username.text.length < 3 && _validate ? 'Username harus diisi !' : null,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 10),
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
                    SizedBox(
                      height: 12,
                    ),
                    InkWell(
                      onTap: () {
                        // Navigator.pushReplacementNamed(context, '/controllerPage');
                        if (_username.text.isEmpty || _password.text.isEmpty) {
                          setState(() {
                            _validate = true;
                          });
                        } else {
                          Dialogs.showLoading(context, "Loading");
                          memberBloc.login(_username.text, _password.text);
                          memberBloc.resLogin.listen((data) {
                            if (data.hasil) {
                              print(data);
                              Dialogs.dismiss(context);
                              Future.delayed(Duration(seconds: 1)).then((value) {
                                setToken(data.data.token);
                                setKota(data.data.kota);
                                setNama(data.data.fullname);
                                setTipe(data.type);
                                setTelp(data.data.noTelp);
                                setAlamat(data.data.namaKota);
                                // setUsername(data.data.username);
                                // setKdUser(data.data.nopol);
                                Navigator.pushReplacementNamed(context, '/controllerPage');
                              });
                            } else {
                              Dialogs.dismiss(context);
                              Future.delayed(Duration(seconds: 1)).then((value) {
                                Dialogs.dismiss(context);
                                FocusScope.of(context).requestFocus(new FocusNode());
                                Toast.show("User atau Password salah", context,
                                    duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
                              });
                            }
                          }).onError((e) {
                            Dialogs.dismiss(context);
                            Future.delayed(Duration(seconds: 1)).then((value) {
                              Dialogs.dismiss(context);
                              FocusScope.of(context).requestFocus(new FocusNode());
                              Toast.show(e, context, duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
                            });
                          });
                        }
                      },
                      child: Container(
                          margin: EdgeInsets.symmetric(vertical: 10),
                          height: 50,
                          width: MediaQuery.of(context).size.width * 0.8,
                          decoration: BoxDecoration(
                            color: colorses.hijaudasar,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Center(
                              child: Text(
                            "Login",
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ))),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    InkWell(
                        onTap: (){
                          Navigator.push(
                              context,
                              PageTransition(
                                  type: PageTransitionType.rightToLeft,
                                  duration: Duration(milliseconds: 200),
                                  child: LupaPassword()));
                        },
                        child: Text("Lupa Password?")),
                    SizedBox(
                      height: 12,
                    ),
                    Text(
                      "ATAU",
                      style: TextStyle(color: Colors.grey),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Container(
                        margin: EdgeInsets.symmetric(vertical: 10),
                        height: 50,
                        width: MediaQuery.of(context).size.width * 0.6,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                            child: InkWell(
                              onTap: (){
                                _signIn();
                              },
                              child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                              Container(
                                  height: 35,
                                  width: 35,
                                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
                                  child: Image.asset(
                                    'assets/google.png',
                                    scale: 8,
                                  )),
                              Text(
                                "Lanjutkan dengan Google",
                                style: TextStyle(color: Colors.black, fontSize: 14),
                              ),
                          ],
                        ),
                            ))),
                    SizedBox(
                      height: 12,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text("Belum punya akun? "),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                PageTransition(
                                    type: PageTransitionType.rightToLeft,
                                    duration: Duration(milliseconds: 200),
                                    child: Daftar()));
                          },
                          child: Text(
                            "DAFTAR",
                            style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Text("Versi 1.1"),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
