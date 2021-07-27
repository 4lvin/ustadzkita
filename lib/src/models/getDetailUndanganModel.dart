// To parse this JSON data, do
//
//     final getDetailUndanganModel = getDetailUndanganModelFromJson(jsonString);

import 'dart:convert';

class GetDetailUndanganModel {
  GetDetailUndanganModel({
    this.hasil,
    this.kodeUdangan,
    this.ustadz,
    this.list,
    this.message,
  });

  bool hasil;
  String kodeUdangan;
  Ustadz ustadz;
  List<ListElement> list;
  String message;

  factory GetDetailUndanganModel.fromRawJson(String str) => GetDetailUndanganModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GetDetailUndanganModel.fromJson(Map<String, dynamic> json) => GetDetailUndanganModel(
    hasil: json["hasil"],
    kodeUdangan: json["KodeUdangan"],
    ustadz: Ustadz.fromJson(json["ustadz"]),
    list: List<ListElement>.from(json["list"].map((x) => ListElement.fromJson(x))),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "hasil": hasil,
    "KodeUdangan": kodeUdangan,
    "ustadz": ustadz.toJson(),
    "list": List<dynamic>.from(list.map((x) => x.toJson())),
    "message": message,
  };
}

class ListElement {
  ListElement({
    this.status,
    this.waktu,
  });

  String status;
  String waktu;

  factory ListElement.fromRawJson(String str) => ListElement.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ListElement.fromJson(Map<String, dynamic> json) => ListElement(
    status: json["Status"],
    waktu: json["Waktu"],
  );

  Map<String, dynamic> toJson() => {
    "Status": status,
    "Waktu": waktu,
  };
}

class Ustadz {
  Ustadz({
    this.nama,
    this.kota,
  });

  String nama;
  String kota;

  factory Ustadz.fromRawJson(String str) => Ustadz.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Ustadz.fromJson(Map<String, dynamic> json) => Ustadz(
    nama: json["Nama"],
    kota: json["Kota"],
  );

  Map<String, dynamic> toJson() => {
    "Nama": nama,
    "Kota": kota,
  };
}
