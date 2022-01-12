import 'package:flutter/material.dart';
import 'package:flutter_wan_android/app/wan_color.dart';
import 'package:flutter_wan_android/model/article_model.dart';
import 'package:flutter_wan_android/route/wan_route.dart';

class ArticleItemWidget extends StatelessWidget {
  final ArticleInfo articleInfo;

  const ArticleItemWidget(this.articleInfo, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(RouteName.articleDetail, arguments: articleInfo);
      },
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
                  articleInfo.author == "" ? "匿名" : articleInfo.author,
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
                child: ArticleTitle(articleInfo.title)),
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

class ArticleTitle extends StatelessWidget {
  final String title;

  const ArticleTitle(this.title, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(color: WanColor.color1A1A1A, fontSize: 16),
      maxLines: 2, //最多显示2行
      overflow: TextOverflow.ellipsis, //超出用省略号显示
    );
  }
}
