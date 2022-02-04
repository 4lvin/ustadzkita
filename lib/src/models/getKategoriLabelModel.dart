// To parse this JSON data, do
//
//     final getKategoriLabelModel = getKategoriLabelModelFromJson(jsonString);

import 'dart:convert';

class GetKategoriLabelModel {
  GetKategoriLabelModel({
    this.hasil,
    this.message,
    this.result,
  });

  bool hasil;
  String message;
  List<ResultKatLbl> result;

  factory GetKategoriLabelModel.fromRawJson(String str) => GetKategoriLabelModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GetKategoriLabelModel.fromJson(Map<String, dynamic> json) => GetKategoriLabelModel(
    hasil: json["hasil"],
    message: json["message"],
    result: List<ResultKatLbl>.from(json["result"].map((x) => ResultKatLbl.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "hasil": hasil,
    "message": message,
    "result": List<dynamic>.from(result.map((x) => x.toJson())),
  };
}

class ResultKatLbl {
  ResultKatLbl({
    this.id,
    this.nama,
    this.kode,
    this.active,
    this.createdAt,
    this.createdBy,
    this.v,
  });

  String id;
  String nama;
  String kode;
  bool active;
  DateTime createdAt;
  String createdBy;
  int v;

  factory ResultKatLbl.fromRawJson(String str) => ResultKatLbl.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ResultKatLbl.fromJson(Map<String, dynamic> json) => ResultKatLbl(
    id: json["_id"],
    nama: json["nama"],
    kode: json["kode"],
    active: json["active"],
    createdAt: DateTime.parse(json["CreatedAt"]),
    createdBy: json["CreatedBy"],
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "nama": nama,
    "kode": kode,
    "active": active,
    "CreatedAt": createdAt.toIso8601String(),
    "CreatedBy": createdBy,
    "__v": v,
  };
}
