import 'package:barbarian/barbarian.dart';
import 'package:barbarian_example/children.dart';
import 'package:flutter/material.dart';

import 'person.dart';

void main() {
  runApp(BarbarianApp());
}

class BarbarianApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Barbarian Demo',
      theme: ThemeData.dark(),
      home: BarbarianPage(),
    );
  }
}

class BarbarianPage extends StatefulWidget {
  @override
  _BarbarianPageState createState() => _BarbarianPageState();
}

class _BarbarianPageState extends State<BarbarianPage> {
  Person _brian = Person()
    ..name = 'Brian'
    ..last = 'Castillo';

  Children children = Children();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Barbarian.init();

      children.empty();
      children.addChild('Brian', 'Castillo');

      await Future.delayed(Duration(seconds: 2));

      _brian..name = 'Carlos';
      _brian.save();

      children.addChild('Carlos', 'Ramirez');

      await Future.delayed(Duration(seconds: 2));

      _brian..name = 'Frank';
      _brian.save();

      children.addChild('Frank', 'Moreno');

      await Future.delayed(Duration(seconds: 2));

      _brian..name = 'Pierre';
      _brian.save();

      children.addChild('Pierre', 'Guillen');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Barbarian'),
      ),
      body: SizedBox.expand(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ValueListenableBuilder<Person>(
              valueListenable: _brian.listen(_brian),
              builder: (context, value, _) {
                print('person $value');
                return Text('Hi ${value?.name}');
              },
            ),
            ValueListenableBuilder(
              valueListenable: children.listen(),
              builder: (context, value, _) {
                print('children $value');
                return Text('Children ${value?.length ?? 0}');
              },
            ),
          ],
        ),
      ),
    );
  }
}
