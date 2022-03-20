import 'package:flutter_wan_android/db/wan_data_store.dart';
import 'package:flutter_wan_android/http/wan_repository.dart';
import 'package:flutter_wan_android/provider/view_state_model.dart';
import 'package:flutter_wan_android/view_model/user_view_model.dart';

const String kLoginName = 'kLoginName';

class LoginViewModel extends ViewStateModel {
  final UserViewModel userViewModel;

  LoginViewModel(this.userViewModel) : assert(userViewModel != null);

  String getLoginName() {
    return WanDataStore.sharedPreferences.getString(kLoginName);
  }

  Future<bool> login(loginName, password) async {
    setLoading();
    try {
      var user = await WanRepository.login(loginName, password);
      userViewModel.updateUserState(user);
      WanDataStore.sharedPreferences
          .setString(kLoginName, userViewModel.user.username);
      setIdle();
      return true;
    } catch (e, s) {
      setError(e, s);
      return false;
    }
  }
}
