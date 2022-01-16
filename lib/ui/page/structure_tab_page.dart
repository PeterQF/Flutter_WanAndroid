import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_wan_android/app/wan_color.dart';
import 'package:flutter_wan_android/model/category_model.dart';
import 'package:flutter_wan_android/ui/page/structure_article_list_page.dart';

class StructureTabPage extends StatelessWidget {
  final CategoryInfo categoryInfo;
  final int index;

  const StructureTabPage(this.categoryInfo, this.index, {Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: categoryInfo.children.length,
      initialIndex: index,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            categoryInfo.name,
            style: TextStyle(fontSize: 20, color: WanColor.white),
          ),
          centerTitle: true,
          backgroundColor: WanColor.lightBlue,
          systemOverlayStyle: SystemUiOverlayStyle.light,
          bottom: TabBar(
              isScrollable: true,
              indicatorColor: WanColor.white,
              labelColor: WanColor.white,
              unselectedLabelColor: WanColor.white,
              indicatorSize: TabBarIndicatorSize.label,
              labelStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              unselectedLabelStyle: TextStyle(fontSize: 14),
              tabs: List.generate(
                  categoryInfo.children.length,
                  (index) => Tab(
                        text: categoryInfo.children[index].name,
                      ))),
        ),
        body: TabBarView(
          children: List.generate(
              categoryInfo.children.length,
              (index) =>
                  StructureArticleListPage(categoryInfo.children[index].id)),
        ),
      ),
    );
  }
}
