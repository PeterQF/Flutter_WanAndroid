import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_wan_android/app/wan_color.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: WanColor.lightBlue,
        //修改状态栏颜色
        systemOverlayStyle: SystemUiOverlayStyle.light,
        title: Text('首页'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            tooltip: "搜索",
            onPressed: () {
              print("Search Pressed");
            },
          )
        ],
      ),
      body: Container(),
    );
  }
}
