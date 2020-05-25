import 'package:barbarian/src/barbarian_base.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BarbarianSharedPreferences extends BarbarianBase {
  static Future<BarbarianSharedPreferences> _futureIntance;

  BarbarianSharedPreferences._();

  static SharedPreferences _prefs;

  static Future<BarbarianSharedPreferences> init() async {
    if (_futureIntance == null) {
      _futureIntance = _init();
    }
    return _futureIntance;
  }

  static Future<BarbarianSharedPreferences> _init() async {
    final singleton = BarbarianSharedPreferences._();
    _prefs = await SharedPreferences.getInstance();
    return singleton;
  }

  //  static Barbarian get instance => Barbarian._();

  @override
  String getString(String key) => _prefs.getString(key);

  @override
  Future<bool> setString(String key, String value) {
    return _prefs.setString(key, value);
  }

  @override
  void delete(String key) => _prefs.remove(key);

  @override
  List<String> getAllKeys() => _prefs.getKeys().map((key) => key).toList();

  @override
  bool contains(String key) => _prefs.containsKey(key);

  @override
  void dispose() => _prefs.clear();

  @deprecated
  void destroy() => dispose();
}
