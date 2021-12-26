import 'package:flutter_wan_android/model/article_model.dart';

class NavigationSite {
  List<ArticleInfo> articles;
  int cid;
  String name;

  static NavigationSite fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    NavigationSite naviBean = NavigationSite();
    naviBean.articles = []..addAll((map['articles'] as List ?? []).map((o) => ArticleInfo.fromMap(o)));
    naviBean.cid = map['cid'];
    naviBean.name = map['name'];
    return naviBean;
  }

  Map toJson() => {
    "articles": articles,
    "cid": cid,
    "name": name,
  };
}