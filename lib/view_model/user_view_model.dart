import 'package:flutter_wan_android/db/wan_data_store.dart';
import 'package:flutter_wan_android/model/user_model.dart';
import 'package:flutter_wan_android/provider/view_state_model.dart';

class UserViewModel extends ViewStateModel {

  static const String kUser = "kUser";

  User _user;

  bool get isLogin => _user != null;

  User get user => _user;

  init() {
    var userMap = WanDataStore.getObjectJsonMap(kUser);
    _user = userMap == null ? null : User.fromJsonMap(userMap);
  }

  updateUserState(User user) {
    _user = user;
    notifyListeners();
    WanDataStore.saveObject(kUser, user.toJson());
  }
}