import 'package:flutter_wan_android/http/core/wan_net.dart';
import 'package:flutter_wan_android/http/dao/wx_article.dart';
import 'package:flutter_wan_android/http/request/wan_base_request.dart';

class WxArticleDao {
  static getArticle() {
    return _send();
  }

  static _send() async {
    BaseRequest request = WxArticleRequest();
    var result = await WanNet.getInstance().fire(request);
    print(result);
    return result;
  }
}
