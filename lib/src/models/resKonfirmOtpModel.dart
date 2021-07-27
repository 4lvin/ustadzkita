// To parse this JSON data, do
//
//     final resKonfirmOtpModel = resKonfirmOtpModelFromJson(jsonString);

import 'dart:convert';

class ResKonfirmOtpModel {
  ResKonfirmOtpModel({
    this.hasil,
    this.message,
  });

  bool hasil;
  String message;

  factory ResKonfirmOtpModel.fromRawJson(String str) => ResKonfirmOtpModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ResKonfirmOtpModel.fromJson(Map<String, dynamic> json) => ResKonfirmOtpModel(
    hasil: json["hasil"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "hasil": hasil,
    "message": message,
  };
}
