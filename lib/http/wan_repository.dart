import 'package:flutter_wan_android/http/wan_net_client.dart';
import 'package:flutter_wan_android/model/article_model.dart';
import 'package:flutter_wan_android/model/banner_model.dart';
import 'package:flutter_wan_android/model/project_category_model.dart';

class WanRepository {
  // 加载文章
  static Future fetchArticle(int pageNum, {int cid}) async {
    var response = await WanNetClient.getInstance.get(
        '/article/list/$pageNum/json',
        queryParameters: (cid != null) ? {'cid': cid} : null);
    List<ArticleInfo> articles = response.data['datas']
        .map<ArticleInfo>((item) => ArticleInfo.fromMap(item))
        .toList();
    return articles;
  }

  // 加载banner
  static Future fetchBanner() async {
    var response = await WanNetClient.getInstance.get('/banner/json');
    List<BannerInfo> banners = response.data
        .map<BannerInfo>((item) => BannerInfo.fromMap(item))
        .toList();
    return banners;
  }

  // 项目分类
  static Future fetchProjectCategory() async {
    var response = await WanNetClient.getInstance.get('/project/tree/json');
    List<ProjectCategoryInfo> categories = response.data
        .map<ProjectCategoryInfo>((item) => ProjectCategoryInfo.fromMap(item))
        .toList();
    return categories;
  }
}
