import 'package:flutter/material.dart';
import 'package:flutter_wan_android/app/wan_color.dart';
import 'package:flutter_wan_android/page/root_page.dart';

class WanApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '玩安卓',
      //debug版去掉右上角的debug标签
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primaryColor: Colors.white,
          dividerColor: Color(0xffeeeeee),
          scaffoldBackgroundColor: WanColor.paper),
      home: RootPage()
    );
  }
}