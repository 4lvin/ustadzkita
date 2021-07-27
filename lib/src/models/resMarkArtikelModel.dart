// To parse this JSON data, do
//
//     final resMarkArtikelModel = resMarkArtikelModelFromJson(jsonString);

import 'dart:convert';

class ResMarkArtikelModel {
  ResMarkArtikelModel({
    this.hasil,
    this.message,
    this.mark,
  });

  bool hasil;
  String message;
  bool mark;

  factory ResMarkArtikelModel.fromRawJson(String str) => ResMarkArtikelModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ResMarkArtikelModel.fromJson(Map<String, dynamic> json) => ResMarkArtikelModel(
    hasil: json["hasil"],
    message: json["message"],
    mark: json["mark"],
  );

  Map<String, dynamic> toJson() => {
    "hasil": hasil,
    "message": message,
    "mark": mark,
  };
}
