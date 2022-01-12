import 'package:flutter/material.dart';
import 'package:flutter_wan_android/app/scroll_behavior.dart';
import 'package:flutter_wan_android/app/wan_color.dart';
import 'package:flutter_wan_android/route/wan_route.dart';
import 'package:flutter_wan_android/ui/page/root_page.dart';

class WanApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '玩安卓',
      //debug版去掉右上角的debug标签
      debugShowCheckedModeBanner: false,
      // 滚动控件去除默认阴影
      scrollBehavior: MyBehavior(),
      theme: ThemeData(
          primaryColor: WanColor.lightBlue,
          dividerColor: Color(0xffeeeeee),
          brightness: Brightness.light,
          scaffoldBackgroundColor: WanColor.paper),
      onGenerateRoute: WanRoute.generateRoute,
      initialRoute: RouteName.splash,
    );
  }
}