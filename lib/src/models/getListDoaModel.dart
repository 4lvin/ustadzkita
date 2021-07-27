// To parse this JSON data, do
//
//     final getListDoaModel = getListDoaModelFromJson(jsonString);

import 'dart:convert';

class GetListDoaModel {
  GetListDoaModel({
    this.hasil,
    this.message,
    this.result,
  });

  bool hasil;
  String message;
  List<Result> result;

  factory GetListDoaModel.fromRawJson(String str) => GetListDoaModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GetListDoaModel.fromJson(Map<String, dynamic> json) => GetListDoaModel(
    hasil: json["hasil"],
    message: json["message"],
    result: List<Result>.from(json["result"].map((x) => Result.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "hasil": hasil,
    "message": message,
    "result": List<dynamic>.from(result.map((x) => x.toJson())),
  };
}

class Result {
  Result({
    this.judul,
    this.isi,
    this.kode,
  });

  String judul;
  String isi;
  String kode;

  factory Result.fromRawJson(String str) => Result.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    judul: json["judul"],
    isi: json["isi"],
    kode: json["kode"],
  );

  Map<String, dynamic> toJson() => {
    "judul": judul,
    "isi": isi,
    "kode": kode,
  };
}
