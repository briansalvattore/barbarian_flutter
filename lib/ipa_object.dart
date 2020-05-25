import 'package:barbarian/barbarian.dart';
import 'package:barbarian/ipa.dart';
import 'package:flutter/cupertino.dart';

abstract class IpaObject<T> extends Ipa<T> {
  /*final Map<String, ValueNotifier<T>> _listeners = Map();


  void save() {
    Barbarian.write(key, this);
    _listeners[]
  }*/
  //void save() => Barbarian.writeWithNotify(key, this);

  T get() => Barbarian.read(key, customDecoder: (o) => fromMap(o));
}
