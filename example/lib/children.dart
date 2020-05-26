import 'package:barbarian/ipa_list.dart';

class Children extends IpaList<Children> {
  String name;
  String last;

  @override
  String get key => 'child';

  void addChild(String name, String last) {
    Children()
      ..name = name
      ..last = last
      ..add();
  }

  @override
  Map<String, dynamic> toJson() => {
        'name': name,
        'last': last,
      };

  @override
  Children fromMap(Map<String, dynamic> map) => Children()
    ..name = map['name']
    ..last = map['last'];
}
