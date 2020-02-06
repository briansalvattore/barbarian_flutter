// Copyright (c) 2018, codegrue. All rights reserved. Use of this source code
// is governed by the MIT license that can be found in the LICENSE file.
import 'dart:convert' show json;

import 'package:shared_preferences/shared_preferences.dart';
import 'package:synchronized/synchronized.dart';

typedef CustomDecode = dynamic Function(dynamic output);

class Barbarian {
  static Barbarian _singleton;
  static SharedPreferences _prefs;
  static Lock _lock = Lock();

  static Future<Barbarian> init() async {
    if (_singleton == null) {
      await _lock.synchronized(() async {
        if (_singleton == null) {
          var singleton = Barbarian._();
          await singleton._init();
          _singleton = singleton;
        }
      });
    }
    return _singleton;
  }

  Barbarian._();

  Future _init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static dynamic read(
    String key, {
    CustomDecode customDecode,
    dynamic defaultValue,
  }) {
    String first = _prefs.getString(key);

    if (first == null) return null;

    String type = first.split('__type__')[0];
    String value = first.split('__type__')[1];

    switch (type) {
      case 'Null':
        return null;
      case 'String':
        return value;
      case 'int':
        return int.tryParse(value) ?? defaultValue;
      case 'double':
        return double.tryParse(value) ?? defaultValue;
      case 'bool':
        return value == 'true';
      default:
        return customDecode(json.decode(value));
    }
  }

  static void write(String key, dynamic value) {
    switch (value.runtimeType) {
      case String:
      case int:
      case double:
      case bool:
        _prefs.setString(
          key,
          '${value.runtimeType}__type__$value',
        );
        break;
      default:
        _prefs.setString(
          key,
          '${value.runtimeType}__type__${json.encode(value)}',
        );
        break;
    }
  }

  static void delete(String key) => _prefs.remove(key);

  static List<String> getAllKeys() =>
      _prefs.getKeys().map((key) => key).toList();

  static void destroy() => _prefs.clear();

  static bool contains(String key) => _prefs.containsKey(key);
}
