// To parse this JSON data, do
//
//     final getLoginModel = getLoginModelFromJson(jsonString);

import 'dart:convert';

class GetLoginModel {
  GetLoginModel({
    this.hasil,
    this.message,
    this.data,
    this.type,
  });

  bool hasil;
  String message;
  Data data;
  String type;

  factory GetLoginModel.fromRawJson(String str) => GetLoginModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GetLoginModel.fromJson(Map<String, dynamic> json) => GetLoginModel(
    hasil: json["hasil"],
    message: json["message"],
    data: Data.fromJson(json["data"]),
    type: json["type"],
  );

  Map<String, dynamic> toJson() => {
    "hasil": hasil,
    "message": message,
    "data": data.toJson(),
    "type": type,
  };
}

class Data {
  Data({
    this.token,
    this.id,
    this.fullname,
    this.kota,
    this.noTelp,
    this.namaKota,
  });

  String token;
  String id;
  String fullname;
  String kota;
  String noTelp;
  String namaKota;

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    token: json["token"],
    id: json["id"],
    fullname: json["fullname"],
    kota: json["Kota"],
    noTelp: json["noTelp"],
    namaKota: json["NamaKota"],
  );

  Map<String, dynamic> toJson() => {
    "token": token,
    "id": id,
    "fullname": fullname,
    "Kota": kota,
    "noTelp": noTelp,
    "NamaKota": namaKota,
  };
}
