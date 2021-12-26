// To parse this JSON data, do
//
//     final bannerResponse = bannerResponseFromMap(jsonString);

import 'dart:convert';

class BannerResponse {
  BannerResponse({
    this.data,
    this.errorCode,
    this.errorMsg,
  });

  final List<BannerInfo> data;
  final int errorCode;
  final String errorMsg;

  factory BannerResponse.fromJson(String str) => BannerResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory BannerResponse.fromMap(Map<String, dynamic> json) => BannerResponse(
    data: List<BannerInfo>.from(json["data"].map((x) => BannerInfo.fromMap(x))),
    errorCode: json["errorCode"],
    errorMsg: json["errorMsg"],
  );

  Map<String, dynamic> toMap() => {
    "data": List<dynamic>.from(data.map((x) => x.toMap())),
    "errorCode": errorCode,
    "errorMsg": errorMsg,
  };
}

class BannerInfo {
  BannerInfo({
    this.desc,
    this.id,
    this.imagePath,
    this.isVisible,
    this.order,
    this.title,
    this.type,
    this.url,
  });

  final String desc;
  final int id;
  final String imagePath;
  final int isVisible;
  final int order;
  final String title;
  final int type;
  final String url;

  factory BannerInfo.fromJson(String str) => BannerInfo.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory BannerInfo.fromMap(Map<String, dynamic> json) => BannerInfo(
    desc: json["desc"],
    id: json["id"],
    imagePath: json["imagePath"],
    isVisible: json["isVisible"],
    order: json["order"],
    title: json["title"],
    type: json["type"],
    url: json["url"],
  );

  Map<String, dynamic> toMap() => {
    "desc": desc,
    "id": id,
    "imagePath": imagePath,
    "isVisible": isVisible,
    "order": order,
    "title": title,
    "type": type,
    "url": url,
  };
}
