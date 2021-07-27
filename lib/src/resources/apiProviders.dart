import 'dart:async';
import 'dart:math';
import 'package:daikita/src/models/getBannerAtasModel.dart';
import 'package:daikita/src/models/getBannerQuotesModel.dart';
import 'package:daikita/src/models/getBannerTengahModel.dart';
import 'package:daikita/src/models/getChatListDetailModel.dart';
import 'package:daikita/src/models/getChatListModel.dart';
import 'package:daikita/src/models/getCheckChatDetailModel.dart';
import 'package:daikita/src/models/getDetailDoaModel.dart';
import 'package:daikita/src/models/getDetailUndanganModel.dart';
import 'package:daikita/src/models/getDetailUstadzModel.dart';
import 'package:daikita/src/models/getJadwalSholatModel.dart';
import 'package:daikita/src/models/getJadwalUstadzModel.dart';
import 'package:daikita/src/models/getKecamatanModel.dart';
import 'package:daikita/src/models/getKotaModel.dart';
import 'package:daikita/src/models/getListDoaModel.dart';
import 'package:daikita/src/models/getListKategoriModel.dart';
import 'package:daikita/src/models/getListMarkArtikelModel.dart';
import 'package:daikita/src/models/getListUndanganModel.dart';
import 'package:daikita/src/models/getListUstadzModel.dart';
import 'package:daikita/src/models/getLoginModel.dart';
import 'package:daikita/src/models/getMasterKajianModel.dart';
import 'package:daikita/src/models/getProvinsiModel.dart';
import 'package:daikita/src/models/getUndanganModel.dart';
import 'package:daikita/src/models/jadwalSholatTerdekatModel.dart';
import 'package:daikita/src/models/resKonfirmOtpModel.dart';
import 'package:daikita/src/models/resLoginGmailModel.dart';
import 'package:daikita/src/models/resLupaPasswordModel.dart';
import 'package:daikita/src/models/resMarkArtikelModel.dart';
import 'package:daikita/src/models/resRegisterGuestModel.dart';
import 'package:daikita/src/models/resUstadzKonfirmModel.dart';
import 'package:daikita/src/models/sendChatModel.dart';
import 'package:http/http.dart' as client;
import 'dart:convert';
import 'dart:io';

class ApiProviders {
  String url = "https://api.banghasan.com/sholat/format/json";
  String url2 = "http://185.201.9.208";

  // String url = "https://jongjava.tech/tumbas/restapi";

  Future getJadwalSholat(int kota, String tgl) async {
    try {
      final jadwal = await client.get("$url/jadwal/kota/$kota/tanggal/$tgl",
          headers: {"Content-Type": "application/json"}).timeout(const Duration(seconds: 11));
      if (jadwal.statusCode == 200) {
        return GetJadwalSholatModel.fromJson(json.decode(jadwal.body));
      } else {
        throw Exception('Failed to load Jadwal');
      }
    } on SocketException catch (e) {
      throw Exception(e.toString());
    } on HttpException {
      {
        throw Exception("tidak menemukan post");
      }
    } on FormatException {
      throw Exception("request salah");
    } on TimeoutException catch (e) {
      throw Exception(e.toString());
    }
  }

  Future login(String username, String password) async {
    try {
      var body = jsonEncode({'Username': username, 'Password': password});
      final login = await client.post("$url2/v1/user/login",
          body: body, headers: {"Content-Type": "application/json"}).timeout(const Duration(seconds: 11));
      print(login.body);
      if (login.statusCode == 200) {
        return GetLoginModel.fromJson(json.decode(login.body));
      } else {
        throw Exception('Failed to load Login');
      }
    } on SocketException catch (e) {
      throw Exception(e.toString());
    } on HttpException {
      {
        throw Exception("tidak menemukan post");
      }
    } on FormatException {
      throw Exception("request salah");
    } on TimeoutException catch (e) {
      throw Exception(e.toString());
    }
  }

  Future daftarGuest(String username, String password, String fullName, String noHp, String email, String provinsi, String kota,
      String kecamatan) async {
    try {
      var body = jsonEncode({
        'Username': username,
        'Password': password,
        'FullName': fullName,
        'NoHP': noHp,
        'Email': email,
        // 'Type': type,
        'Provinsi': provinsi,
        'Kota': kota,
        'Kecamatan': kecamatan
      });
      final login = await client.post("$url2/v1/user/register",
          body: body, headers: {"Content-Type": "application/json"}).timeout(const Duration(seconds: 11));
      if (login.statusCode == 200) {
        return ResRegisterGuestModel.fromJson(json.decode(login.body));
      } else {
        throw Exception('Failed to load Login');
      }
    } on SocketException catch (e) {
      throw Exception(e.toString());
    } on HttpException {
      {
        throw Exception("tidak menemukan post");
      }
    } on FormatException {
      throw Exception("request salah");
    } on TimeoutException catch (e) {
      throw Exception(e.toString());
    }
  }

  Future konfirmOtp(String username, String kode) async {
    try {
      var body = jsonEncode({'Username': username, 'kode': kode});
      final login = await client.put("$url2/v1/user/confirmotp",
          body: body, headers: {"Content-Type": "application/json"}).timeout(const Duration(seconds: 11));
      if (login.statusCode == 200) {
        return ResKonfirmOtpModel.fromJson(json.decode(login.body));
      } else {
        throw Exception('Failed to load Login');
      }
    } on SocketException catch (e) {
      throw Exception(e.toString());
    } on HttpException {
      {
        throw Exception("tidak menemukan post");
      }
    } on FormatException {
      throw Exception("request salah");
    } on TimeoutException catch (e) {
      throw Exception(e.toString());
    }
  }

  Future getProvinsi() async {
    try {
      final prov = await client.post("$url2/v1/provinsi/getactive",
          headers: {"Content-Type": "application/json"}).timeout(const Duration(seconds: 11));
      print(prov.body);
      if (prov.statusCode == 200) {
        return GetProvinsiModel.fromJson(json.decode(prov.body));
      } else {
        throw Exception('Failed to load Login');
      }
    } on SocketException catch (e) {
      throw Exception(e.toString());
    } on HttpException {
      {
        throw Exception("tidak menemukan post");
      }
    } on FormatException {
      throw Exception("request salah");
    } on TimeoutException catch (e) {
      throw Exception(e.toString());
    }
  }

  Future getKota(String kodeProv) async {
    try {
      var body = jsonEncode({'Provinsi': kodeProv});
      final data = await client.post("$url2/v1/kota/activebyprov",
          body: body, headers: {"Content-Type": "application/json"}).timeout(const Duration(seconds: 11));
      print(body);
      if (data.statusCode == 200) {
        return GetKotaModel.fromJson(json.decode(data.body));
      } else {
        throw Exception('Failed to load Login');
      }
    } on SocketException catch (e) {
      throw Exception(e.toString());
    } on HttpException {
      {
        throw Exception("tidak menemukan post");
      }
    } on FormatException {
      throw Exception("request salah");
    } on TimeoutException catch (e) {
      throw Exception(e.toString());
    }
  }

  Future getKecamatan(String kodeProv, String kodeKota) async {
    try {
      var body = jsonEncode({'Provinsi': kodeProv, 'Kota': kodeKota});
      final data = await client.post("$url2/v1/kecamatan/activebykota",
          body: body, headers: {"Content-Type": "application/json"}).timeout(const Duration(seconds: 11));
      print(body);
      if (data.statusCode == 200) {
        return GetKecamatanModel.fromJson(json.decode(data.body));
      } else {
        throw Exception('Failed to load Login');
      }
    } on SocketException catch (e) {
      throw Exception(e.toString());
    } on HttpException {
      {
        throw Exception("tidak menemukan post");
      }
    } on FormatException {
      throw Exception("request salah");
    } on TimeoutException catch (e) {
      throw Exception(e.toString());
    }
  }

  Future getListUstadz(String kota, String token) async {
    try {
      var body = jsonEncode({'Kode': kota});
      final data = await client.post("$url2/v1/ustadz/ListUstadzByKota",
          body: body, headers: {"Content-Type": "application/json", "Authorization": token}).timeout(const Duration(seconds: 11));
      print(data.body);
      if (data.statusCode == 200) {
        return GetListUstadzModel.fromJson(json.decode(data.body));
      } else {
        throw Exception('Failed to load Login');
      }
    } on SocketException catch (e) {
      throw Exception(e.toString());
    } on HttpException {
      {
        throw Exception("tidak menemukan post");
      }
    } on FormatException {
      throw Exception("request salah");
    } on TimeoutException catch (e) {
      throw Exception(e.toString());
    }
  }

  Future undangan(String ustadz, String tgl, String awal, String akhir, String jenisKajian, String provinsi, String kota,
      String kecamatan, String tema, String jmlhPeserta, String alamat, String akomodasi, String token) async {
    try {
      var body = jsonEncode({
        'ustadz': ustadz,
        'Tanggal': tgl,
        'awal': awal,
        'akhir': akhir,
        'JenisKajian': jenisKajian,
        'Provinsi': provinsi,
        'Kota': kota,
        'Kecamatan': kecamatan,
        'Tema': tema,
        'jmlhPeserta': jmlhPeserta,
        'Alamat': alamat,
        'Akomodasi': akomodasi
      });
      final data = await client.post("$url2/v1/undangan",
          body: body, headers: {"Content-Type": "application/json", "Authorization": token}).timeout(const Duration(seconds: 11));
      print(data.body);
      if (data.statusCode == 200) {
        return GetUndanganModel.fromJson(json.decode(data.body));
      } else {
        throw Exception('Failed to load Login');
      }
    } on SocketException catch (e) {
      throw Exception(e.toString());
    } on HttpException {
      {
        throw Exception("tidak menemukan post");
      }
    } on FormatException {
      throw Exception("request salah");
    } on TimeoutException catch (e) {
      throw Exception(e.toString());
    }
  }

  Future masterKajian(String token) async {
    try {
      // var body = jsonEncode({'Kode': kota});
      final data = await client.post("$url2/v1/kajian/listactive",
          headers: {"Content-Type": "application/json", "Authorization": token}).timeout(const Duration(seconds: 11));
      if (data.statusCode == 200) {
        return GetMasterKajianModel.fromJson(json.decode(data.body));
      } else {
        throw Exception('Failed to load Login');
      }
    } on SocketException catch (e) {
      throw Exception(e.toString());
    } on HttpException {
      {
        throw Exception("tidak menemukan post");
      }
    } on FormatException {
      throw Exception("request salah");
    } on TimeoutException catch (e) {
      throw Exception(e.toString());
    }
  }

  Future listUndangan(String token, String status) async {
    try {
      var body = jsonEncode({'status': status});
      final data = await client.post("$url2/v1/undangan/list",
          body: body, headers: {"Content-Type": "application/json", "Authorization": token}).timeout(const Duration(seconds: 11));
      if (data.statusCode == 200) {
        print(data.body);
        return GetListUndanganModel.fromJson(json.decode(data.body));
      } else {
        throw Exception('Failed to load Login');
      }
    } on SocketException catch (e) {
      throw Exception(e.toString());
    } on HttpException {
      {
        throw Exception("tidak menemukan post");
      }
    } on FormatException {
      throw Exception("request salah");
    } on TimeoutException catch (e) {
      throw Exception(e.toString());
    }
  }

  Future detailUndangan(String kode, String token) async {
    try {
      var body = jsonEncode({'KodeUdangan': kode});
      final data = await client.post("$url2/v1/undangan/track",
          body: body, headers: {"Content-Type": "application/json", "Authorization": token}).timeout(const Duration(seconds: 11));
      if (data.statusCode == 200) {
        return GetDetailUndanganModel.fromJson(json.decode(data.body));
      } else {
        throw Exception('Failed to load Login');
      }
    } on SocketException catch (e) {
      throw Exception(e.toString());
    } on HttpException {
      {
        throw Exception("tidak menemukan post");
      }
    } on FormatException {
      throw Exception("request salah");
    } on TimeoutException catch (e) {
      throw Exception(e.toString());
    }
  }

  Future jadwalUstadz(String token) async {
    try {
      // var body = jsonEncode({'KodeUdangan': kode});
      final data = await client.post("$url2/v1/undangan/jadwalsaya",
          headers: {"Content-Type": "application/json", "Authorization": token}).timeout(const Duration(seconds: 11));
      if (data.statusCode == 200) {
        print(data.body);
        return GetJadwalUstadzModel.fromJson(json.decode(data.body));
      } else {
        throw Exception('Failed to load Login');
      }
    } on SocketException catch (e) {
      throw Exception(e.toString());
    } on HttpException {
      {
        throw Exception("tidak menemukan post");
      }
    } on FormatException {
      throw Exception("request salah");
    } on TimeoutException catch (e) {
      throw Exception(e.toString());
    }
  }

  Future ustadzKonfirmUndangan(String kode, String status, String token) async {
    try {
      var body = jsonEncode({'KodeUdangan': kode, 'Status': status});
      final data = await client.put("$url2/v1/undangan/status",
          body: body, headers: {"Content-Type": "application/json", "Authorization": token}).timeout(const Duration(seconds: 11));
      if (data.statusCode == 200) {
        return ResUstadzKonfirmModel.fromJson(json.decode(data.body));
      } else {
        throw Exception('Failed to load Login');
      }
    } on SocketException catch (e) {
      throw Exception(e.toString());
    } on HttpException {
      {
        throw Exception("tidak menemukan post");
      }
    } on FormatException {
      throw Exception("request salah");
    } on TimeoutException catch (e) {
      throw Exception(e.toString());
    }
  }

  Future jadwalSholatTerdekat(String jam, String kode, String tgl) async {
    try {
      var body = jsonEncode({'Jam': jam, 'kode': kode, 'tanggal': tgl});
      final data = await client.post("$url2/v1/umum/jadwalSholat",
          body: body, headers: {"Content-Type": "application/json"}).timeout(const Duration(seconds: 11));
      print(data.body);
      if (data.statusCode == 200) {
        return JadwalSholatTerdekatModel.fromJson(json.decode(data.body));
      } else {
        throw Exception('Failed to load Login');
      }
    } on SocketException catch (e) {
      throw Exception(e.toString());
    } on HttpException {
      {
        throw Exception("tidak menemukan post");
      }
    } on FormatException {
      throw Exception("request salah");
    } on TimeoutException catch (e) {
      throw Exception(e.toString());
    }
  }

  Future loginGmail(String email, String name) async {
    try {
      var body = jsonEncode({"email": email, "fullName": name});
      final data = await client.post("$url2/v1/user/loginGmail",
          body: body, headers: {"Content-Type": "application/json"}).timeout(const Duration(seconds: 11));
      print(data.body);
      if (data.statusCode == 200) {
        return ResLoginGmailModel.fromJson(json.decode(data.body));
      } else {
        throw Exception('Failed to load Login');
      }
    } on SocketException catch (e) {
      throw Exception(e.toString());
    } on HttpException {
      {
        throw Exception("tidak menemukan post");
      }
    } on FormatException {
      throw Exception("request salah");
    } on TimeoutException catch (e) {
      throw Exception(e.toString());
    }
  }

  Future afterLoginGmail(String email, String provinsi, String kota, String kecamatan) async {
    try {
      var body = jsonEncode({"email": email, "provinsi": provinsi, "kota": kota, "kecamatan": kecamatan});
      final data = await client.put("$url2/v1/user/step2",
          body: body, headers: {"Content-Type": "application/json"}).timeout(const Duration(seconds: 11));
      print(body);
      print(data.body);
      if (data.statusCode == 200) {
        return GetLoginModel.fromJson(json.decode(data.body));
      } else {
        throw Exception('Failed to load Login');
      }
    } on SocketException catch (e) {
      throw Exception(e.toString());
    } on HttpException {
      {
        throw Exception("tidak menemukan post");
      }
    } on FormatException {
      throw Exception("request salah");
    } on TimeoutException catch (e) {
      throw Exception(e.toString());
    }
  }

  Future chatList(String token) async {
    try {
      // var body = jsonEncode({'KodeUdangan': kode});
      final data = await client.post("$url2/v1/chat/list",
          headers: {"Content-Type": "application/json", "Authorization": token}).timeout(const Duration(seconds: 11));
      if (data.statusCode == 200) {
        print(data.body);
        return GetChatListModel.fromJson(json.decode(data.body));
      } else {
        throw Exception('Failed to load Login');
      }
    } on SocketException catch (e) {
      throw Exception(e.toString());
    } on HttpException {
      {
        throw Exception("tidak menemukan post");
      }
    } on FormatException {
      throw Exception("request salah");
    } on TimeoutException catch (e) {
      throw Exception(e.toString());
    }
  }

  Future checkChatDetail(String token, String email) async {
    try {
      var body = jsonEncode({'emailke': email});
      final data = await client.post("$url2/v1/chat/checkawal",
          body: body, headers: {"Content-Type": "application/json", "Authorization": token}).timeout(const Duration(seconds: 11));
      if (data.statusCode == 200) {
        print("cek");
        print(body);
        print(token);
        print(data.body);
        return GetCheckChatDetailModel.fromJson(json.decode(data.body));
      } else {
        throw Exception('Failed to load Login');
      }
    } on SocketException catch (e) {
      throw Exception(e.toString());
    } on HttpException {
      {
        throw Exception("tidak menemukan post");
      }
    } on FormatException {
      throw Exception("request salah");
    } on TimeoutException catch (e) {
      throw Exception(e.toString());
    }
  }

  Future chatListDetail(String token, String email, String topik) async {
    try {
      var body = jsonEncode({'emailke': email, 'topik': topik});
      final data = await client.post("$url2/v1/chat/detail",
          body: body, headers: {"Content-Type": "application/json", "Authorization": token}).timeout(const Duration(seconds: 11));
      if (data.statusCode == 200) {
        print("detail");
        print(data.body);
        print(body);
        return GetChatListDetailModel.fromJson(json.decode(data.body));
      } else {
        throw Exception('Failed to load Login');
      }
    } on SocketException catch (e) {
      throw Exception(e.toString());
    } on HttpException {
      {
        throw Exception("tidak menemukan post");
      }
    } on FormatException {
      throw Exception("request salah");
    } on TimeoutException catch (e) {
      throw Exception(e.toString());
    }
  }

  Future sendChat(String token, String email, String pesan) async {
    try {
      var body = jsonEncode({'emailke': email, 'isi': pesan});
      final data = await client.post("$url2/v1/chat",
          body: body, headers: {"Content-Type": "application/json", "Authorization": token}).timeout(const Duration(seconds: 11));
      if (data.statusCode == 200) {
        print(data.body);
        return SendChatModel.fromJson(json.decode(data.body));
      } else {
        throw Exception('Failed to load Login');
      }
    } on SocketException catch (e) {
      throw Exception(e.toString());
    } on HttpException {
      {
        throw Exception("tidak menemukan post");
      }
    } on FormatException {
      throw Exception("request salah");
    } on TimeoutException catch (e) {
      throw Exception(e.toString());
    }
  }

  Future listKategori(String kategori) async {
    try {
      var body = jsonEncode({'kategori': kategori});
      final data = await client.post("$url2/v1/masterlabel/activebykategori",
          body: body, headers: {"Content-Type": "application/json"}).timeout(const Duration(seconds: 11));
      if (data.statusCode == 200) {
        return GetListKategoriModel.fromJson(json.decode(data.body));
      } else {
        throw Exception('Failed to load Login');
      }
    } on SocketException catch (e) {
      throw Exception(e.toString());
    } on HttpException {
      {
        throw Exception("tidak menemukan post");
      }
    } on FormatException {
      throw Exception("request salah");
    } on TimeoutException catch (e) {
      throw Exception(e.toString());
    }
  }

  Future listDoa(String label) async {
    try {
      var body = jsonEncode({'label': label});
      final data = await client.post("$url2/v1/artikel/listbylabel",
          body: body, headers: {"Content-Type": "application/json"}).timeout(const Duration(seconds: 11));
      if (data.statusCode == 200) {
        return GetListDoaModel.fromJson(json.decode(data.body));
      } else {
        throw Exception('Failed to load Login');
      }
    } on SocketException catch (e) {
      throw Exception(e.toString());
    } on HttpException {
      {
        throw Exception("tidak menemukan post");
      }
    } on FormatException {
      throw Exception("request salah");
    } on TimeoutException catch (e) {
      throw Exception(e.toString());
    }
  }

  Future detailDoa(String token, String artikel) async {
    try {
      var body = jsonEncode({'artikel': artikel});
      final data = await client.post("$url2/v1/artikel/detail",
          body: body, headers: {"Content-Type": "application/json", "Authorization": token}).timeout(const Duration(seconds: 11));
      if (data.statusCode == 200) {
        print(data.body);
        return GetDetailDoaModel.fromJson(json.decode(data.body));
      } else {
        throw Exception('Failed to load Login');
      }
    } on SocketException catch (e) {
      throw Exception(e.toString());
    } on HttpException {
      {
        throw Exception("tidak menemukan post");
      }
    } on FormatException {
      throw Exception("request salah");
    } on TimeoutException catch (e) {
      throw Exception(e.toString());
    }
  }

  Future lupaPassword(String noHp) async {
    try {
      var body = jsonEncode({'NoHP': noHp});
      final data = await client.post("$url2/v1/user/forgetpassword",
          body: body, headers: {"Content-Type": "application/json"}).timeout(const Duration(seconds: 11));
      if (data.statusCode == 200) {
        return ResLupaPasswordModel.fromJson(json.decode(data.body));
      } else {
        throw Exception('Failed to load Login');
      }
    } on SocketException catch (e) {
      throw Exception(e.toString());
    } on HttpException {
      {
        throw Exception("tidak menemukan post");
      }
    } on FormatException {
      throw Exception("request salah");
    } on TimeoutException catch (e) {
      throw Exception(e.toString());
    }
  }

  Future markArtikel(String token, String artikel) async {
    try {
      var body = jsonEncode({'artikel': artikel});
      final data = await client.post("$url2/v1/markartikel",
          body: body, headers: {"Content-Type": "application/json", "Authorization": token}).timeout(const Duration(seconds: 11));
      if (data.statusCode == 200) {
        return ResMarkArtikelModel.fromJson(json.decode(data.body));
      } else {
        throw Exception('Failed to load Login');
      }
    } on SocketException catch (e) {
      throw Exception(e.toString());
    } on HttpException {
      {
        throw Exception("tidak menemukan post");
      }
    } on FormatException {
      throw Exception("request salah");
    } on TimeoutException catch (e) {
      throw Exception(e.toString());
    }
  }

  Future listMarkArtikel(String token, String label) async {
    try {
      var body = jsonEncode({'label': label});
      final data = await client.post("$url2/v1/markartikel/list",
          body: body, headers: {"Content-Type": "application/json", "Authorization": token}).timeout(const Duration(seconds: 11));
      if (data.statusCode == 200) {
        print(data.body);
        return GetListMarkArtikelModel.fromJson(json.decode(data.body));
      } else {
        throw Exception('Failed to load Login');
      }
    } on SocketException catch (e) {
      throw Exception(e.toString());
    } on HttpException {
      {
        throw Exception("tidak menemukan post");
      }
    } on FormatException {
      throw Exception("request salah");
    } on TimeoutException catch (e) {
      throw Exception(e.toString());
    }
  }

  Future profilUstadz(String noHp) async {
    try {
      var body = jsonEncode({'NoHP': noHp});
      final data = await client.post("$url2/v1/ustadz/detail",
          body: body, headers: {"Content-Type": "application/json"}).timeout(const Duration(seconds: 11));
      if (data.statusCode == 200) {
        return GetDetailUstadzModel.fromJson(json.decode(data.body));
      } else {
        throw Exception('Failed to load Login');
      }
    } on SocketException catch (e) {
      throw Exception(e.toString());
    } on HttpException {
      {
        throw Exception("tidak menemukan post");
      }
    } on FormatException {
      throw Exception("request salah");
    } on TimeoutException catch (e) {
      throw Exception(e.toString());
    }
  }

  Future bannerQuotes() async {
    try {
      final prov = await client
          .get("$url2/v1/banner/quote", headers: {"Content-Type": "application/json"}).timeout(const Duration(seconds: 11));
      if (prov.statusCode == 200) {
        return GetBannerQuoteModel.fromJson(json.decode(prov.body));
      } else {
        throw Exception('Failed to load Login');
      }
    } on SocketException catch (e) {
      throw Exception(e.toString());
    } on HttpException {
      {
        throw Exception("tidak menemukan post");
      }
    } on FormatException {
      throw Exception("request salah");
    } on TimeoutException catch (e) {
      throw Exception(e.toString());
    }
  }

  Future bannerTengah() async {
    try {
      final prov = await client
          .get("$url2/v1/banner/tengah", headers: {"Content-Type": "application/json"}).timeout(const Duration(seconds: 11));
      if (prov.statusCode == 200) {
        return GetBannerTengahModel.fromJson(json.decode(prov.body));
      } else {
        throw Exception('Failed to load Login');
      }
    } on SocketException catch (e) {
      throw Exception(e.toString());
    } on HttpException {
      {
        throw Exception("tidak menemukan post");
      }
    } on FormatException {
      throw Exception("request salah");
    } on TimeoutException catch (e) {
      throw Exception(e.toString());
    }
  }

  Future bannerAtas() async {
    try {
      final prov = await client
          .get("$url2/v1/banner/atas", headers: {"Content-Type": "application/json"}).timeout(const Duration(seconds: 11));
      if (prov.statusCode == 200) {
        return GetBannerAtasModel.fromJson(json.decode(prov.body));
      } else {
        throw Exception('Failed to load Login');
      }
    } on SocketException catch (e) {
      throw Exception(e.toString());
    } on HttpException {
      {
        throw Exception("tidak menemukan post");
      }
    } on FormatException {
      throw Exception("request salah");
    } on TimeoutException catch (e) {
      throw Exception(e.toString());
    }
  }
}
