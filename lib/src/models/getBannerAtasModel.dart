// To parse this JSON data, do
//
//     final getBannerAtasModel = getBannerAtasModelFromJson(jsonString);

import 'dart:convert';

class GetBannerAtasModel {
  GetBannerAtasModel({
    this.hasil,
    this.message,
    this.result,
  });

  bool hasil;
  String message;
  Result result;

  factory GetBannerAtasModel.fromRawJson(String str) => GetBannerAtasModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GetBannerAtasModel.fromJson(Map<String, dynamic> json) => GetBannerAtasModel(
    hasil: json["hasil"],
    message: json["message"],
    result: Result.fromJson(json["result"]),
  );

  Map<String, dynamic> toJson() => {
    "hasil": hasil,
    "message": message,
    "result": result.toJson(),
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
