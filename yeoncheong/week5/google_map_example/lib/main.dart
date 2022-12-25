import 'package:flutter/material.dart';
import 'map_sample.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Google Maps Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const MapSample(),
    );
  }
}
