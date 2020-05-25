//part of 'barbarian.dart';
/*
extension PaleAle on Barbarian {
  ValueNotifier<T> listenIpa<T extends Lupulus>(String key, [T defaultValue]) {
    if (!_ipaListeners.containsKey(key)) {
      _ipaListeners[key] = ValueNotifier<T>(defaultValue);
    }
    return _ipaListeners[key];
  }

  void writeWithNotify<T extends Lupulus>(String key, T value) {
    Barbarian.write(key, value);
    _ipaListeners[key]?.value = value;
  }

  static void dispose() {
    _ipaListeners.forEach((_, v) => v.dispose());
    _ipaListeners.clear();
  }
}*/
