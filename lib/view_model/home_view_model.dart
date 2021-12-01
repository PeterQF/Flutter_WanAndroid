import 'package:flutter_wan_android/http/repository/wan_repository.dart';
import 'package:flutter_wan_android/provider/view_state_refresh_list_model.dart';

class HomeViewModel extends ViewStateRefreshListModel {

  @override
  Future<List> loadData({int pageNum}) async {
    return await WanRepository.fetchHomeArticle(pageNum);
  }
}