import 'package:barbarian/src/barbarian_base.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:synchronized/synchronized.dart';

class BarbarianSharedPreferences extends BarbarianBase {
  static BarbarianSharedPreferences _singleton;

  factory BarbarianSharedPreferences() {
    if (_singleton != null) {
      return _singleton;
    }
    _singleton = BarbarianSharedPreferences._();
    return _singleton;
  }

  BarbarianSharedPreferences._();

  static SharedPreferences _prefs;
  Lock _lock = Lock();

  Future<BarbarianSharedPreferences> init() async {
    if (_singleton == null) {
      await _lock.synchronized(() async {
        if (_singleton == null) {
          var singleton = BarbarianSharedPreferences();
          await singleton._init();
          _singleton = singleton;
        }
      });
    }
    return _singleton;
  }

  //  static Barbarian get instance => Barbarian._();

  Future _init() async {
    _prefs = await SharedPreferences.getInstance();
  }

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
