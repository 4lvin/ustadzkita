// To parse this JSON data, do
//
//     final getListKategoriModel = getListKategoriModelFromJson(jsonString);

import 'dart:convert';

class GetListKategoriModel {
  GetListKategoriModel({
    this.hasil,
    this.data,
    this.message,
  });

  bool hasil;
  List<Datum> data;
  String message;

  factory GetListKategoriModel.fromRawJson(String str) => GetListKategoriModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GetListKategoriModel.fromJson(Map<String, dynamic> json) => GetListKategoriModel(
    hasil: json["hasil"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "hasil": hasil,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "message": message,
  };
}

class Datum {
  Datum({
    this.nama,
    this.image,
    this.kode,
    this.jumlah,
  });

  String nama;
  String image;
  String kode;
  int jumlah;

  factory Datum.fromRawJson(String str) => Datum.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    nama: json["nama"],
    image: json["image"],
    kode: json["kode"],
    jumlah: json["jumlah"],
  );

  Map<String, dynamic> toJson() => {
    "nama": nama,
    "image": image,
    "kode": kode,
    "jumlah": jumlah,
  };
}
