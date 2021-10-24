import 'package:flutter/material.dart';
import 'package:flutter_wan_android/app/wan_color.dart';
import 'package:flutter_wan_android/db/wan_data_store.dart';
import 'package:flutter_wan_android/page/home_page.dart';
import 'package:flutter_wan_android/page/project_page.dart';
import 'package:flutter_wan_android/page/summary_page.dart';
import 'package:flutter_wan_android/page/user_page.dart';
import 'package:flutter_wan_android/widget/double_tap_back_exit_app.dart';

class RootPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  int _tabIndex = 0;
  static const double _imageSize = 26.0;

  List<Image> _tabNormalImages = [
    Image.asset(
      'img/tab_home_normal.png',
      width: _imageSize,
      height: _imageSize,
    ),
    Image.asset('img/tab_project_normal.png',
        width: _imageSize,
        height: _imageSize,
        excludeFromSemantics: true,
        gaplessPlayback: true),
    Image.asset('img/tab_summary_normal.png',
        width: _imageSize,
        height: _imageSize,
        excludeFromSemantics: true,
        gaplessPlayback: true),
    Image.asset('img/tab_user_normal.png',
        width: _imageSize,
        height: _imageSize,
        excludeFromSemantics: true,
        gaplessPlayback: true)
  ];
  List<Image> _tabSelectedImages = [
    Image.asset('img/tab_home_selected.png',
        width: _imageSize,
        height: _imageSize,
        excludeFromSemantics: true,
        gaplessPlayback: true),
    Image.asset('img/tab_project_selected.png',
        width: _imageSize,
        height: _imageSize,
        excludeFromSemantics: true,
        gaplessPlayback: true),
    Image.asset('img/tab_summary_selected.png',
        width: _imageSize,
        height: _imageSize,
        excludeFromSemantics: true,
        gaplessPlayback: true),
    Image.asset('img/tab_user_selected.png',
        width: _imageSize,
        height: _imageSize,
        excludeFromSemantics: true,
        gaplessPlayback: true)
  ];

  @override
  void initState() {
    super.initState();
    setupApp();
  }

  @override
  Widget build(BuildContext context) {
    return DoubleTapBackExitApp(
      key: Key("1001"),
      child: Scaffold(
        body: IndexedStack(
          children: [HomePage(), ProjectPage(), SummaryPage(), UserPage()],
          index: _tabIndex,
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          selectedFontSize: 12.0,
          unselectedFontSize: 12.0,
          selectedItemColor: WanColor.lightBlue,
          unselectedItemColor: WanColor.bottomNavigatorDefault,
          //设置文字高度，相当于设置图标与文字之间的间隔
          unselectedLabelStyle: TextStyle(height: 1.5),
          selectedLabelStyle: TextStyle(height: 1.5),
          items: [
            BottomNavigationBarItem(icon: getTabIcon(0), label: '首页'),
            BottomNavigationBarItem(icon: getTabIcon(1), label: '项目'),
            BottomNavigationBarItem(icon: getTabIcon(2), label: '体系'),
            BottomNavigationBarItem(icon: getTabIcon(3), label: '我的')
          ],
          currentIndex: _tabIndex,
          onTap: (index) {
            if (mounted) {
              setState(() {
                _tabIndex = index;
              });
            }
          },
        ),
      ),
    );
  }

  Image getTabIcon(int index) {
    if (index == _tabIndex) {
      return _tabSelectedImages[index];
    } else {
      return _tabNormalImages[index];
    }
  }

  void setupApp() async {
    WanDataStore.preInit();
  }
}
