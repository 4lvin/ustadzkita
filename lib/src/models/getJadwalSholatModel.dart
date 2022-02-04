// To parse this JSON data, do
//
//     final getJadwalSholatModel = getJadwalSholatModelFromJson(jsonString);

import 'dart:convert';

class GetJadwalSholatModel {
  GetJadwalSholatModel({
    this.list,
    this.sholat,
    this.waktu,
  });

  List<ListElement> list;
  String sholat;
  String waktu;

  factory GetJadwalSholatModel.fromRawJson(String str) => GetJadwalSholatModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GetJadwalSholatModel.fromJson(Map<String, dynamic> json) => GetJadwalSholatModel(
    list: List<ListElement>.from(json["list"].map((x) => ListElement.fromJson(x))),
    sholat: json["sholat"],
    waktu: json["waktu"],
  );

  Map<String, dynamic> toJson() => {
    "list": List<dynamic>.from(list.map((x) => x.toJson())),
    "sholat": sholat,
    "waktu": waktu,
  };
}

class ListElement {
  ListElement({
    this.jadwal,
    this.waktu,
  });

  String jadwal;
  String waktu;

  factory ListElement.fromRawJson(String str) => ListElement.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ListElement.fromJson(Map<String, dynamic> json) => ListElement(
    jadwal: json["Jadwal"],
    waktu: json["Waktu"],
  );

  Map<String, dynamic> toJson() => {
    "Jadwal": jadwal,
    "Waktu": waktu,
  };
}
