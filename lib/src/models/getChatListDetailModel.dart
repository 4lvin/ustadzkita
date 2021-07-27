// To parse this JSON data, do
//
//     final getChatListDetailModel = getChatListDetailModelFromJson(jsonString);

import 'dart:convert';

class GetChatListDetailModel {
  GetChatListDetailModel({
    this.hasil,
    this.nama,
    this.pesan,
    this.message,
  });

  bool hasil;
  String nama;
  List<Pesan> pesan;
  String message;

  factory GetChatListDetailModel.fromRawJson(String str) => GetChatListDetailModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GetChatListDetailModel.fromJson(Map<String, dynamic> json) => GetChatListDetailModel(
    hasil: json["hasil"],
    nama: json["nama"],
    pesan: List<Pesan>.from(json["pesan"].map((x) => Pesan.fromJson(x))),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "hasil": hasil,
    "nama": nama,
    "pesan": List<dynamic>.from(pesan.map((x) => x.toJson())),
    "message": message,
  };
}

class Pesan {
  Pesan({
    this.id,
    this.dari,
    this.ke,
    this.topik,
    this.isi,
    this.read,
    this.createdAt,
    this.v,
  });

  String id;
  String dari;
  String ke;
  String topik;
  String isi;
  bool read;
  DateTime createdAt;
  int v;

  factory Pesan.fromRawJson(String str) => Pesan.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Pesan.fromJson(Map<String, dynamic> json) => Pesan(
    id: json["_id"],
    dari: json["dari"],
    ke: json["ke"],
    topik: json["topik"],
    isi: json["isi"],
    read: json["read"],
    createdAt: DateTime.parse(json["CreatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "dari": dari,
    "ke": ke,
    "topik": topik,
    "isi": isi,
    "read": read,
    "CreatedAt": createdAt.toIso8601String(),
    "__v": v,
  };
}
