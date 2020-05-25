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
  test('nullable test', () async {
    SharedPreferences.setMockInitialValues({});
    final List<BarbarianBase> barbarians = await Future.wait([
      Barbarian.init(),
      Barbarian.init(),
      Barbarian.init(),
      Barbarian.init(),
    ]);

    final _barbarian = await Barbarian.init();
    barbarians.forEach((b) {
      expect(b, equals(_barbarian));
    });
  });
  test('nullable test', () async {
    SharedPreferences.setMockInitialValues({});
    final barbarian = await Barbarian.init();
    expect(barbarian, isNotNull);

    barbarian.write('nullable', null);

    String nullable = barbarian.read('nullable');

    print('nullable $nullable');
  });

  test('simple barbarian', () async {
    SharedPreferences.setMockInitialValues({});
    final barbarian = await Barbarian.init();

    barbarian.write('cadena', 'cadena');
    barbarian.write('boleano', true);
    barbarian.write('entero', 7);
    barbarian.write('numero', 3.8);

    String cadena = barbarian.read('cadena');
    bool boleano = barbarian.read('boleano');
    int entero = barbarian.read('entero');
    double numero = barbarian.read('numero');

    print('cadena $cadena');
    print('boleano $boleano');
    print('entero $entero');
    print('numero $numero');

    print('all keys => ${barbarian.getAllKeys()}');
  });

  test('middle barbarian', () async {
    SharedPreferences.setMockInitialValues({});
    final barbarian = await Barbarian.init();

    barbarian.write('listOfString', ['Strdf', 'asdasd']);
    barbarian.write('mapOfString', {'first': 'hola', 'second': 'mundo'});

    List<String> listOfString = barbarian.read('listOfString',
        customDecoder: (output) => List<String>.from(output));

    Map<String, String> mapOfString = barbarian.read('mapOfString',
        customDecoder: (output) => Map<String, String>.from(output));

    print('listOfString $listOfString');
    print('mapOfString $mapOfString');
  });

  test('advance barbarian', () async {
    SharedPreferences.setMockInitialValues({});
    final barbarian = await Barbarian.init();

    Item item = Item(
        id: 1,
        name: 'Item1',
        locations: ['Abcde', '12345'],
        price: 100.00,
        stock: 10,
        active: true);

    barbarian.write('item', item);
    barbarian.write('listOfItems', [item, item]);
    barbarian.write('mapOfItems', {'first': item, 'second': item});

    Item newItem =
        barbarian.read('item', customDecoder: (output) => Item.fromMap(output));

    List<Item> listOfItems = barbarian.read('listOfItems',
        customDecoder: (output) =>
            output.map<Item>((item) => Item.fromMap(item)).toList());

    Map<String, Item> mapOfItems = barbarian.read('mapOfItems',
        customDecoder: (output) => output.map<String, Item>(
            (key, value) => MapEntry<String, Item>(key, Item.fromMap(value))));

    print('newItem $newItem');
    print('listOfItems $listOfItems');
    print('mapOfItems $mapOfItems');
  });

  test('validate if null', () async {
    SharedPreferences.setMockInitialValues({});
    final barbarian = await Barbarian.init();

    var ifNulled = barbarian.read('nulleable');
    print('ifNulled $ifNulled');
  });
}
