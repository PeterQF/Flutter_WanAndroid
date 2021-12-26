import 'package:flutter_wan_android/http/wan_repository.dart';
import 'package:flutter_wan_android/model/category_model.dart';
import 'package:flutter_wan_android/model/navigation_site_model.dart';
import 'package:flutter_wan_android/provider/view_state_list_model.dart';

class StructureViewModel extends ViewStateListModel {
  @override
  Future<List<CategoryInfo>> loadData() async {
    return await WanRepository.fetchStructureCategory();
  }
}

class NavigationViewModel extends ViewStateListModel {
  @override
  Future<List<NavigationSite>> loadData() async {
    return await WanRepository.fetchNavigationSite();
  }
}