import 'package:barbarian/barbarian.dart';
import 'package:flutter/foundation.dart';

abstract class Ipa<T> extends Lupulus {
  /*String get key;

  Map<String, dynamic> toJson();

  @override
  String toString() => toJson().toString();

  ValueListenable<T> listen<T>([T defaultValue]) {
    return Barbarian.listenIpa<T>(key, defaultValue);
  }*/

  T fromMap(Map<String, dynamic> map);

  void delete() => Barbarian.delete(key);
}

abstract class Lupulus<T> {
  String get key;

  Map<String, dynamic> toJson();

  @override
  String toString() => toJson().toString();

  //ValueListenable<T> listen<T extends Lupulus>([T defaultValue]) {
  //  return Barbarian.listenIpa<T>(key, defaultValue);
  //}
}
