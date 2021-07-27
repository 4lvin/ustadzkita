// To parse this JSON data, do
//
//     final getListUstadzModel = getListUstadzModelFromJson(jsonString);

import 'dart:convert';

class GetListUstadzModel {
  GetListUstadzModel({
    this.hasil,
    this.message,
    this.result,
  });

  bool hasil;
  String message;
  List<Result> result;

  factory GetListUstadzModel.fromRawJson(String str) => GetListUstadzModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GetListUstadzModel.fromJson(Map<String, dynamic> json) => GetListUstadzModel(
    hasil: json["hasil"],
    message: json["message"],
    result: List<Result>.from(json["result"].map((x) => Result.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "hasil": hasil,
    "message": message,
    "result": List<dynamic>.from(result.map((x) => x.toJson())),
  };
}

class Result {
  Result({
    this.id,
    this.password,
    this.fullName,
    this.tglLahir,
    this.tmptLahir,
    this.sex,
    this.agama,
    this.statusPernikahan,
    this.kewarganegaraan,
    this.alamatDetail,
    this.provinsi,
    this.kota,
    this.kecamatan,
    this.provinsiId,
    this.kotaId,
    this.kecamatanId,
    this.noHp,
    this.email,
    this.profilSingkat,
    this.active,
    this.type,
    this.createdAt,
    this.createdBy,
    this.foto,
    this.v,
    this.daftarKaryaTulis,
    this.pendidikan,
  });

  String id;
  String password;
  String fullName;
  String tglLahir;
  String tmptLahir;
  String sex;
  String agama;
  String statusPernikahan;
  String kewarganegaraan;
  String alamatDetail;
  String provinsi;
  String kota;
  String kecamatan;
  String provinsiId;
  String kotaId;
  String kecamatanId;
  String noHp;
  String email;
  String profilSingkat;
  int active;
  String type;
  DateTime createdAt;
  String createdBy;
  String foto;
  int v;
  List<String> daftarKaryaTulis;
  List<String> pendidikan;

  factory Result.fromRawJson(String str) => Result.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    id: json["_id"],
    password: json["Password"],
    fullName: json["FullName"],
    tglLahir: json["TglLahir"],
    tmptLahir: json["TmptLahir"],
    sex: json["Sex"],
    agama: json["Agama"],
    statusPernikahan: json["StatusPernikahan"],
    kewarganegaraan: json["Kewarganegaraan"],
    alamatDetail: json["AlamatDetail"],
    provinsi: json["Provinsi"],
    kota: json["Kota"],
    kecamatan: json["Kecamatan"],
    provinsiId: json["Provinsi_id"],
    kotaId: json["Kota_id"],
    kecamatanId: json["Kecamatan_id"],
    noHp: json["NoHP"],
    email: json["Email"],
    profilSingkat: json["ProfilSingkat"],
    active: json["Active"],
    type: json["Type"],
    createdAt: DateTime.parse(json["CreatedAt"]),
    createdBy: json["CreatedBy"],
    foto: json["Foto"],
    v: json["__v"],
    daftarKaryaTulis: List<String>.from(json["DaftarKaryaTulis"].map((x) => x)),
    pendidikan: List<String>.from(json["Pendidikan"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "Password": password,
    "FullName": fullName,
    "TglLahir": tglLahir,
    "TmptLahir": tmptLahir,
    "Sex": sex,
    "Agama": agama,
    "StatusPernikahan": statusPernikahan,
    "Kewarganegaraan": kewarganegaraan,
    "AlamatDetail": alamatDetail,
    "Provinsi": provinsi,
    "Kota": kota,
    "Kecamatan": kecamatan,
    "Provinsi_id": provinsiId,
    "Kota_id": kotaId,
    "Kecamatan_id": kecamatanId,
    "NoHP": noHp,
    "Email": email,
    "ProfilSingkat": profilSingkat,
    "Active": active,
    "Type": type,
    "CreatedAt": createdAt.toIso8601String(),
    "CreatedBy": createdBy,
    "Foto": foto,
    "__v": v,
    "DaftarKaryaTulis": List<dynamic>.from(daftarKaryaTulis.map((x) => x)),
    "Pendidikan": List<dynamic>.from(pendidikan.map((x) => x)),
  };
}
