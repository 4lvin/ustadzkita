// To parse this JSON data, do
//
//     final getMasterKajianModel = getMasterKajianModelFromJson(jsonString);

import 'dart:convert';

class GetMasterKajianModel {
  GetMasterKajianModel({
    this.hasil,
    this.result,
  });

  bool hasil;
  List<ResultKajian> result;

  factory GetMasterKajianModel.fromRawJson(String str) => GetMasterKajianModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GetMasterKajianModel.fromJson(Map<String, dynamic> json) => GetMasterKajianModel(
    hasil: json["hasil"],
    result: List<ResultKajian>.from(json["result"].map((x) => ResultKajian.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "hasil": hasil,
    "result": List<dynamic>.from(result.map((x) => x.toJson())),
  };
}

class ResultKajian {
  ResultKajian({
    this.id,
    this.jenis,
    this.active,
    this.createdAt,
    this.createdBy,
    this.v,
  });

  String id;
  String jenis;
  bool active;
  DateTime createdAt;
  String createdBy;
  int v;

  factory ResultKajian.fromRawJson(String str) => ResultKajian.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ResultKajian.fromJson(Map<String, dynamic> json) => ResultKajian(
    id: json["_id"],
    jenis: json["Jenis"],
    active: json["Active"],
    createdAt: DateTime.parse(json["CreatedAt"]),
    createdBy: json["CreatedBy"],
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "Jenis": jenis,
    "Active": active,
    "CreatedAt": createdAt.toIso8601String(),
    "CreatedBy": createdBy,
    "__v": v,
  };
}
