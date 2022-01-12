import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wan_android/model/article_model.dart';
import 'package:flutter_wan_android/route/page_route_anim.dart';
import 'package:flutter_wan_android/ui/page/article_detail_page.dart';
import 'package:flutter_wan_android/ui/page/root_page.dart';
import 'package:flutter_wan_android/ui/page/splash_page.dart';

class RouteName {
  static const String splash = "splash";
  static const String main = "/";
  static const String login = "login";
  static const String register = "register";
  static const String articleDetail = "articleDetail";
}

class WanRoute {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteName.splash:
        return NoAnimRouteBuilder(SplashPage());
      case RouteName.main:
        return NoAnimRouteBuilder(RootPage());
      case RouteName.articleDetail:
        var article = settings.arguments as ArticleInfo;
        return CupertinoPageRoute(builder: (_) {
          return ArticleDetailPage(article);
        });
    }
  }
}
