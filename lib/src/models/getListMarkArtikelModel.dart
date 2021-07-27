// To parse this JSON data, do
//
//     final getListMarkArtikelModel = getListMarkArtikelModelFromJson(jsonString);

import 'dart:convert';

class GetListMarkArtikelModel {
  GetListMarkArtikelModel({
    this.hasil,
    this.message,
    this.result,
  });

  bool hasil;
  String message;
  List<Result> result;

  factory GetListMarkArtikelModel.fromRawJson(String str) => GetListMarkArtikelModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GetListMarkArtikelModel.fromJson(Map<String, dynamic> json) => GetListMarkArtikelModel(
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
    this.id,
    this.user,
    this.artikel,
    this.label,
    this.kategori,
    this.v,
  });

  String id;
  String user;
  Artikel artikel;
  String label;
  String kategori;
  int v;

  factory Result.fromRawJson(String str) => Result.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    id: json["_id"],
    user: json["user"],
    artikel: Artikel.fromJson(json["artikel"]),
    label: json["label"],
    kategori: json["kategori"],
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "user": user,
    "artikel": artikel.toJson(),
    "label": label,
    "kategori": kategori,
    "__v": v,
  };
}

class Artikel {
  Artikel({
    this.id,
    this.judul,
    this.foto,
    this.artikel,
    this.active,
    this.kode,
    this.kategori,
    this.label,
    this.createdAt,
    this.createdByU,
    this.v,
    this.editedAt,
    this.editedBy,
  });

  String id;
  String judul;
  String foto;
  String artikel;
  bool active;
  String kode;
  String kategori;
  String label;
  DateTime createdAt;
  String createdByU;
  int v;
  DateTime editedAt;
  String editedBy;

  factory Artikel.fromRawJson(String str) => Artikel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Artikel.fromJson(Map<String, dynamic> json) => Artikel(
    id: json["_id"],
    judul: json["judul"],
    foto: json["foto"],
    artikel: json["artikel"],
    active: json["active"],
    kode: json["kode"],
    kategori: json["kategori"],
    label: json["label"],
    createdAt: DateTime.parse(json["CreatedAt"]),
    createdByU: json["CreatedByU"],
    v: json["__v"],
    editedAt: DateTime.parse(json["EditedAt"]),
    editedBy: json["EditedBy"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "judul": judul,
    "foto": foto,
    "artikel": artikel,
    "active": active,
    "kode": kode,
    "kategori": kategori,
    "label": label,
    "CreatedAt": createdAt.toIso8601String(),
    "CreatedByU": createdByU,
    "__v": v,
    "EditedAt": editedAt.toIso8601String(),
    "EditedBy": editedBy,
  };
}
