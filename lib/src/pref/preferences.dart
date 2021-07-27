import 'package:shared_preferences/shared_preferences.dart';

Future setToken(String value) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.setString("token", value);
}
Future getToken() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  return prefs.getString("token");
}
Future rmvToken() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  return prefs.remove("token");
}

Future setKdUser(String value) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.setString("kduser", value);
}
Future getKdUser() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  return prefs.getString("kduser");
}
Future rmvKdUser() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  return prefs.remove("kduser");
}

Future setNama(String value) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.setString("nama", value);
}
Future getNama() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  return prefs.getString("nama");
}
Future rmvNama() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  return prefs.remove("nama");
}

Future setUsername(String value) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.setString("username", value);
}
Future getUsername() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  return prefs.getString("username");
}
Future rmvUsername() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  return prefs.remove("username");
}

Future setTelp(String value) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.setString("telp", value);
}
Future getTelp() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  return prefs.getString("telp");
}
Future rmvTelp() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  return prefs.remove("telp");
}

Future setKota(String value) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.setString("kota", value);
}
Future getKota() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  return prefs.getString("kota");
}
Future rmvKota() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  return prefs.remove("kota");
}

Future setTipe(String value) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.setString("tipe", value);
}
Future getTipe() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  return prefs.getString("tipe");
}
Future rmvTipe() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  return prefs.remove("tipe");
}

Future setAlamat(String value) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.setString("alamat", value);
}
Future getAlamat() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  return prefs.getString("alamat");
}
Future rmvAlamat() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  return prefs.remove("alamat");
}