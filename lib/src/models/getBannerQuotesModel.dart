// To parse this JSON data, do
//
//     final getBannerQuoteModel = getBannerQuoteModelFromJson(jsonString);

import 'dart:convert';

class GetBannerQuoteModel {
  GetBannerQuoteModel({
    this.hasil,
    this.message,
    this.result,
  });

  bool hasil;
  String message;
  List<Result> result;

  factory GetBannerQuoteModel.fromRawJson(String str) => GetBannerQuoteModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GetBannerQuoteModel.fromJson(Map<String, dynamic> json) => GetBannerQuoteModel(
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
    this.kode,
    this.link,
  });

  String image;
  String kode;
  String link;

  factory Result.fromRawJson(String str) => Result.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    image: json["image"],
    kode: json["kode"],
    link: json["link"],
  );

  Map<String, dynamic> toJson() => {
    "image": image,
    "kode": kode,
    "link": link,
  };
}
