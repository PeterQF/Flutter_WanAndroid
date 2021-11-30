import 'package:flutter_wan_android/http/wan_net_client.dart';
import 'package:flutter_wan_android/model/article_model.dart';

class WanRepository {
  static Future fetchHomeArticle(int pageNum) async {
    var response = await WanNetClient.getInstance.get('/article/list/$pageNum/json');
    List<ArticleInfo> articles = response.data['datas'].map<ArticleInfo>((item) => ArticleInfo.fromMap(item)).toList();
    print("article size  = " + articles.length.toString());
    return articles;
  }
}
