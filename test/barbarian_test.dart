import 'package:barbarian/barbarian.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

void main() {
  test('simple barbarian', () async {
    SharedPreferences.setMockInitialValues({});
    await Barbarian.init();

    Barbarian.write('cadena', 'cadena');
    Barbarian.write('boleano', true);
    Barbarian.write('entero', 7);
    Barbarian.write('numero', 3.8);

    String cadena = Barbarian.read('cadena');
    bool boleano = Barbarian.read('boleano');
    int entero = Barbarian.read('entero');
    double numero = Barbarian.read('numero');

    print('cadena $cadena');
    print('boleano $boleano');
    print('entero $entero');
    print('numero $numero');

    print('all keys => ${Barbarian.getAllKeys()}');
  });

  test('middle barbarian', () async {
    SharedPreferences.setMockInitialValues({});
    await Barbarian.init();

    Barbarian.write('listOfString', ['Strdf', 'asdasd']);
    Barbarian.write('mapOfString', {'first': 'hola', 'second': 'mundo'});

    List<String> listOfString = Barbarian.read('listOfString',
        customDecode: (output) => List<String>.from(output));

    Map<String, String> mapOfString = Barbarian.read('mapOfString',
        customDecode: (output) => Map<String, String>.from(output));

    print('listOfString $listOfString');
    print('mapOfString $mapOfString');
  });

  test('advance barbarian', () async {
    SharedPreferences.setMockInitialValues({});
    await Barbarian.init();

    Item item = Item(
        id: 1,
        name: 'Item1',
        locations: ['Abcde', '12345'],
        price: 100.00,
        stock: 10,
        active: true);

    Barbarian.write('item', item);
    Barbarian.write('listOfItems', [item, item]);
    Barbarian.write('mapOfItems', {'first': item, 'second': item});

    Item newItem =
        Barbarian.read('item', customDecode: (output) => Item.fromMap(output));

    List<Item> listOfItems = Barbarian.read('listOfItems',
        customDecode: (output) =>
            output.map<Item>((item) => Item.fromMap(item)).toList());

    Map<String, Item> mapOfItems = Barbarian.read('mapOfItems',
        customDecode: (output) => output.map<String, Item>(
            (key, value) => MapEntry<String, Item>(key, Item.fromMap(value))));

    print('newItem $newItem');
    print('listOfItems $listOfItems');
    print('mapOfItems $mapOfItems');
  });
}
