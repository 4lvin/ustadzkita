// To parse this JSON data, do
//
//     final getDetailUstadzModel = getDetailUstadzModelFromJson(jsonString);

import 'dart:convert';

class GetDetailUstadzModel {
  GetDetailUstadzModel({
    this.hasil,
    this.result,
  });

  bool hasil;
  ResultUstadz result;

  factory GetDetailUstadzModel.fromRawJson(String str) => GetDetailUstadzModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GetDetailUstadzModel.fromJson(Map<String, dynamic> json) => GetDetailUstadzModel(
    hasil: json["hasil"],
    result: ResultUstadz.fromJson(json["result"]),
  );

  Map<String, dynamic> toJson() => {
    "hasil": hasil,
    "result": result.toJson(),
  };
}

class ResultUstadz {
  ResultUstadz({
    this.nama,
    this.pendidikan,
    this.pekerjaan,
    this.organisasi,
    this.profile,
    this.ulasan,
    this.artikel,
  });

  String nama;
  List<String> pendidikan;
  List<String> pekerjaan;
  List<String> organisasi;
  String profile;
  List<UlasanModel> ulasan;
  List<ArtikelModel> artikel;

  factory ResultUstadz.fromRawJson(String str) => ResultUstadz.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ResultUstadz.fromJson(Map<String, dynamic> json) => ResultUstadz(
    nama: json["nama"],
    pendidikan: List<String>.from(json["pendidikan"].map((x) => x)),
    pekerjaan: List<String>.from(json["pekerjaan"].map((x) => x)),
    organisasi: List<String>.from(json["organisasi"].map((x) => x)),
    profile: json["profile"],
    ulasan: List<UlasanModel>.from(json["ulasan"].map((x) => UlasanModel.fromJson(x))),
    artikel: List<ArtikelModel>.from(json["artikel"].map((x) => ArtikelModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "nama": nama,
    "pendidikan": List<dynamic>.from(pendidikan.map((x) => x)),
    "pekerjaan": List<dynamic>.from(pekerjaan.map((x) => x)),
    "organisasi": List<dynamic>.from(organisasi.map((x) => x)),
    "profile": profile,
    "ulasan": List<dynamic>.from(ulasan.map((x) => x.toJson())),
    "artikel": List<dynamic>.from(artikel.map((x) => x.toJson())),
  };
}

class ArtikelModel {
  ArtikelModel({
    this.judul,
    this.isi,
    this.tanggal,
  });

  String judul;
  String isi;
  DateTime tanggal;

  factory ArtikelModel.fromRawJson(String str) => ArtikelModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ArtikelModel.fromJson(Map<String, dynamic> json) => ArtikelModel(
    judul: json["judul"],
    isi: json["isi"],
    tanggal: DateTime.parse(json["tanggal"]),
  );

  Map<String, dynamic> toJson() => {
    "judul": judul,
    "isi": isi,
    "tanggal": tanggal.toIso8601String(),
  };
}

class UlasanModel {
  UlasanModel({
    this.nama,
    this.komen,
    this.rating,
  });

  String nama;
  String komen;
  String rating;

  factory UlasanModel.fromRawJson(String str) => UlasanModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UlasanModel.fromJson(Map<String, dynamic> json) => UlasanModel(
    nama: json["nama"],
    komen: json["komen"],
    rating: json["rating"],
  );

  Map<String, dynamic> toJson() => {
    "nama": nama,
    "komen": komen,
    "rating": rating,
  };
}
