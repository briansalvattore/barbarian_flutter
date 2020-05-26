import 'package:barbarian/barbarian.dart';

abstract class Ipa {
  void delete() => Barbarian.delete(key);

  String get key;

  Map<String, dynamic> toJson();

  @override
  String toString() => toJson().toString();
}

abstract class Lupulus<T> {
  T fromMap(Map<String, dynamic> map);
}