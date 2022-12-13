import 'dart:io';
import 'package:flutter/material.dart';
import 'dart:math';

class Map extends StatefulWidget {
  @override
  _MapState createState() => _MapState();
}

class _MapState extends State<Map> {
  var _size = 100.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('AnimatedContainer'),
        ),
        body: Center(
            child: GestureDetector(
                onTap: () {
                  final random = Random();
                  setState(() {
                    _size = random.nextInt(200).toDouble() + 100;
                  });
                },
                child: AnimatedContainer(
                  width: _size,
                  height: _size,
                  color: Colors.blue,
                  duration: Duration(seconds: 1),
                  curve: Curves.fastOutSlowIn,
                ))));
  }
}
