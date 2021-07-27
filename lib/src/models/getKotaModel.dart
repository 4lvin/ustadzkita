// To parse this JSON data, do
//
//     final getKotaModel = getKotaModelFromJson(jsonString);

import 'dart:convert';

class GetKotaModel {
  GetKotaModel({
    this.hasil,
    this.result,
  });

  bool hasil;
  List<ResultKota> result;

  factory GetKotaModel.fromRawJson(String str) => GetKotaModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GetKotaModel.fromJson(Map<String, dynamic> json) => GetKotaModel(
    hasil: json["hasil"],
    result: List<ResultKota>.from(json["result"].map((x) => ResultKota.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "hasil": hasil,
    "result": List<dynamic>.from(result.map((x) => x.toJson())),
  };
}

class ResultKota {
  ResultKota({
    this.id,
    this.provinsi,
    this.kota,
    this.kode,
    this.active,
    this.createdAt,
    this.createdBy,
    this.v,
  });

  String id;
  String provinsi;
  String kota;
  String kode;
  bool active;
  DateTime createdAt;
  String createdBy;
  int v;

  factory ResultKota.fromRawJson(String str) => ResultKota.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ResultKota.fromJson(Map<String, dynamic> json) => ResultKota(
    id: json["_id"],
    provinsi: json["Provinsi"],
    kota: json["Kota"],
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
    "Kode": kode,
    "Active": active,
    "CreatedAt": createdAt.toIso8601String(),
    "CreatedBy": createdBy,
    "__v": v,
  };
}
