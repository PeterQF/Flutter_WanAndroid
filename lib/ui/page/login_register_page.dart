import 'package:flutter/material.dart';
import 'package:flutter_wan_android/app/wan_color.dart';
import 'package:flutter_wan_android/ui/page/login_page.dart';
import 'package:flutter_wan_android/ui/widget/tab_bar_widget.dart';

class LoginRegisterPage extends StatefulWidget {
  const LoginRegisterPage({Key key}) : super(key: key);

  @override
  _LoginRegisterPageState createState() => _LoginRegisterPageState();
}

class _LoginRegisterPageState extends State<LoginRegisterPage>
    with AutomaticKeepAliveClientMixin {
  List<String> tabs = ['登录', '注册'];

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        backgroundColor: WanColor.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: WanColor.white,
          title: TabBarWidget(
            tabs,
            selectedFontSize: 20,
            unSelectedFontSize: 16,
            selectedColor: WanColor.lightBlue,
            unSelectedColor: WanColor.color707070,
            indicatorColor: WanColor.lightBlue,
          ),
        ),
        body: TabBarView(
          children: [LoginPage(), Container()],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
