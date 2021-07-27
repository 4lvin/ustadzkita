// To parse this JSON data, do
//
//     final getDetailDoaModel = getDetailDoaModelFromJson(jsonString);

import 'dart:convert';

class GetDetailDoaModel {
  GetDetailDoaModel({
    this.hasil,
    this.message,
    this.result,
    this.mark,
  });

  bool hasil;
  String message;
  Result result;
  bool mark;

  factory GetDetailDoaModel.fromRawJson(String str) => GetDetailDoaModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GetDetailDoaModel.fromJson(Map<String, dynamic> json) => GetDetailDoaModel(
    hasil: json["hasil"],
    message: json["message"],
    result: Result.fromJson(json["result"]),
    mark: json["mark"],
  );

  Map<String, dynamic> toJson() => {
    "hasil": hasil,
    "message": message,
    "result": result.toJson(),
    "mark": mark,
  };
}

class Result {
  Result({
    this.judul,
    this.foto,
    this.isi,
    this.kode,
    this.created,
  });

  String judul;
  String foto;
  String isi;
  String kode;
  DateTime created;

  factory Result.fromRawJson(String str) => Result.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    judul: json["judul"],
    foto: json["foto"],
    isi: json["isi"],
    kode: json["kode"],
    created: DateTime.parse(json["Created"]),
  );

  Map<String, dynamic> toJson() => {
    "judul": judul,
    "foto": foto,
    "isi": isi,
    "kode": kode,
    "Created": created.toIso8601String(),
  };
}
