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