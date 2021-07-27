// To parse this JSON data, do
//
//     final resLupaPasswordModel = resLupaPasswordModelFromJson(jsonString);

import 'dart:convert';

class ResLupaPasswordModel {
  ResLupaPasswordModel({
    this.hasil,
    this.message,
  });

  bool hasil;
  String message;

  factory ResLupaPasswordModel.fromRawJson(String str) => ResLupaPasswordModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ResLupaPasswordModel.fromJson(Map<String, dynamic> json) => ResLupaPasswordModel(
    hasil: json["hasil"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "hasil": hasil,
    "message": message,
  };
}
