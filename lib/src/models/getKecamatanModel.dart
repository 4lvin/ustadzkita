// To parse this JSON data, do
//
//     final getKecamatanModel = getKecamatanModelFromJson(jsonString);

import 'dart:convert';

class GetKecamatanModel {
  GetKecamatanModel({
    this.hasil,
    this.result,
  });

  bool hasil;
  List<ResultKecamatan> result;

  factory GetKecamatanModel.fromRawJson(String str) => GetKecamatanModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GetKecamatanModel.fromJson(Map<String, dynamic> json) => GetKecamatanModel(
    hasil: json["hasil"],
    result: List<ResultKecamatan>.from(json["result"].map((x) => ResultKecamatan.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "hasil": hasil,
    "result": List<dynamic>.from(result.map((x) => x.toJson())),
  };
}

class ResultKecamatan {
  ResultKecamatan({
    this.id,
    this.provinsi,
    this.kota,
    this.kecamatan,
    this.kode,
    this.active,
    this.createdAt,
    this.createdBy,
    this.v,
  });

  String id;
  String provinsi;
  String kota;
  String kecamatan;
  String kode;
  bool active;
  DateTime createdAt;
  String createdBy;
  int v;

  factory ResultKecamatan.fromRawJson(String str) => ResultKecamatan.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ResultKecamatan.fromJson(Map<String, dynamic> json) => ResultKecamatan(
    id: json["_id"],
    provinsi: json["Provinsi"],
    kota: json["Kota"],
    kecamatan: json["Kecamatan"],
    kode: json["Kode"],
    active: json["Active"],
    createdAt: DateTime.parse(json["CreatedAt"]),
    createdBy: json["CreatedBy"],
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "Provinsi": provinsi,
    "Kota": kota,
    "Kecamatan": kecamatan,
    "Kode": kode,
    "Active": active,
    "CreatedAt": createdAt.toIso8601String(),
    "CreatedBy": createdBy,
    "__v": v,
  };
}
