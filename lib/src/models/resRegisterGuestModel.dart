// To parse this JSON data, do
//
//     final resRegisterGuestModel = resRegisterGuestModelFromJson(jsonString);

import 'dart:convert';

class ResRegisterGuestModel {
  ResRegisterGuestModel({
    this.hasil,
    this.message,
  });

  bool hasil;
  String message;

  factory ResRegisterGuestModel.fromRawJson(String str) => ResRegisterGuestModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ResRegisterGuestModel.fromJson(Map<String, dynamic> json) => ResRegisterGuestModel(
    hasil: json["hasil"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "hasil": hasil,
    "message": message,
  };
}
