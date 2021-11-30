import 'dart:convert';

class ArticleResponse {
  ArticleResponse({
    this.data,
    this.errorCode,
    this.errorMsg,
  });

  final ArticleData data;
  final int errorCode;
  final String errorMsg;

  factory ArticleResponse.fromJson(String str) => ArticleResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ArticleResponse.fromMap(Map<String, dynamic> json) => ArticleResponse(
    data: ArticleData.fromMap(json["data"]),
    errorCode: json["errorCode"],
    errorMsg: json["errorMsg"],
  );

  Map<String, dynamic> toMap() => {
    "data": data.toMap(),
    "errorCode": errorCode,
    "errorMsg": errorMsg,
  };
}

class ArticleData {
  ArticleData({
    this.curPage,
    this.datas,
    this.offset,
    this.over,
    this.pageCount,
    this.size,
    this.total,
  });

  final int curPage;
  final List<ArticleInfo> datas;
  final int offset;
  final bool over;
  final int pageCount;
  final int size;
  final int total;

  factory ArticleData.fromJson(String str) => ArticleData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ArticleData.fromMap(Map<String, dynamic> json) => ArticleData(
    curPage: json["curPage"],
    datas: List<ArticleInfo>.from(json["datas"].map((x) => ArticleInfo.fromMap(x))),
    offset: json["offset"],
    over: json["over"],
    pageCount: json["pageCount"],
    size: json["size"],
    total: json["total"],
  );

  Map<String, dynamic> toMap() => {
    "curPage": curPage,
    "datas": List<dynamic>.from(datas.map((x) => x.toMap())),
    "offset": offset,
    "over": over,
    "pageCount": pageCount,
    "size": size,
    "total": total,
  };
}

class ArticleInfo {
  ArticleInfo({
    this.alreadyInHomePage,
    this.apkLink,
    this.audit,
    this.author,
    this.canEdit,
    this.chapterId,
    this.chapterName,
    this.collect,
    this.courseId,
    this.desc,
    this.descMd,
    this.envelopePic,
    this.fresh,
    this.host,
    this.id,
    this.link,
    this.niceDate,
    this.niceShareDate,
    this.origin,
    this.prefix,
    this.projectLink,
    this.publishTime,
    this.realSuperChapterId,
    this.selfVisible,
    this.shareDate,
    this.shareUser,
    this.superChapterId,
    this.superChapterName,
    this.tags,
    this.title,
    this.type,
    this.userId,
    this.visible,
    this.zan,
  });

  final bool alreadyInHomePage;
  final String apkLink;
  final int audit;
  final String author;
  final bool canEdit;
  final int chapterId;
  final String chapterName;
  final bool collect;
  final int courseId;
  final String desc;
  final String descMd;
  final String envelopePic;
  final bool fresh;
  final String host;
  final int id;
  final String link;
  final String niceDate;
  final String niceShareDate;
  final String origin;
  final String prefix;
  final String projectLink;
  final int publishTime;
  final int realSuperChapterId;
  final int selfVisible;
  final int shareDate;
  final String shareUser;
  final int superChapterId;
  final String superChapterName;
  final List<Tag> tags;
  final String title;
  final int type;
  final int userId;
  final int visible;
  final int zan;

  factory ArticleInfo.fromJson(String str) => ArticleInfo.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ArticleInfo.fromMap(Map<String, dynamic> json) => ArticleInfo(
    alreadyInHomePage: json["alreadyInHomePage"],
    apkLink: json["apkLink"],
    audit: json["audit"],
    author: json["author"],
    canEdit: json["canEdit"],
    chapterId: json["chapterId"],
    chapterName: json["chapterName"],
    collect: json["collect"],
    courseId: json["courseId"],
    desc: json["desc"],
    descMd: json["descMd"],
    envelopePic: json["envelopePic"],
    fresh: json["fresh"],
    host: json["host"],
    id: json["id"],
    link: json["link"],
    niceDate: json["niceDate"],
    niceShareDate: json["niceShareDate"],
    origin: json["origin"],
    prefix: json["prefix"],
    projectLink: json["projectLink"],
    publishTime: json["publishTime"],
    realSuperChapterId: json["realSuperChapterId"],
    selfVisible: json["selfVisible"],
    shareDate: json["shareDate"],
    shareUser: json["shareUser"],
    superChapterId: json["superChapterId"],
    superChapterName: json["superChapterName"],
    tags: List<Tag>.from(json["tags"].map((x) => Tag.fromMap(x))),
    title: json["title"],
    type: json["type"],
    userId: json["userId"],
    visible: json["visible"],
    zan: json["zan"],
  );

  Map<String, dynamic> toMap() => {
    "alreadyInHomePage": alreadyInHomePage,
    "apkLink": apkLink,
    "audit": audit,
    "author": author,
    "canEdit": canEdit,
    "chapterId": chapterId,
    "chapterName": chapterName,
    "collect": collect,
    "courseId": courseId,
    "desc": desc,
    "descMd": descMd,
    "envelopePic": envelopePic,
    "fresh": fresh,
    "host": host,
    "id": id,
    "link": link,
    "niceDate": niceDate,
    "niceShareDate": niceShareDate,
    "origin": origin,
    "prefix": prefix,
    "projectLink": projectLink,
    "publishTime": publishTime,
    "realSuperChapterId": realSuperChapterId,
    "selfVisible": selfVisible,
    "shareDate": shareDate,
    "shareUser": shareUser,
    "superChapterId": superChapterId,
    "superChapterName": superChapterName,
    "tags": List<dynamic>.from(tags.map((x) => x.toMap())),
    "title": title,
    "type": type,
    "userId": userId,
    "visible": visible,
    "zan": zan,
  };
}

class Tag {
  Tag({
    this.name,
    this.url,
  });

  final String name;
  final String url;

  factory Tag.fromJson(String str) => Tag.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Tag.fromMap(Map<String, dynamic> json) => Tag(
    name: json["name"],
    url: json["url"],
  );

  Map<String, dynamic> toMap() => {
    "name": name,
    "url": url,
  };
}
