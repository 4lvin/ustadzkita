// To parse this JSON data, do
//
//     final resUlasanModel = resUlasanModelFromJson(jsonString);

import 'dart:convert';

class ResUlasanModel {
  ResUlasanModel({
    this.hasil,
    this.message,
  });

  bool hasil;
  String message;

  factory ResUlasanModel.fromRawJson(String str) => ResUlasanModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ResUlasanModel.fromJson(Map<String, dynamic> json) => ResUlasanModel(
    hasil: json["hasil"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "hasil": hasil,
    "message": message,
  };
}
