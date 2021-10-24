import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_wan_android/app/wan_app.dart';
import 'package:flutter_wan_android/db/wan_data_store.dart';
import 'package:flutter_wan_android/http/core/wan_net_error.dart';
import 'package:flutter_wan_android/http/dao/wx_article_dao.dart';

void main() {
  runApp(WanApp());

  ///沉浸式状态栏
  if (Platform.isAndroid) {
    SystemUiOverlayStyle systemUiOverlayStyle =
        SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }

  void testGetArticle() async {
    try {
      var result = await WxArticleDao.getArticle();
      print(result);
    } on WanNetError catch (e) {
      print(e.errorMsg);
    } catch (e) {
      print(e);
    }
  }

  void testDataStore() {
    WanDataStore.getInstance().setString("key", "12345");
    var value = WanDataStore.getInstance().get("key");
    print(value);
  }
}

/*class WanRouteDelegate extends RouterDelegate<WanRoutePath>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<WanRoutePath> {
  final GlobalKey<NavigatorState> navigatorKey;

  //为navigator设置一个key，必要的时候可以通过navigatorKey.currentState来获取到NavigatorState对象
  WanRouteDelegate() : navigatorKey = GlobalKey<NavigatorState>();
  RouteStatus _routeStatus = RouteStatus.home;
  List<MaterialPage> pages = [];
  VideoModel videoModel;

  @override
  Widget build(BuildContext context) {
    var index = getPageIndex(pages, routeStatus);

    List<MaterialPage> tempPages = pages;
    if (index != -1) {
      //要打开的页面在栈中已存在，则将该页面和它上面的所有页面进行出栈
      //tips 具体规则可以根据需要进行调整，这里要求栈中只允许有一个同样的页面的实例
      tempPages = tempPages.sublist(0, index);
    }
    var page;
    if (routeStatus == RouteStatus.home) {
      //跳转首页时将栈中其他页面进行出栈，因为首页不可回退
      pages.clear();
      page = pageWrap(FirstPage(
        onJumpToDetail: (videoModel) {
          this.videoModel = videoModel;
          notifyListeners();
        },
      ));
    } else {}
    //管理路由栈
    pages = [
      pageWrap(FirstPage(
        onJumpToDetail: (videoModel) {
          this.videoModel = videoModel;
          notifyListeners();
        },
      )),
      if (videoModel != null) pageWrap(SecondPage(videoModel))
    ];
    return Navigator(
      key: navigatorKey,
      pages: pages,
      onPopPage: (route, result) {
        //在这里可以控制是否可以返回
        return route.didPop(result);
      },
    );
  }

  RouteStatus get routeStatus {
    return _routeStatus;
  }

  @override
  Future<void> setNewRoutePath(WanRoutePath path) async {}
}

///可缺省，主要应用于web,持有RouteInformationProvider提供的RouteInformation,可以将其解析为我们定义的数据类型
class WanRouteInformationParser extends RouteInformationParser {
  @override
  Future parseRouteInformation(RouteInformation routeInformation) async {
    final uri = Uri.parse(routeInformation.location);
    print('uri:$uri');
    if (uri.pathSegments.length == 0) {
      return WanRoutePath.home();
    }
    return WanRoutePath.detail();
  }
}

///定义路由数据
class WanRoutePath {
  final String location;

  WanRoutePath.home() : location = "/";

  WanRoutePath.detail() : location = "/detail";
}

///创建页面
pageWrap(Widget child) {
  return MaterialPage(key: ValueKey(child.hashCode), child: child);
}*/
