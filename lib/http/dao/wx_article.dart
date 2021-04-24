import 'package:flutter_wan_android/http/request/wan_base_request.dart';

class WxArticleRequest extends BaseRequest {
  @override
  HttpMethod httpMethod() {
    return HttpMethod.GET;
  }

  @override
  bool needLogin() {
    return false;
  }

  @override
  String path() {
    return '/wxarticle/chapters/json';
  }
}
