import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_wan_android/app/wan_color.dart';
import 'package:flutter_wan_android/model/article_model.dart';
import 'package:flutter_wan_android/provider/provider_widget.dart';
import 'package:flutter_wan_android/view_model/home_view_model.dart';
import 'package:flutter_wan_android/provider/view_state_widget.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    print("start build widget");
    return Scaffold(
        backgroundColor: WanColor.white,
        appBar: AppBar(
          backgroundColor: WanColor.lightBlue,
          //修改状态栏颜色
          systemOverlayStyle: SystemUiOverlayStyle.light,
          title: Text('首页'),
          centerTitle: true,
          actions: [
            IconButton(
              icon: Icon(Icons.search),
              tooltip: "搜索",
              onPressed: () {
                print("Search Pressed");
              },
            )
          ],
        ),
        body: ProviderWidget(
          model: HomeViewModel(),
          onModelReady: (model) => model.initData(),
          builder: (context, model, child) {
            if (model.isLoading) {
              return ViewStateLoadingWidget();
            } else {
              return ListView.builder(
                //越界回弹
                // physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  return _buildArticleItem(model.list[index]);
                },
                itemCount: model.list.length,
              );
            }
          },
        ));
  }

  Widget _buildArticleItem(ArticleInfo articleInfo) {
    return InkWell(
      onTap: () {},
      highlightColor: WanColor.color3358B2DC,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 0),
        margin: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
            border: Border(
          bottom: Divider.createBorderSide(context, width: 0.7),
        )),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                //最左边的文字，作者
                Text(
                  articleInfo.author,
                  style: TextStyle(color: WanColor.color707070, fontSize: 12),
                ),
                //中间用Expanded隔开
                Expanded(
                  child: SizedBox.shrink(),
                ),
                //最右边的文字，日期
                Text(
                  articleInfo.niceShareDate,
                  style: TextStyle(color: WanColor.color707070, fontSize: 12),
                )
              ],
            ),
            Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  articleInfo.title,
                  style: TextStyle(color: WanColor.color1A1A1A, fontSize: 16),
                  maxLines: 2, //最多显示2行
                  overflow: TextOverflow.ellipsis, //超出用省略号显示
                )),
            Row(
              children: [
                Text(
                  articleInfo.chapterName,
                  style: TextStyle(color: WanColor.color707070, fontSize: 10),
                ),
                Expanded(
                  child: SizedBox.shrink(),
                ),
                Icon(Icons.favorite_border)
              ],
            )
          ],
        ),
      ),
    );
  }
}
