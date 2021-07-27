// To parse this JSON data, do
//
//     final resUstadzKonfirmModel = resUstadzKonfirmModelFromJson(jsonString);

import 'dart:convert';

class ResUstadzKonfirmModel {
  ResUstadzKonfirmModel({
    this.hasil,
    this.message,
  });

  bool hasil;
  String message;

  factory ResUstadzKonfirmModel.fromRawJson(String str) => ResUstadzKonfirmModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ResUstadzKonfirmModel.fromJson(Map<String, dynamic> json) => ResUstadzKonfirmModel(
    hasil: json["hasil"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "hasil": hasil,
    "message": message,
  };
}
