// To parse this JSON data, do
//
//     final user = userFromMap(jsonString);

import 'dart:convert';

class User {
  User({
    this.data,
    this.errorCode,
    this.errorMsg,
  });

  final UserData data;
  final int errorCode;
  final String errorMsg;

  factory User.fromJson(String str) => User.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory User.fromMap(Map<String, dynamic> json) => User(
    data: UserData.fromMap(json["data"]),
    errorCode: json["errorCode"],
    errorMsg: json["errorMsg"],
  );

  Map<String, dynamic> toMap() => {
    "data": data.toMap(),
    "errorCode": errorCode,
    "errorMsg": errorMsg,
  };
}

class UserData {
  UserData({
    this.coinInfo,
    this.userInfo,
  });

  final CoinInfo coinInfo;
  final UserInfo userInfo;

  factory UserData.fromJson(String str) => UserData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UserData.fromMap(Map<String, dynamic> json) => UserData(
    coinInfo: CoinInfo.fromMap(json["coinInfo"]),
    userInfo: UserInfo.fromMap(json["userInfo"]),
  );

  Map<String, dynamic> toMap() => {
    "coinInfo": coinInfo.toMap(),
    "userInfo": userInfo.toMap(),
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

  final int coinCount;
  final int level;
  final String nickname;
  final String rank;
  final int userId;
  final String username;

  factory CoinInfo.fromJson(String str) => CoinInfo.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CoinInfo.fromMap(Map<String, dynamic> json) => CoinInfo(
    coinCount: json["coinCount"],
    level: json["level"],
    nickname: json["nickname"],
    rank: json["rank"],
    userId: json["userId"],
    username: json["username"],
  );

  Map<String, dynamic> toMap() => {
    "coinCount": coinCount,
    "level": level,
    "nickname": nickname,
    "rank": rank,
    "userId": userId,
    "username": username,
  };
}

class UserInfo {
  UserInfo({
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

  final bool admin;
  final List<dynamic> chapterTops;
  final int coinCount;
  final List<int> collectIds;
  final String email;
  final String icon;
  final int id;
  final String nickname;
  final String password;
  final String publicName;
  final String token;
  final int type;
  final String username;

  factory UserInfo.fromJson(String str) => UserInfo.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UserInfo.fromMap(Map<String, dynamic> json) => UserInfo(
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

  Map<String, dynamic> toMap() => {
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
