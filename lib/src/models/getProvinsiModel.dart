// To parse this JSON data, do
//
//     final getProvinsiModel = getProvinsiModelFromJson(jsonString);

import 'dart:convert';

class GetProvinsiModel {
  GetProvinsiModel({
    this.hasil,
    this.result,
  });

  bool hasil;
  List<ResultProv> result;

  factory GetProvinsiModel.fromRawJson(String str) => GetProvinsiModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GetProvinsiModel.fromJson(Map<String, dynamic> json) => GetProvinsiModel(
    hasil: json["hasil"],
    result: List<ResultProv>.from(json["result"].map((x) => ResultProv.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "hasil": hasil,
    "result": List<dynamic>.from(result.map((x) => x.toJson())),
  };
}

class ResultProv {
  ResultProv({
    this.id,
    this.provinsi,
    this.kode,
    this.active,
    this.createdAt,
    this.createdBy,
    this.v,
  });

  String id;
  String provinsi;
  String kode;
  bool active;
  DateTime createdAt;
  String createdBy;
  int v;

  factory ResultProv.fromRawJson(String str) => ResultProv.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ResultProv.fromJson(Map<String, dynamic> json) => ResultProv(
    id: json["_id"],
    provinsi: json["Provinsi"],
    kode: json["Kode"],
    active: json["Active"],
    createdAt: DateTime.parse(json["CreatedAt"]),
    createdBy: json["CreatedBy"],
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "Provinsi": provinsi,
    "Kode": kode,
    "Active": active,
    "CreatedAt": createdAt.toIso8601String(),
    "CreatedBy": createdBy,
    "__v": v,
  };
}
