import 'package:flutter/material.dart';
import 'package:flutter_wan_android/model/article_model.dart';
import 'package:flutter_wan_android/provider/provider_widget.dart';
import 'package:flutter_wan_android/provider/view_state_widget.dart';
import 'package:flutter_wan_android/ui/widget/project_article_item_widget.dart';
import 'package:flutter_wan_android/view_model/project_view_model.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

/// 文章列表页面
class ArticleListPage extends StatefulWidget {
  /// 目录id
  final int id;

  const ArticleListPage(this.id, {Key key}) : super(key: key);

  @override
  _ArticleListPageState createState() => _ArticleListPageState();
}

/// AutomaticKeepAliveClientMixin
/// Flutter切换tab后保留tab状态 概述 Flutter中为了节约内存不会保存widget的状态,widget都是临时变量。当我们使用TabBar,TabBarView是我们就会发现,切换tab，initState又会被调用一次。
/// 怎么为了让tab一直保存在内存中，不被销毁？
/// 添加AutomaticKeepAliveClientMixin，并实现对应的方法bool get wantKeepAlive => true;，同时build方法实现父方法 super.build(context);

class _ArticleListPageState extends State<ArticleListPage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ProviderWidget(
      model: ProjectListViewModel(widget.id),
      onModelReady: (model) => model.initData(),
      builder: (context, model, child) {
        if (model.isLoading) {
          return ViewStateLoadingWidget();
        } else if (model.isError || model.list.isEmpty) {
          return ViewStateWidget(onPressed: () => model.initData());
        } else {
          return SmartRefresher(
            controller: model.refreshController,
            header: MaterialClassicHeader(),
            footer: ClassicFooter(
              loadingText: "加载中",
            ),
            onRefresh: model.refresh,
            onLoading: model.loadMore,
            enablePullDown: true,
            enablePullUp: true,
            child: ListView.builder(
                itemCount: model.list.length,
                itemBuilder: (context, index) {
                  ArticleInfo item = model.list[index];
                  return ProjectArticleItemWidget(item);
                }),
          );
        }
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
