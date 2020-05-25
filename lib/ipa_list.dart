import 'package:barbarian/barbarian.dart';
import 'package:barbarian/ipa.dart';

abstract class IpaList<T> extends Ipa<T> {
  void add() {
    List<T> list = getAll();
    list.add(this as T);

    Barbarian.write(key, list);
  }

  void remove() {
    List<T> list =
        getAll().where((i) => i.toString() != this.toString()).toList();
    Barbarian.write(key, list);
  }

  List<T> getAll() =>
      Barbarian.read(key, customDecoder: (o) {
        return o.map<T>((map) => fromMap(map)).toList();
      }) ??
      List<T>();
}
