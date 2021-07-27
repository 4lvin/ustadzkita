// To parse this JSON data, do
//
//     final jadwalSholatTerdekatModel = jadwalSholatTerdekatModelFromJson(jsonString);

import 'dart:convert';

class JadwalSholatTerdekatModel {
  JadwalSholatTerdekatModel({
    this.hasil,
    this.result,
  });

  bool hasil;
  Result result;

  factory JadwalSholatTerdekatModel.fromRawJson(String str) => JadwalSholatTerdekatModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory JadwalSholatTerdekatModel.fromJson(Map<String, dynamic> json) => JadwalSholatTerdekatModel(
    hasil: json["hasil"],
    result: Result.fromJson(json["result"]),
  );

  Map<String, dynamic> toJson() => {
    "hasil": hasil,
    "result": result.toJson(),
  };
}

class Result {
  Result({
    this.waktu,
    this.sholat,
  });

  String waktu;
  String sholat;

  factory Result.fromRawJson(String str) => Result.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    waktu: json["waktu"],
    sholat: json["sholat"],
  );

  Map<String, dynamic> toJson() => {
    "waktu": waktu,
    "sholat": sholat,
  };
}
