import 'package:flutter/material.dart';
import 'package:flutter_wan_android/app/app_resource.dart';
import 'package:flutter_wan_android/app/wan_color.dart';
import 'package:flutter_wan_android/model/article_model.dart';
import 'package:flutter_wan_android/route/wan_route.dart';
import 'package:flutter_wan_android/ui/widget/article_item_widget.dart';

class ProjectArticleItemWidget extends StatelessWidget {
  final ArticleInfo articleInfo;

  const ProjectArticleItemWidget(this.articleInfo, {Key key}) : super(key: key);

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
            // 标题
            ArticleTitle(articleInfo.title),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: ImageHelper.loadNetImage(articleInfo.envelopePic,
                    "image/image_zero", MediaQuery.of(context).size.width, 200),
              ),
            ),
            Row(
              children: [
                Image.asset(
                  ImageHelper.loadAssets("icon/icon_author.png"),
                  width: 18,
                  height: 18,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4),
                  child:
                  Text(articleInfo.author == "" ? "匿名" : articleInfo.author),
                ),
                Image.asset(
                  ImageHelper.loadAssets("icon/icon_time.png"),
                  width: 20,
                  height: 20,
                ),
                Text(articleInfo.niceShareDate == ""
                    ? "匿名"
                    : articleInfo.niceShareDate)
              ],
            )
          ],
        ),
      ),
    );
  }
}
