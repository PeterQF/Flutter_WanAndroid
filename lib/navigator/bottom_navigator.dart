import 'package:flutter/material.dart';
import 'package:flutter_wan_android/app/wan_color.dart';
import 'package:flutter_wan_android/page/home_page.dart';
import 'package:flutter_wan_android/page/project_page.dart';
import 'package:flutter_wan_android/page/summary_page.dart';
import 'package:flutter_wan_android/page/user_page.dart';

///底部导航
class BottomNavigator extends StatefulWidget {
  @override
  _BottomNavigatorState createState() => _BottomNavigatorState();
}

class _BottomNavigatorState extends State<BottomNavigator> {
  final _defaultColor = WanColor.bottomNavigatorDefault;
  final _selectedColor = WanColor.lightBlue;
  int _currentIndex = 0;
  final PageController _controller = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _controller,
        children: [HomePage(), ProjectPage(), SummaryPage(), UserPage()],
      ),
    );
  }
}
