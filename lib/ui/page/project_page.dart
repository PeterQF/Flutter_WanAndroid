import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_wan_android/app/wan_color.dart';
import 'package:flutter_wan_android/model/project_category_model.dart';
import 'package:flutter_wan_android/provider/provider_widget.dart';
import 'package:flutter_wan_android/provider/view_state_widget.dart';
import 'package:flutter_wan_android/ui/page/article_list_page.dart';
import 'package:flutter_wan_android/ui/widget/custom_indicator.dart'
    as CustomIndicator;
import 'package:flutter_wan_android/ui/widget/custom_tabs.dart' as CustomTabBar;
import 'package:flutter_wan_android/view_model/project_view_model.dart';
import 'package:provider/provider.dart';

class ProjectPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ProjectPageState();
}

class _ProjectPageState extends State<ProjectPage>
    with AutomaticKeepAliveClientMixin {
  ValueNotifier<int> valueNotifier;
  TabController tabController;

  @override
  void initState() {
    valueNotifier = ValueNotifier(0);
    super.initState();
  }

  @override
  void dispose() {
    valueNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return AnnotatedRegion(
      value: SystemUiOverlayStyle.light,
      child: ProviderWidget(
        model: ProjectCategoryViewModel(),
        onModelReady: (model) => model.initData(),
        builder: (context, model, child) {
          if (model.isLoading) {
            return ViewStateLoadingWidget();
          } else if (model.isError || model.list.isEmpty) {
            return ViewStateWidget(onPressed: () => model.initData());
          } else {
            List<ProjectCategoryInfo> categoryList = model.list;
            return ValueListenableProvider<int>.value(
              value: valueNotifier,
              child: DefaultTabController(
                length: model.list.length,
                initialIndex: valueNotifier.value,
                child: Builder(
                  builder: (context) {
                    if (tabController == null) {
                      tabController = DefaultTabController.of(context);
                      tabController.addListener(() {
                        valueNotifier.value = tabController.index;
                      });
                    }
                    return Scaffold(
                      appBar: AppBar(
                        systemOverlayStyle: SystemUiOverlayStyle.light,
                        backgroundColor: WanColor.lightBlue,
                        title: Container(
                          child: _buildTabBar(context, categoryList),
                        ),
                      ),
                      body: TabBarView(
                        children: List.generate(categoryList.length,
                            (index) => ArticleListPage(categoryList[index].id)),
                      ),
                    );
                  },
                ),
              ),
            );
          }
        },
      ),
    );
  }

  Widget _buildTabBar(
      BuildContext context, List<ProjectCategoryInfo> categoryList) {
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
          categoryList.length,
          (index) => Tab(
                text: categoryList[index].name,
              )),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
