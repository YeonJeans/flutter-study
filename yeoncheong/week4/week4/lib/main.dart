import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class Person with ChangeNotifier {
  Person(this.name, this.age);

  final String name;
  int age;

  void increaseAge() {
    age++;
    notifyListeners();
  }

  Color changeColor() {
    Color color;
    age % 2 == 1 ? color = Colors.blueAccent : color = Colors.redAccent;
    return color;
  }
}

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => Person('name', 18),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Provider'),
          centerTitle: true,
        ),
        body: const Center(child: Details()),
        floatingActionButton: FloatingActionButton(
          onPressed: Provider.of<Person>(context, listen: false).increaseAge,
          backgroundColor:
              Provider.of<Person>(context, listen: false).changeColor(),
          child: Text('${Provider.of<Person>(context).age}'),
        ),
      ),
    );
  }
}

class Details extends StatelessWidget {
  const Details({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
        'Name : ${Provider.of<Person>(context).name}\nAge : ${Provider.of<Person>(context).age}');
  }
}
