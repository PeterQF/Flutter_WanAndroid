import 'package:flutter/material.dart';
import 'package:flutter_wan_android/app/wan_color.dart';
import 'package:flutter_wan_android/ui/widget/custom_indicator.dart'
    as CustomIndicator;
import 'package:flutter_wan_android/ui/widget/custom_tabs.dart' as CustomTabBar;

Widget buildTabBar(BuildContext context, List<String> tabTitles) {
  return CustomTabBar.TabBar(
    onTap: (index) {},
    labelPadding: EdgeInsets.fromLTRB(12, 0, 12, 0),
    labelStyle: TextStyle(
      color: WanColor.color707070,
      fontSize: 16,
      fontWeight: FontWeight.bold,
    ),
    labelColor: WanColor.white,
    unselectedLabelColor: WanColor.lightGray,
    unselectedLabelStyle: TextStyle(
      fontSize: 14,
    ),
    indicatorSize: CustomTabBar.TabBarIndicatorSize.label,
    indicatorPadding: EdgeInsets.fromLTRB(8, 6, 8, 0),
    indicatorWeight: 2.2,
    indicator: CustomIndicator.UnderlineTabIndicator(
        hPadding: 10,
        borderSide: BorderSide(
          width: 2,
          color: WanColor.white,
        ),
        insets: EdgeInsets.zero),
    isScrollable: true,
    tabs: List.generate(
        tabTitles.length,
        (index) => Tab(
              text: tabTitles[index],
            )),
  );
}
