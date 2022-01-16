import 'package:flutter/material.dart';
import 'package:flutter_wan_android/model/article_model.dart';
import 'package:flutter_wan_android/provider/provider_widget.dart';
import 'package:flutter_wan_android/provider/view_state_widget.dart';
import 'package:flutter_wan_android/ui/widget/article_item_widget.dart';
import 'package:flutter_wan_android/view_model/summary_view_model.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class StructureArticleListPage extends StatefulWidget {
  final int id;

  const StructureArticleListPage(this.id, {Key key}) : super(key: key);

  @override
  _StructureArticleListPageState createState() => _StructureArticleListPageState();
}

class _StructureArticleListPageState extends State<StructureArticleListPage> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ProviderWidget(
      model: StructureListViewModel(widget.id),
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
                  return ArticleItemWidget(item);
                }),
          );
        }
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
