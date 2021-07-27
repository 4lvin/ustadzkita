// To parse this JSON data, do
//
//     final getChatListModel = getChatListModelFromJson(jsonString);

import 'dart:convert';

class GetChatListModel {
  GetChatListModel({
    this.hasil,
    this.data,
    this.message,
  });

  bool hasil;
  List<Datum> data;
  String message;

  factory GetChatListModel.fromRawJson(String str) => GetChatListModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GetChatListModel.fromJson(Map<String, dynamic> json) => GetChatListModel(
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
    this.topik,
    this.nama,
    this.read,
    this.email,
    this.isi,
  });

  String topik;
  String nama;
  int read;
  String email;
  String isi;

  factory Datum.fromRawJson(String str) => Datum.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    topik: json["topik"],
    nama: json["nama"],
    read: json["read"],
    email: json["email"],
    isi: json["isi"],
  );

  Map<String, dynamic> toJson() => {
    "topik": topik,
    "nama": nama,
    "read": read,
    "email": email,
    "isi": isi,
  };
}
