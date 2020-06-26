// Copyright (c) 2020, briansalvattore. All rights reserved. Use of this source code
// is governed by the MIT license that can be found in the LICENSE file.
import 'dart:convert' show json;

import 'package:barbarian/ipa.dart';
import 'package:flutter/foundation.dart';
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

    List<String> split = first.split('__type__');

    if (split.length != 2) {
      return null;
    }

    String type = split[0];
    String value = split[1];

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
        try {
          return customDecode(json.decode(value)) ?? defaultValue;
        } //
        catch (e) {
          return defaultValue;
        }
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

  static Map<String, ValueNotifier<Ipa>> _ipaListeners = Map();
  static Map<String, ValueNotifier<List<Ipa>>> _ipaListListeners = Map();

  static ValueNotifier<T> listenIpa<T extends Ipa>(String key,
      [T defaultValue]) {
    if (!_ipaListeners.containsKey(key)) {
      _ipaListeners[key] = ValueNotifier<T>(defaultValue);
    }
    return _ipaListeners[key];
  }

  static ValueNotifier<List<T>> listenIpaList<T extends Ipa>(String key,
      [List<T> defaultValue]) {
    if (!_ipaListListeners.containsKey(key)) {
      _ipaListListeners[key] = ValueNotifier<List<T>>(defaultValue);
    }
    return _ipaListListeners[key];
  }

  static void writeObjectWithNotify<T extends Ipa>(String key, T value) {
    Barbarian.write(key, value);

    if (!_ipaListeners.containsKey(key)) {
      _ipaListeners[key] = ValueNotifier<T>(value);
    } //
    else {
      _ipaListeners[key]?.value = value;
    }

    // ignore: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member
    _ipaListeners[key]?.notifyListeners();
  }

  static void writeListWithNotify<T extends Ipa>(String key, List<T> value) {
    Barbarian.write(key, value);

    if (!_ipaListListeners.containsKey(key)) {
      _ipaListListeners[key] = ValueNotifier<List<T>>(value);
    } //
    else {
      _ipaListListeners[key]?.value = value;
    }

    // ignore: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member
    _ipaListListeners[key]?.notifyListeners();
  }

  static void dispose() {
    _ipaListeners.forEach((_, v) => v.dispose());
    _ipaListeners.clear();

    _ipaListListeners.forEach((_, v) => v.dispose());
    _ipaListListeners.clear();
  }
}
