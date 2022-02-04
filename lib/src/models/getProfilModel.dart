// To parse this JSON data, do
//
//     final getProfilModel = getProfilModelFromJson(jsonString);

import 'dart:convert';

class GetProfilModel {
  GetProfilModel({
    this.hasil,
    this.result,
    this.message,
  });

  bool hasil;
  List<Result> result;
  String message;

  factory GetProfilModel.fromRawJson(String str) => GetProfilModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GetProfilModel.fromJson(Map<String, dynamic> json) => GetProfilModel(
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
    this.id,
    this.username,
    this.password,
    this.fullName,
    this.provinsi,
    this.kota,
    this.kecamatan,
    this.provinsiId,
    this.kotaId,
    this.kecamatanId,
    this.noHp,
    this.email,
    this.active,
    this.type,
    this.createdAt,
    this.v,
    this.editedAt,
    this.foto,
    this.agama,
    this.alamatDetail,
    this.kewarganegaraan,
    this.sex,
    this.statusPernikahan,
    this.tglLahir,
    this.tmptLahir,
    this.riwayatOrganisasi,
    this.riwayatPekerjaan,
    this.daftarKaryaTulis,
    this.pendidikan,
  });

  String id;
  String username;
  String password;
  String fullName;
  String provinsi;
  String kota;
  String kecamatan;
  Id provinsiId;
  Id kotaId;
  Id kecamatanId;
  String noHp;
  String email;
  int active;
  String type;
  DateTime createdAt;
  int v;
  DateTime editedAt;
  String foto;
  String agama;
  String alamatDetail;
  String kewarganegaraan;
  String sex;
  String statusPernikahan;
  String tglLahir;
  String tmptLahir;
  List<dynamic> riwayatOrganisasi;
  List<dynamic> riwayatPekerjaan;
  List<dynamic> daftarKaryaTulis;
  List<dynamic> pendidikan;

  factory Result.fromRawJson(String str) => Result.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    id: json["_id"],
    username: json["Username"],
    password: json["Password"],
    fullName: json["FullName"],
    provinsi: json["Provinsi"],
    kota: json["Kota"],
    kecamatan: json["Kecamatan"],
    provinsiId: Id.fromJson(json["Provinsi_id"]),
    kotaId: Id.fromJson(json["Kota_id"]),
    kecamatanId: Id.fromJson(json["Kecamatan_id"]),
    noHp: json["NoHP"],
    email: json["Email"],
    active: json["Active"],
    type: json["Type"],
    createdAt: DateTime.parse(json["CreatedAt"]),
    v: json["__v"],
    editedAt: DateTime.parse(json["EditedAt"]),
    foto: json["Foto"],
    agama: json["Agama"],
    alamatDetail: json["AlamatDetail"],
    kewarganegaraan: json["Kewarganegaraan"],
    sex: json["Sex"],
    statusPernikahan: json["StatusPernikahan"],
    tglLahir: json["TglLahir"],
    tmptLahir: json["TmptLahir"],
    riwayatOrganisasi: List<dynamic>.from(json["RiwayatOrganisasi"].map((x) => x)),
    riwayatPekerjaan: List<dynamic>.from(json["RiwayatPekerjaan"].map((x) => x)),
    daftarKaryaTulis: List<dynamic>.from(json["DaftarKaryaTulis"].map((x) => x)),
    pendidikan: List<dynamic>.from(json["Pendidikan"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "Username": username,
    "Password": password,
    "FullName": fullName,
    "Provinsi": provinsi,
    "Kota": kota,
    "Kecamatan": kecamatan,
    "Provinsi_id": provinsiId.toJson(),
    "Kota_id": kotaId.toJson(),
    "Kecamatan_id": kecamatanId.toJson(),
    "NoHP": noHp,
    "Email": email,
    "Active": active,
    "Type": type,
    "CreatedAt": createdAt.toIso8601String(),
    "__v": v,
    "EditedAt": editedAt.toIso8601String(),
    "Foto": foto,
    "Agama": agama,
    "AlamatDetail": alamatDetail,
    "Kewarganegaraan": kewarganegaraan,
    "Sex": sex,
    "StatusPernikahan": statusPernikahan,
    "TglLahir": tglLahir,
    "TmptLahir": tmptLahir,
    "RiwayatOrganisasi": List<dynamic>.from(riwayatOrganisasi.map((x) => x)),
    "RiwayatPekerjaan": List<dynamic>.from(riwayatPekerjaan.map((x) => x)),
    "DaftarKaryaTulis": List<dynamic>.from(daftarKaryaTulis.map((x) => x)),
    "Pendidikan": List<dynamic>.from(pendidikan.map((x) => x)),
  };
}

class Id {
  Id({
    this.id,
    this.provinsi,
    this.kota,
    this.kecamatan,
    this.kode,
    this.active,
    this.createdAt,
    this.createdBy,
    this.v,
  });

  String id;
  String provinsi;
  String kota;
  String kecamatan;
  String kode;
  bool active;
  DateTime createdAt;
  String createdBy;
  int v;

  factory Id.fromRawJson(String str) => Id.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Id.fromJson(Map<String, dynamic> json) => Id(
    id: json["_id"],
    provinsi: json["Provinsi"],
    kota: json["Kota"] == null ? null : json["Kota"],
    kecamatan: json["Kecamatan"] == null ? null : json["Kecamatan"],
    kode: json["Kode"],
    active: json["Active"],
    createdAt: DateTime.parse(json["CreatedAt"]),
    createdBy: json["CreatedBy"],
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "Provinsi": provinsi,
    "Kota": kota == null ? null : kota,
    "Kecamatan": kecamatan == null ? null : kecamatan,
    "Kode": kode,
    "Active": active,
    "CreatedAt": createdAt.toIso8601String(),
    "CreatedBy": createdBy,
    "__v": v,
  };
}
