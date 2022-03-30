import 'package:flutter_wan_android/http/wan_repository.dart';
import 'package:flutter_wan_android/provider/view_state_model.dart';

class RegisterViewModel extends ViewStateModel {
  Future<bool> signup(loginName, password, rePassword) async {
    setLoading();
    try {
      await WanRepository.register(loginName, password, rePassword);
      setIdle();
      return true;
    } catch(e, s) {
      setError(e, s);
      return false;
    }
  }
}