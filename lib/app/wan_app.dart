import 'package:flutter/material.dart';
import 'package:flutter_wan_android/app/scroll_behavior.dart';
import 'package:flutter_wan_android/app/wan_color.dart';
import 'package:flutter_wan_android/provider/provider_manager.dart';
import 'package:flutter_wan_android/route/wan_route.dart';
import 'package:provider/provider.dart';

class WanApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: providers,
      child: MaterialApp(
        title: '玩安卓',
        //debug版去掉右上角的debug标签
        debugShowCheckedModeBanner: false,
        // 滚动控件去除默认阴影
        scrollBehavior: MyBehavior(),
        theme: ThemeData(
            primaryColor: WanColor.lightBlue,
            dividerColor: Color(0xffeeeeee),
            brightness: Brightness.light,
            scaffoldBackgroundColor: WanColor.paper,
            textSelectionTheme:
            TextSelectionThemeData(cursorColor: WanColor.lightBlue)),
        onGenerateRoute: WanRoute.generateRoute,
        initialRoute: RouteName.splash,
      ),
    );
  }
}
