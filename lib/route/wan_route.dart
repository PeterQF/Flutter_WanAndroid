import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wan_android/model/article_model.dart';
import 'package:flutter_wan_android/model/structure_list_tab_model.dart';
import 'package:flutter_wan_android/route/page_route_anim.dart';
import 'package:flutter_wan_android/ui/page/article_detail_page.dart';
import 'package:flutter_wan_android/ui/page/login_page.dart';
import 'package:flutter_wan_android/ui/page/register_page.dart';
import 'package:flutter_wan_android/ui/page/structure_tab_page.dart';
import 'package:flutter_wan_android/ui/page/root_page.dart';
import 'package:flutter_wan_android/ui/page/splash_page.dart';

class RouteName {
  static const String splash = "splash";
  static const String main = "/";
  static const String login = "login";
  static const String register = "register";
  static const String articleDetail = "articleDetail";
  static const String structureList = "structureList";
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
      case RouteName.structureList:
        var articleTab = settings.arguments as StructureListTab;
        return CupertinoPageRoute(builder: (_) {
          return StructureTabPage(articleTab.categoryInfo, articleTab.index);
        });
      case RouteName.login:
        return MaterialPageRoute(builder: (context) => LoginPage());
      case RouteName.register:
        return MaterialPageRoute(builder: (context) => RegisterPage());
      default:
        return CupertinoPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                    child: Text('No route defined for ${settings.name}'),
                  ),
                ));
    }
  }
}
