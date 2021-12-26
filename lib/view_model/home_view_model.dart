import 'package:flutter_wan_android/http/wan_repository.dart';
import 'package:flutter_wan_android/model/banner_model.dart';
import 'package:flutter_wan_android/provider/view_state_refresh_list_model.dart';

class HomeViewModel extends ViewStateRefreshListModel {

  List<BannerInfo> _banners;
  List<BannerInfo> get banners => _banners;

  @override
  Future<List> loadData({int pageNum}) async {
    List<Future> futures = [];
    if(pageNum == ViewStateRefreshListModel.pageNumFirst) {
      futures.add(WanRepository.fetchBanner());
    }
    futures.add(WanRepository.fetchArticle(pageNum));
    var result = await Future.wait(futures);
    if (pageNum == ViewStateRefreshListModel.pageNumFirst) {
      _banners = result[0];
      return result[1];
    } else {
      return result[0];
    }
  }
}