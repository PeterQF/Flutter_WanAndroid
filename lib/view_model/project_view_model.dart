import 'package:flutter_wan_android/http/wan_repository.dart';
import 'package:flutter_wan_android/model/category_model.dart';
import 'package:flutter_wan_android/provider/view_state_list_model.dart';
import 'package:flutter_wan_android/provider/view_state_refresh_list_model.dart';

class ProjectCategoryViewModel extends ViewStateListModel<CategoryInfo> {
  @override
  Future<List<CategoryInfo>> loadData() async {
    return await WanRepository.fetchProjectCategory();
  }
}

class ProjectListViewModel extends ViewStateRefreshListModel {

  final int cid;

  ProjectListViewModel(this.cid);

  @override
  Future<List> loadData({int pageNum}) async {
    return await WanRepository.fetchArticle(pageNum, cid: cid);
  }
}