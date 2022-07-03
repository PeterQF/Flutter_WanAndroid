// To parse this JSON data, do
//
//     final userInfo = userInfoFromJson(jsonString);

import 'dart:convert';

UserInfo userInfoFromJson(String str) => UserInfo.fromJson(json.decode(str));

String userInfoToJson(UserInfo data) => json.encode(data.toJson());

class UserInfo {
  UserInfo({
    this.data,
    this.errorCode,
    this.errorMsg,
  });

  UserInfoData data;
  int errorCode;
  String errorMsg;

  factory UserInfo.fromJson(Map<String, dynamic> json) => UserInfo(
    data: UserInfoData.fromJson(json["data"]),
    errorCode: json["errorCode"],
    errorMsg: json["errorMsg"],
  );

  Map<String, dynamic> toJson() => {
    "data": data.toJson(),
    "errorCode": errorCode,
    "errorMsg": errorMsg,
  };
}

class UserInfoData {
  UserInfoData({
    this.coinInfo,
    this.userInfo,
  });

  CoinInfo coinInfo;
  UserInfoClass userInfo;

  factory UserInfoData.fromJson(Map<String, dynamic> json) => UserInfoData(
    coinInfo: CoinInfo.fromJson(json["coinInfo"]),
    userInfo: UserInfoClass.fromJson(json["userInfo"]),
  );

  Map<String, dynamic> toJson() => {
    "coinInfo": coinInfo.toJson(),
    "userInfo": userInfo.toJson(),
  };
}

class CoinInfo {
  CoinInfo({
    this.coinCount,
    this.level,
    this.nickname,
    this.rank,
    this.userId,
    this.username,
  });

  int coinCount;
  int level;
  String nickname;
  String rank;
  int userId;
  String username;

  factory CoinInfo.fromJson(Map<String, dynamic> json) => CoinInfo(
    coinCount: json["coinCount"],
    level: json["level"],
    nickname: json["nickname"],
    rank: json["rank"],
    userId: json["userId"],
    username: json["username"],
  );

  Map<String, dynamic> toJson() => {
    "coinCount": coinCount,
    "level": level,
    "nickname": nickname,
    "rank": rank,
    "userId": userId,
    "username": username,
  };
}

class UserInfoClass {
  UserInfoClass({
    this.admin,
    this.chapterTops,
    this.coinCount,
    this.collectIds,
    this.email,
    this.icon,
    this.id,
    this.nickname,
    this.password,
    this.publicName,
    this.token,
    this.type,
    this.username,
  });

  bool admin;
  List<dynamic> chapterTops;
  int coinCount;
  List<int> collectIds;
  String email;
  String icon;
  int id;
  String nickname;
  String password;
  String publicName;
  String token;
  int type;
  String username;

  factory UserInfoClass.fromJson(Map<String, dynamic> json) => UserInfoClass(
    admin: json["admin"],
    chapterTops: List<dynamic>.from(json["chapterTops"].map((x) => x)),
    coinCount: json["coinCount"],
    collectIds: List<int>.from(json["collectIds"].map((x) => x)),
    email: json["email"],
    icon: json["icon"],
    id: json["id"],
    nickname: json["nickname"],
    password: json["password"],
    publicName: json["publicName"],
    token: json["token"],
    type: json["type"],
    username: json["username"],
  );

  Map<String, dynamic> toJson() => {
    "admin": admin,
    "chapterTops": List<dynamic>.from(chapterTops.map((x) => x)),
    "coinCount": coinCount,
    "collectIds": List<dynamic>.from(collectIds.map((x) => x)),
    "email": email,
    "icon": icon,
    "id": id,
    "nickname": nickname,
    "password": password,
    "publicName": publicName,
    "token": token,
    "type": type,
    "username": username,
  };
}
