import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_wan_android/app/wan_color.dart';
import 'package:flutter_wan_android/model/structure_list_tab_model.dart';
import 'package:flutter_wan_android/model/category_model.dart';
import 'package:flutter_wan_android/model/navigation_site_model.dart';
import 'package:flutter_wan_android/provider/provider_widget.dart';
import 'package:flutter_wan_android/provider/view_state_widget.dart';
import 'package:flutter_wan_android/route/wan_route.dart';
import 'package:flutter_wan_android/ui/widget/tab_bar_widget.dart';
import 'package:flutter_wan_android/view_model/summary_view_model.dart';

class SummaryPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SummaryPageState();
}

class _SummaryPageState extends State<SummaryPage>
    with AutomaticKeepAliveClientMixin {
  List<String> tabs = ['体系', '导航'];

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        appBar: AppBar(
          systemOverlayStyle: SystemUiOverlayStyle.light,
          backgroundColor: WanColor.lightBlue,
          centerTitle: true,
          title: buildTabBar(context, tabs),
        ),
        body: TabBarView(
          children: [StructureCategoryList(), NavigationCategoryList()],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class StructureCategoryList extends StatefulWidget {
  @override
  _StructureCategoryListState createState() => _StructureCategoryListState();
}

class _StructureCategoryListState extends State<StructureCategoryList>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ProviderWidget(
      model: StructureViewModel(),
      onModelReady: (model) {
        model.initData();
      },
      builder: (context, model, child) {
        if (model.isLoading) {
          return ViewStateLoadingWidget();
        } else if (model.isError || model.list.isEmpty) {
          return ViewStateWidget(onPressed: () => model.initData());
        } else {
          return Scrollbar(
            child: ListView.builder(
                padding: EdgeInsets.all(15),
                itemCount: model.list.length,
                itemBuilder: (context, index) {
                  CategoryInfo item = model.list[index];
                  return StructureCategoryWidget(item);
                }),
          );
        }
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class StructureCategoryWidget extends StatelessWidget {
  final CategoryInfo categoryInfo;

  const StructureCategoryWidget(this.categoryInfo, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            categoryInfo.name,
            style: TextStyle(
                fontSize: 16,
                color: WanColor.color1A1A1A,
                fontWeight: FontWeight.bold),
          ),
          Wrap(
            spacing: 14,
            children: List.generate(
                categoryInfo.children.length,
                (index) => ActionChip(
                      label: Text(
                        categoryInfo.children[index].name,
                        maxLines: 1,
                        style: TextStyle(color: WanColor.color707070),
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, RouteName.structureList,
                            arguments: StructureListTab(categoryInfo, index));
                      },
                    )),
          )
        ],
      ),
    );
  }
}

class NavigationCategoryList extends StatefulWidget {
  const NavigationCategoryList({Key key}) : super(key: key);

  @override
  _NavigationCategoryListState createState() => _NavigationCategoryListState();
}

class _NavigationCategoryListState extends State<NavigationCategoryList>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ProviderWidget(
      model: NavigationViewModel(),
      onModelReady: (model) => model.initData(),
      builder: (context, model, child) {
        if (model.isLoading) {
          return ViewStateLoadingWidget();
        } else if (model.isError || model.list.isEmpty) {
          return ViewStateWidget(onPressed: () => model.initData());
        } else {
          return Scrollbar(
            child: ListView.builder(
                padding: EdgeInsets.all(15),
                itemCount: model.list.length,
                itemBuilder: (context, index) {
                  NavigationSite item = model.list[index];
                  return NavigationCategoryWidget(item);
                }),
          );
        }
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class NavigationCategoryWidget extends StatelessWidget {
  final NavigationSite navigationSite;

  const NavigationCategoryWidget(this.navigationSite, {Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            navigationSite.name,
            style: TextStyle(
                fontSize: 16,
                color: WanColor.color1A1A1A,
                fontWeight: FontWeight.bold),
          ),
          Wrap(
            spacing: 14,
            children: List.generate(
                navigationSite.articles.length,
                (index) => ActionChip(
                      label: Text(
                        navigationSite.articles[index].title,
                        maxLines: 1,
                        style: TextStyle(color: WanColor.color707070),
                      ),
                      onPressed: () {
                        Navigator.of(context).pushNamed(
                            RouteName.articleDetail,
                            arguments: navigationSite.articles[index]);
                      },
                    )),
          )
        ],
      ),
    );
  }
}
