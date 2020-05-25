// Copyright (c) 2018, codegrue. All rights reserved. Use of this source code
// is governed by the MIT license that can be found in the LICENSE file.
import 'dart:convert' show json;

//import 'package:barbarian/ipa.dart';
//import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:synchronized/synchronized.dart';

part 'pale_ale.dart';

typedef CustomDecoder = dynamic Function(dynamic output);

class BarbarianSharedPreference {
  BarbarianSharedPreference _singleton;
  SharedPreferences _prefs;
  Lock _lock = Lock();

  Future<BarbarianSharedPreference> init() async {
    if (_singleton == null) {
      await _lock.synchronized(() async {
        if (_singleton == null) {
          var singleton = BarbarianSharedPreference._();
          await singleton._init();
          _singleton = singleton;
        }
      });
    }
    return _singleton;
  }

  BarbarianSharedPreference._();

  //  static Barbarian get instance => Barbarian._();

  Future _init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  dynamic read(
    String key, {
    CustomDecoder customDecoder,
    dynamic defaultValue,
  }) {
    String first = _prefs.getString(key);

    if (first == null) return null;

    final parts = first.split('__type__');
    String type = parts[0];
    String value = parts[1];

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
          return customDecoder(json.decode(value)) ?? defaultValue;
        } //
        catch (e) {
          return defaultValue ?? null;
        }
    }
  }

  void write(String key, dynamic value) {
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

  void delete(String key) => _prefs.remove(key);

  List<String> getAllKeys() => _prefs.getKeys().map((key) => key).toList();

  void destroy() => _prefs.clear();

  bool contains(String key) => _prefs.containsKey(key);

  //static Map<String, ValueNotifier<Lupulus>> _ipaListeners = Map();
  //
  //static ValueNotifier<T> listenIpa<T extends Lupulus>(String key,
  //    [T defaultValue]) {
  //  if (!_ipaListeners.containsKey(key)) {
  //    _ipaListeners[key] = ValueNotifier<T>(defaultValue);
  //  }
  //  return _ipaListeners[key];
  //}
  //
  //static void writeWithNotify<T extends Lupulus>(String key, T value) {
  //  Barbarian.write(key, value);
  //  _ipaListeners[key]?.value = value;
  //  print('_ipaListeners[key]?.value ${_ipaListeners[key]?.value}');
  //}
  //
  //static void dispose() {
  //  _ipaListeners.forEach((_, v) => v.dispose());
  //  _ipaListeners.clear();
  //}
}

final Barbarian = BarbarianSharedPreference._();
