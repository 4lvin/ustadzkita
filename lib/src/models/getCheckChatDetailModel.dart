// To parse this JSON data, do
//
//     final getCheckChatDetailModel = getCheckChatDetailModelFromJson(jsonString);

import 'dart:convert';

class GetCheckChatDetailModel {
  GetCheckChatDetailModel({
    this.hasil,
    this.topik,
    this.nama,
    this.message,
  });

  bool hasil;
  String topik;
  String nama;
  String message;

  factory GetCheckChatDetailModel.fromRawJson(String str) => GetCheckChatDetailModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GetCheckChatDetailModel.fromJson(Map<String, dynamic> json) => GetCheckChatDetailModel(
    hasil: json["hasil"],
    topik: json["topik"],
    nama: json["nama"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "hasil": hasil,
    "topik": topik,
    "nama": nama,
    "message": message,
  };
}
