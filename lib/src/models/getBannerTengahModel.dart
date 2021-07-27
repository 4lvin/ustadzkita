// To parse this JSON data, do
//
//     final getBannerTengahModel = getBannerTengahModelFromJson(jsonString);

import 'dart:convert';

class GetBannerTengahModel {
  GetBannerTengahModel({
    this.hasil,
    this.message,
    this.result,
  });

  bool hasil;
  String message;
  List<Result> result;

  factory GetBannerTengahModel.fromRawJson(String str) => GetBannerTengahModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GetBannerTengahModel.fromJson(Map<String, dynamic> json) => GetBannerTengahModel(
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
    this.image,
    this.link,
  });

  String image;
  String link;

  factory Result.fromRawJson(String str) => Result.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    image: json["image"],
    link: json["link"],
  );

  Map<String, dynamic> toJson() => {
    "image": image,
    "link": link,
  };
}
