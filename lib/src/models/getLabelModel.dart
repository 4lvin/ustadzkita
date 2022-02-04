// To parse this JSON data, do
//
//     final getLabelModel = getLabelModelFromJson(jsonString);

import 'dart:convert';

class GetLabelModel {
  GetLabelModel({
    this.hasil,
    this.data,
    this.message,
  });

  bool hasil;
  List<Datum> data;
  String message;

  factory GetLabelModel.fromRawJson(String str) => GetLabelModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GetLabelModel.fromJson(Map<String, dynamic> json) => GetLabelModel(
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
    this.kode,
    this.jumlah,
  });

  String nama;
  String kode;
  int jumlah;

  factory Datum.fromRawJson(String str) => Datum.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    nama: json["nama"],
    kode: json["kode"],
    jumlah: json["jumlah"],
  );

  Map<String, dynamic> toJson() => {
    "nama": nama,
    "kode": kode,
    "jumlah": jumlah,
  };
}
