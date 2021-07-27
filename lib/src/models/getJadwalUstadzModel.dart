// To parse this JSON data, do
//
//     final getJadwalUstadzModel = getJadwalUstadzModelFromJson(jsonString);

import 'dart:convert';

class GetJadwalUstadzModel {
  GetJadwalUstadzModel({
    this.hasil,
    this.result,
    this.message,
  });

  bool hasil;
  List<Result> result;
  String message;

  factory GetJadwalUstadzModel.fromRawJson(String str) => GetJadwalUstadzModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GetJadwalUstadzModel.fromJson(Map<String, dynamic> json) => GetJadwalUstadzModel(
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
    this.tanggal,
    this.kajian,
    this.tema,
    this.waktu,
    this.lokasi,
  });

  DateTime tanggal;
  String kajian;
  String tema;
  String waktu;
  String lokasi;

  factory Result.fromRawJson(String str) => Result.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    tanggal: DateTime.parse(json["Tanggal"]),
    kajian: json["Kajian"],
    tema: json["Tema"],
    waktu: json["waktu"],
    lokasi: json["Lokasi"],
  );

  Map<String, dynamic> toJson() => {
    "Tanggal": "${tanggal.year.toString().padLeft(4, '0')}-${tanggal.month.toString().padLeft(2, '0')}-${tanggal.day.toString().padLeft(2, '0')}",
    "Kajian": kajian,
    "Tema": tema,
    "waktu": waktu,
    "Lokasi": lokasi,
  };
}
