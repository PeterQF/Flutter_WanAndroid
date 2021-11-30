import 'package:flutter_wan_android/http/request/wan_base_request.dart';


class HomeArticleRequest extends BaseRequest {
  final int _pageNum;

  HomeArticleRequest(this._pageNum);

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
    return '/article/list/$_pageNum/json';
  }
}
