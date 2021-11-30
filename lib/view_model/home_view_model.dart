import 'package:flutter_wan_android/http/repository/wan_repository.dart';
import 'package:flutter_wan_android/provider/view_state_list_model.dart';

class HomeViewModel extends ViewStateListModel {

  @override
  Future<List> loadData() async {
    return await WanRepository.fetchHomeArticle(0);
  }
}