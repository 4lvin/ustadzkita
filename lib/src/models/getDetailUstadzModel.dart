// To parse this JSON data, do
//
//     final getDetailUstadzModel = getDetailUstadzModelFromJson(jsonString);

import 'dart:convert';

class GetDetailUstadzModel {
  GetDetailUstadzModel({
    this.hasil,
    this.result,
  });

  bool hasil;
  DetailUstadz result;

  factory GetDetailUstadzModel.fromRawJson(String str) => GetDetailUstadzModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GetDetailUstadzModel.fromJson(Map<String, dynamic> json) => GetDetailUstadzModel(
    hasil: json["hasil"],
    result: DetailUstadz.fromJson(json["result"]),
  );

  Map<String, dynamic> toJson() => {
    "hasil": hasil,
    "result": result.toJson(),
  };
}

class DetailUstadz {
  DetailUstadz({
    this.nama,
    this.pendidikan,
    this.pekerjaan,
    this.organisasi,
    this.ulasan,
    this.artikel,
  });

  String nama;
  List<String> pendidikan;
  List<dynamic> pekerjaan;
  List<dynamic> organisasi;
  List<UlasanModel> ulasan;
  List<Artikel> artikel;

  factory DetailUstadz.fromRawJson(String str) => DetailUstadz.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DetailUstadz.fromJson(Map<String, dynamic> json) => DetailUstadz(
    nama: json["nama"],
    pendidikan: List<String>.from(json["pendidikan"].map((x) => x)),
    pekerjaan: List<dynamic>.from(json["pekerjaan"].map((x) => x)),
    organisasi: List<dynamic>.from(json["organisasi"].map((x) => x)),
    ulasan: List<UlasanModel>.from(json["ulasan"].map((x) => UlasanModel.fromJson(x))),
    artikel: List<Artikel>.from(json["artikel"].map((x) => Artikel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "nama": nama,
    "pendidikan": List<dynamic>.from(pendidikan.map((x) => x)),
    "pekerjaan": List<dynamic>.from(pekerjaan.map((x) => x)),
    "organisasi": List<dynamic>.from(organisasi.map((x) => x)),
    "ulasan": List<dynamic>.from(ulasan.map((x) => x.toJson())),
    "artikel": List<dynamic>.from(artikel.map((x) => x.toJson())),
  };
}

class Artikel {
  Artikel({
    this.id,
    this.judul,
    this.foto,
    this.artikel,
    this.active,
    this.kode,
    this.kategori,
    this.label,
    this.createdAt,
    this.createdByU,
    this.v,
  });

  String id;
  String judul;
  String foto;
  String artikel;
  bool active;
  String kode;
  String kategori;
  String label;
  DateTime createdAt;
  String createdByU;
  int v;

  factory Artikel.fromRawJson(String str) => Artikel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Artikel.fromJson(Map<String, dynamic> json) => Artikel(
    id: json["_id"],
    judul: json["judul"],
    foto: json["foto"],
    artikel: json["artikel"],
    active: json["active"],
    kode: json["kode"],
    kategori: json["kategori"],
    label: json["label"],
    createdAt: DateTime.parse(json["CreatedAt"]),
    createdByU: json["CreatedByU"],
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "judul": judul,
    "foto": foto,
    "artikel": artikel,
    "active": active,
    "kode": kode,
    "kategori": kategori,
    "label": label,
    "CreatedAt": createdAt.toIso8601String(),
    "CreatedByU": createdByU,
    "__v": v,
  };
}

class UlasanModel {
  UlasanModel({
    this.id,
    this.guest,
    this.ustadz,
    this.rating,
    this.type,
    this.undangan,
    this.createdAt,
    this.v,
    this.komentar,
    this.chat,
  });

  String id;
  Guest guest;
  String ustadz;
  String rating;
  String type;
  String undangan;
  DateTime createdAt;
  int v;
  String komentar;
  String chat;

  factory UlasanModel.fromRawJson(String str) => UlasanModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UlasanModel.fromJson(Map<String, dynamic> json) => UlasanModel(
    id: json["_id"],
    guest: Guest.fromJson(json["guest"]),
    ustadz: json["ustadz"],
    rating: json["rating"],
    type: json["Type"],
    undangan: json["undangan"] == null ? null : json["undangan"],
    createdAt: DateTime.parse(json["CreatedAt"]),
    v: json["__v"],
    komentar: json["komentar"],
    chat: json["chat"] == null ? null : json["chat"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "guest": guest.toJson(),
    "ustadz": ustadz,
    "rating": rating,
    "Type": type,
    "undangan": undangan == null ? null : undangan,
    "CreatedAt": createdAt.toIso8601String(),
    "__v": v,
    "komentar": komentar,
    "chat": chat == null ? null : chat,
  };
}

class Guest {
  Guest({
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
  String provinsiId;
  String kotaId;
  String kecamatanId;
  String noHp;
  String email;
  int active;
  String type;
  DateTime createdAt;
  int v;
  DateTime editedAt;
  String foto;
  List<dynamic> riwayatOrganisasi;
  List<dynamic> riwayatPekerjaan;
  List<dynamic> daftarKaryaTulis;
  List<dynamic> pendidikan;

  factory Guest.fromRawJson(String str) => Guest.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Guest.fromJson(Map<String, dynamic> json) => Guest(
    id: json["_id"],
    username: json["Username"],
    password: json["Password"],
    fullName: json["FullName"],
    provinsi: json["Provinsi"],
    kota: json["Kota"],
    kecamatan: json["Kecamatan"],
    provinsiId: json["Provinsi_id"],
    kotaId: json["Kota_id"],
    kecamatanId: json["Kecamatan_id"],
    noHp: json["NoHP"],
    email: json["Email"],
    active: json["Active"],
    type: json["Type"],
    createdAt: DateTime.parse(json["CreatedAt"]),
    v: json["__v"],
    editedAt: DateTime.parse(json["EditedAt"]),
    foto: json["Foto"],
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
    "Provinsi_id": provinsiId,
    "Kota_id": kotaId,
    "Kecamatan_id": kecamatanId,
    "NoHP": noHp,
    "Email": email,
    "Active": active,
    "Type": type,
    "CreatedAt": createdAt.toIso8601String(),
    "__v": v,
    "EditedAt": editedAt.toIso8601String(),
    "Foto": foto,
    "RiwayatOrganisasi": List<dynamic>.from(riwayatOrganisasi.map((x) => x)),
    "RiwayatPekerjaan": List<dynamic>.from(riwayatPekerjaan.map((x) => x)),
    "DaftarKaryaTulis": List<dynamic>.from(daftarKaryaTulis.map((x) => x)),
    "Pendidikan": List<dynamic>.from(pendidikan.map((x) => x)),
  };
}
