// To parse this JSON data, do
//
//     final resPostArtikelModel = resPostArtikelModelFromJson(jsonString);

import 'dart:convert';

class ResPostArtikelModel {
  ResPostArtikelModel({
    this.hasil,
    this.message,
  });

  bool hasil;
  String message;

  factory ResPostArtikelModel.fromRawJson(String str) => ResPostArtikelModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ResPostArtikelModel.fromJson(Map<String, dynamic> json) => ResPostArtikelModel(
    hasil: json["hasil"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "hasil": hasil,
    "message": message,
  };
}
