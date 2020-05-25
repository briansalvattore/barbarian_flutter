// Copyright (c) 2020, Grinch Code. All rights reserved. Use of this source code
// is governed by the MIT license that can be found in the LICENSE file.
import 'src/barbarian_shared_preferences.dart';
export 'src/barbarian_base.dart';

final Barbarian = BarbarianSharedPreferences();

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
