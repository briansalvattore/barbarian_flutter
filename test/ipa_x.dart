import 'package:barbarian/barbarian.dart';
import 'package:barbarian/ipa_list.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:barbarian/ipa_object.dart';

class Person extends IpaObject<Person> {
  String name;
  String last;

  @override
  String get key => 'person';

  @override
  Map<String, dynamic> toJson() => {
        'name': name,
        'last': last,
      };

  @override
  Person fromMap(Map<String, dynamic> map) => Person()
    ..name = map['name']
    ..last = map['last'];
}

class Movie extends IpaList<Movie> {
  String name;
  int year;

  @override
  String get key => 'movie';

  @override
  Map<String, dynamic> toJson() => {
    'name': name,
    'year': year,
  };

  @override
  Movie fromMap(Map<String, dynamic> map) => Movie()
    ..name = map['name']
    ..year = map['year'];
}

void main() {
  test('ipa object', () async {
    SharedPreferences.setMockInitialValues({});
    await Barbarian.init();

    Person brian = Person()
      ..name = 'Brian'
      ..last = 'Castillo';
    brian.save();
    print('brian in barbarian ${brian.get()}');

    brian..name = 'Brian Salvattore';
    brian.save();

    print('brian in barbarian ${brian.get()}');
  });


  test('ipa list', () async {
    SharedPreferences.setMockInitialValues({});
    await Barbarian.init();

    Movie sw1 = Movie()
      ..name = 'Star wars 1'
      ..year = 1999;
    sw1.add();

    Movie sw2 = Movie()
      ..name = 'Star wars 2'
      ..year = 2002;
    sw2.add();

    Movie sw3 = Movie()
      ..name = 'Star wars 3'
      ..year = 2005;
    sw3.add();

    Movie sw4 = Movie()
      ..name = 'Star wars 4'
      ..year = 1977;
    sw4.add();

    print('starwars in barbarian ${sw1.getAll()}');

    sw2.remove();

    List<Movie> movies = sw1.getAll();
    movies.forEach((movie) {
      print('movie ${movie.name} year ${movie.year}');
    });
  });
}
