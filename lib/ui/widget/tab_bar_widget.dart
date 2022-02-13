import 'package:flutter/material.dart';
import 'package:flutter_wan_android/app/wan_color.dart';
import 'package:flutter_wan_android/ui/widget/custom_indicator.dart'
    as CustomIndicator;
import 'package:flutter_wan_android/ui/widget/custom_tabs.dart' as CustomTabBar;

class TabBarWidget extends StatelessWidget {
  final List<String> tabTitles;
  final double selectedFontSize;
  final double unSelectedFontSize;
  final Color selectedColor;
  final Color unSelectedColor;
  final Color indicatorColor;

  const TabBarWidget(this.tabTitles,
      {Key key,
      this.selectedFontSize = 16,
      this.unSelectedFontSize = 14,
      this.selectedColor = WanColor.white,
      this.unSelectedColor = WanColor.lightGray,
      this.indicatorColor = WanColor.white})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomTabBar.TabBar(
      onTap: (index) {},
      labelPadding: EdgeInsets.fromLTRB(12, 0, 12, 0),
      labelStyle: TextStyle(
        color: unSelectedColor,
        fontSize: selectedFontSize == 0 ? 16 : selectedFontSize,
        fontWeight: FontWeight.bold,
      ),
      labelColor: selectedColor,
      unselectedLabelColor: unSelectedColor,
      unselectedLabelStyle: TextStyle(
        fontSize: unSelectedFontSize == 0 ? 14 : unSelectedFontSize,
      ),
      indicatorSize: CustomTabBar.TabBarIndicatorSize.label,
      indicatorPadding: EdgeInsets.fromLTRB(8, 6, 8, 0),
      indicatorWeight: 2.2,
      indicator: CustomIndicator.UnderlineTabIndicator(
          hPadding: 10,
          borderSide: BorderSide(
            width: 2,
            color: indicatorColor,
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
}
