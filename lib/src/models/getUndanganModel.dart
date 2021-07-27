// To parse this JSON data, do
//
//     final getUndanganModel = getUndanganModelFromJson(jsonString);

import 'dart:convert';

class GetUndanganModel {
  GetUndanganModel({
    this.hasil,
    this.message,
    this.penerima,
    this.nomorUndangan,
    this.jenisKegiatan,
    this.tanggal,
    this.waktuMulai,
    this.waktuSelesai,
    this.jumlahPeserta,
    this.lokasi,
    this.akomodasi,
  });

  bool hasil;
  String message;
  String penerima;
  String nomorUndangan;
  String jenisKegiatan;
  DateTime tanggal;
  String waktuMulai;
  String waktuSelesai;
  String jumlahPeserta;
  String lokasi;
  String akomodasi;

  factory GetUndanganModel.fromRawJson(String str) => GetUndanganModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GetUndanganModel.fromJson(Map<String, dynamic> json) => GetUndanganModel(
    hasil: json["hasil"],
    message: json["message"],
    penerima: json["Penerima"],
    nomorUndangan: json["NomorUndangan"],
    jenisKegiatan: json["JenisKegiatan"],
    tanggal: DateTime.parse(json["Tanggal"]),
    waktuMulai: json["WaktuMulai"],
    waktuSelesai: json["WaktuSelesai"],
    jumlahPeserta: json["JumlahPeserta"],
    lokasi: json["Lokasi"],
    akomodasi: json["Akomodasi"],
  );

  Map<String, dynamic> toJson() => {
    "hasil": hasil,
    "message": message,
    "Penerima": penerima,
    "NomorUndangan": nomorUndangan,
    "JenisKegiatan": jenisKegiatan,
    "Tanggal": "${tanggal.year.toString().padLeft(4, '0')}-${tanggal.month.toString().padLeft(2, '0')}-${tanggal.day.toString().padLeft(2, '0')}",
    "WaktuMulai": waktuMulai,
    "WaktuSelesai": waktuSelesai,
    "JumlahPeserta": jumlahPeserta,
    "Lokasi": lokasi,
    "Akomodasi": akomodasi,
  };
}
