import 'package:barbarian/barbarian.dart';
import 'package:barbarian/ipa.dart';
import 'package:flutter/foundation.dart';

abstract class IpaObject<T> extends Lupulus<T> with Ipa  {

  void save() => Barbarian.writeObjectWithNotify(key, this);

  T get() => Barbarian.read(key, customDecode: (o) => fromMap(o));

  ValueListenable<T> listen<T extends Ipa>([T defaultValue]) {
    return Barbarian.listenIpa<T>(key, defaultValue);
  }
}
