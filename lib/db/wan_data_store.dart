import 'package:shared_preferences/shared_preferences.dart';

class WanDataStore {
  SharedPreferences prefs;
  WanDataStore._() {
    init();
  }

  WanDataStore._pre(SharedPreferences prefs) {
    this.prefs = prefs;
  }

  static WanDataStore _instance;

  // 预初始化，防止在使用get时，prefs还未完成初始化
  static Future<WanDataStore> preInit() async {
    if (_instance == null) {
      var prefs = await SharedPreferences.getInstance();
      _instance = WanDataStore._pre(prefs);
    }
    return _instance;
  }

  static WanDataStore getInstance() {
    if (_instance == null) {
      _instance = WanDataStore._();
    }
    return _instance;
  }

  void init() async {
    if (prefs == null) {
      prefs = await SharedPreferences.getInstance();
    }
  }

  void setString(String key, String value) {
    prefs.setString(key, value);
  }

  void setDouble(String key, double value) {
    prefs.setDouble(key, value);
  }

  void setInt(String key, int value) {
    prefs.setInt(key, value);
  }

  void setBool(String key, bool value) {
    prefs.setBool(key, value);
  }

  void setStringList(String key, List<String> value) {
    prefs.setStringList(key, value);
  }

  T get<T>(String key) => prefs.get(key);
}
