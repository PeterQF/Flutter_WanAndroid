import 'package:flutter/material.dart';
import 'package:flutter_wan_android/app/app_resource.dart';
import 'package:flutter_wan_android/app/wan_color.dart';
import 'package:flutter_wan_android/ui/page/project_page.dart';
import 'package:flutter_wan_android/ui/page/summary_page.dart';
import 'package:flutter_wan_android/ui/page/user_page.dart';
import 'package:flutter_wan_android/ui/widget/double_tap_back_exit_app.dart';

import 'home_page.dart';

class RootPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  static const double _imageSize = 26.0;
  var _pageController = PageController();
  int _selectedIndex = 0;

  List<Image> _tabNormalImages = [
    Image.asset(
      ImageHelper.loadAssets('img/tab_home_normal.png'),
      width: _imageSize,
      height: _imageSize,
    ),
    Image.asset(ImageHelper.loadAssets('img/tab_project_normal.png'),
        width: _imageSize,
        height: _imageSize,
        excludeFromSemantics: true,
        gaplessPlayback: true),
    Image.asset(ImageHelper.loadAssets('img/tab_summary_normal.png'),
        width: _imageSize,
        height: _imageSize,
        excludeFromSemantics: true,
        gaplessPlayback: true),
    Image.asset(ImageHelper.loadAssets('img/tab_user_normal.png'),
        width: _imageSize,
        height: _imageSize,
        excludeFromSemantics: true,
        gaplessPlayback: true)
  ];
  List<Image> _tabSelectedImages = [
    Image.asset(ImageHelper.loadAssets('img/tab_home_selected.png'),
        width: _imageSize,
        height: _imageSize,
        excludeFromSemantics: true,
        gaplessPlayback: true),
    Image.asset(ImageHelper.loadAssets('img/tab_project_selected.png'),
        width: _imageSize,
        height: _imageSize,
        excludeFromSemantics: true,
        gaplessPlayback: true),
    Image.asset(ImageHelper.loadAssets('img/tab_summary_selected.png'),
        width: _imageSize,
        height: _imageSize,
        excludeFromSemantics: true,
        gaplessPlayback: true),
    Image.asset(ImageHelper.loadAssets('img/tab_user_selected.png'),
        width: _imageSize,
        height: _imageSize,
        excludeFromSemantics: true,
        gaplessPlayback: true)
  ];

  @override
  Widget build(BuildContext context) {
    return DoubleTapBackExitApp(
      child: Scaffold(
        body: PageView.builder(
          itemBuilder: (ctx, index) => pages[index],
          itemCount: pages.length,
          controller: _pageController,
          physics: NeverScrollableScrollPhysics(),
          onPageChanged: (index) {
            if (mounted) {
              setState(() {
                _selectedIndex = index;
              });
            }
          },
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
          currentIndex: _selectedIndex,
          onTap: (index) {
            _pageController.jumpToPage(index);
          },
        ),
      ),
    );
  }

  Image getTabIcon(int index) {
    if (index == _selectedIndex) {
      return _tabSelectedImages[index];
    } else {
      return _tabNormalImages[index];
    }
  }

  List<Widget> pages = <Widget>[
    HomePage(),
    ProjectPage(),
    SummaryPage(),
    UserPage()
  ];
}
