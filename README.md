# Barbarian

[![pub package](https://img.shields.io/pub/v/barbarian.svg)](https://pub.dartlang.org/packages/barbarian)

Barbarian is a fast and simple way to save data in NoSQL. It is a simple wrap of Shared preferences.

### Initialize Barbarian

```dart
await Barbarian.init();
```

## Save
Save any object, Map, List, HashMap etc. including all internal objects. Use your existing data classes as is.

```dart
Barbarian.write('string', 'cadena');
Barbarian.write('bool', true);
Barbarian.write('integer', 7);
Barbarian.write('double', 3.8);
```

## Read
Read data objects is as easy as

```dart
String str = Barbarian.read('string');
bool boole = Barbarian.read('bool');
int ibtg = Barbarian.read('integer');
double doub = Barbarian.read('double');
```

## Delete
Delete data for one key.

```dart
Barbarian.delete('string');
```
Remove all keys

```dart
Barbarian.destroy();
```

## Get all keys
Returns all keys for objects in the book.

```dart
List<String> allKeys = Barbarian.getAllKeys();
```

## Complex data
To save an object it is important that it has some form of serialization. Like this

```dart
class Item {
  int id;
  String name;
  List<String> locations;
  double price;
  int stock;
  bool active;

  Item(
      {this.id,
      this.name,
      this.locations,
      this.price,
      this.stock,
      this.active});

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'locations': locations,
        'price': price,
        'stock': stock,
        'active': active
      };

  Item.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        name = map['name'],
        locations = List<String>.from(map['locations']),
        price = map['price'],
        stock = map['stock'],
        active = map['active'];

  @override
  String toString() => toJson().toString();
}
```

### Save

```dart
Barbarian.write('item', item);
```

### Read

```dart
Item oldItem = Barbarian.read('item', customDecode: (output) => Item.fromMap(output));
```

If you need more examples of complex data you can review the [tests here](https://github.com/briansalvattore/barbarian_flutter/blob/master/test/barbarian_test.dart).
