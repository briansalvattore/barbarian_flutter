import 'package:barbarian/barbarian.dart';
import 'package:barbarian/ipa.dart';
import 'package:flutter/foundation.dart';

abstract class IpaList<T> extends Lupulus<T> with Ipa {
  void add<T extends Ipa>() {
    List<T> list = getAll();
    list.add(this as T);

    Barbarian.writeListWithNotify(key, list);
  }

  void empty() => Barbarian.delete(key);

  void remove<T extends Ipa>() {
    List<T> list = getAll().where((i) => i.toString() != this.toString()).toList();

    Barbarian.writeListWithNotify(key, list);
  }

  List<T> getAll<T extends Ipa>() =>
      Barbarian.read(key, customDecode: (o) {
        return o.map<T>((map) => fromMap(map)).toList();
      }) ??
      List<T>();

  ValueListenable<List<T>> listen<T extends Ipa>([List<T> defaultValue]) {
    return Barbarian.listenIpaList<T>(key, defaultValue);
  }
}
