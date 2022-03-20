import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WanDataStore {
  /// app全局配置 eg:theme
  static SharedPreferences sharedPreferences;

  /// 临时目录 eg: cookie
  static Directory temporaryDirectory;

  /// 必备数据的初始化操作
  ///
  /// 由于是同步操作会导致阻塞,所以应尽量减少存储容量
  static init() async {
    // async 异步操作
    // sync 同步操作
    temporaryDirectory = await getTemporaryDirectory();
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static saveObject(String key, Object object) async {
    if (sharedPreferences != null) {
      await sharedPreferences.setString(key, jsonEncode(object));
    }
  }

  static getObjectJsonMap(String key) {
    if (sharedPreferences != null) {
      String data = sharedPreferences.getString(key);
      if (data != null) {
        Map<String, dynamic> responseJson = json.decode(data);
        return responseJson;
      }
    }
    return null;
  }
}
