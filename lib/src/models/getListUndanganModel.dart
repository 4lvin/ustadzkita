// To parse this JSON data, do
//
//     final getListUndanganModel = getListUndanganModelFromJson(jsonString);

import 'dart:convert';

class GetListUndanganModel {
  GetListUndanganModel({
    this.hasil,
    this.result,
    this.message,
  });

  bool hasil;
  List<Result> result;
  String message;

  factory GetListUndanganModel.fromRawJson(String str) => GetListUndanganModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GetListUndanganModel.fromJson(Map<String, dynamic> json) => GetListUndanganModel(
    hasil: json["hasil"],
    result: List<Result>.from(json["result"].map((x) => Result.fromJson(x))),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "hasil": hasil,
    "result": List<dynamic>.from(result.map((x) => x.toJson())),
    "message": message,
  };
}

class Result {
  Result({
    this.nama,
    this.tanggal,
    this.jam,
    this.jenis,
    this.kode,
    this.tema,
    this.lokasi,
    this.email
  });

  String nama;
  DateTime tanggal;
  String jam;
  String jenis;
  String kode;
  String tema;
  String lokasi;
  String email;

  factory Result.fromRawJson(String str) => Result.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    nama: json["Nama"],
    tanggal: DateTime.parse(json["Tanggal"]),
    jam: json["Jam"],
    jenis: json["Jenis"],
    kode: json["Kode"],
    tema: json["Tema"],
    lokasi: json["Lokasi"],
    email: json["Email"],
  );

  Map<String, dynamic> toJson() => {
    "Nama": nama,
    "Tanggal": "${tanggal.year.toString().padLeft(4, '0')}-${tanggal.month.toString().padLeft(2, '0')}-${tanggal.day.toString().padLeft(2, '0')}",
    "Jam": jam,
    "Jenis": jenis,
    "Kode": kode,
    "Tema": tema,
    "Lokasi": lokasi,
    "Email": email,
  };
}
