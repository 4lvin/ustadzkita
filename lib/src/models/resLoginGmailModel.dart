// To parse this JSON data, do
//
//     final resLoginGmailModel = resLoginGmailModelFromJson(jsonString);

import 'dart:convert';

class ResLoginGmailModel {
  ResLoginGmailModel({
    this.hasil,
    this.status,
    this.message,
    this.data,
    this.type,
  });

  bool hasil;
  int status;
  String message;
  Data data;
  String type;

  factory ResLoginGmailModel.fromRawJson(String str) => ResLoginGmailModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ResLoginGmailModel.fromJson(Map<String, dynamic> json) => ResLoginGmailModel(
    hasil: json["hasil"],
    status: json["status"],
    message: json["message"],
    data: Data.fromJson(json["data"]),
    type: json["type"],
  );

  Map<String, dynamic> toJson() => {
    "hasil": hasil,
    "status": status,
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
  });

  String token;
  String id;
  String fullname;
  Kota kota;

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    token: json["token"],
    id: json["id"],
    fullname: json["fullname"],
    kota: Kota.fromJson(json["Kota"]),
  );

  Map<String, dynamic> toJson() => {
    "token": token,
    "id": id,
    "fullname": fullname,
    "Kota": kota.toJson(),
  };
}

class Kota {
  Kota({
    this.id,
    this.provinsi,
    this.kota,
    this.kode,
    this.active,
    this.createdAt,
    this.createdBy,
    this.v,
  });

  String id;
  String provinsi;
  String kota;
  String kode;
  bool active;
  String createdAt;
  String createdBy;
  int v;

  factory Kota.fromRawJson(String str) => Kota.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Kota.fromJson(Map<String, dynamic> json) => Kota(
    id: json["_id"],
    provinsi: json["Provinsi"],
    kota: json["Kota"],
    kode: json["Kode"],
    active: json["Active"],
    createdAt: json["CreatedAt"],
    createdBy: json["CreatedBy"],
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "Provinsi": provinsi,
    "Kota": kota,
    "Kode": kode,
    "Active": active,
    "CreatedAt": createdAt,
    "CreatedBy": createdBy,
    "__v": v,
  };
}
