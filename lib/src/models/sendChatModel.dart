// To parse this JSON data, do
//
//     final sendChatModel = sendChatModelFromJson(jsonString);

import 'dart:convert';

class SendChatModel {
  SendChatModel({
    this.hasil,
    this.topik,
    this.message,
  });

  bool hasil;
  String topik;
  String message;

  factory SendChatModel.fromRawJson(String str) => SendChatModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SendChatModel.fromJson(Map<String, dynamic> json) => SendChatModel(
    hasil: json["hasil"],
    topik: json["topik"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "hasil": hasil,
    "topik": topik,
    "message": message,
  };
}
