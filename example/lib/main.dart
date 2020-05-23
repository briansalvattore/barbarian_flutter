import 'package:barbarian/barbarian.dart';
import 'package:flutter/material.dart';
import 'person.dart';

void main() {
  runApp(BarbarianApp());
}

class BarbarianApp extends StatelessWidget {
  // This widget is the root of your application.
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

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Barbarian.init();

      await Future.delayed(Duration(seconds: 2));

      _brian..name = 'Frank';
      _brian.save();

      await Future.delayed(Duration(seconds: 2));

      _brian..name = 'Pierre';
      _brian.save();
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
              valueListenable: _brian.listen(),
              builder: (context, value, _) {
                print('value $value');
                return Text('Hi ${value?.name ?? ''}');
              },
            ),
          ],
        ),
      ),
    );
  }
}
