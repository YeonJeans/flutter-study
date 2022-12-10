import 'dart:async';

import 'package:flutter/material.dart';
import 'package:week3_flutter_exercise/home.dart';

void main() {
  runApp(new MaterialApp(
    home: new SplashScreen(),
    routes: <String, WidgetBuilder>{
      '/home': (BuildContext context) => new HomePage()
    },
  ));
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => new _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  startTime() async {
    var _duration = new Duration(seconds: 2);
    return new Timer(_duration, navigationPage);
  }

  void navigationPage() {
    Navigator.of(context).pushReplacementNamed('/home');
  }

  @override
  void initState() {
    super.initState();
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: new Container(
            color: Color(0xfff0f8ff),
            child: Center(
              child: Container(
                // alignment:Alignment.center,
                child: Text(
                  "스플래시 화면입니다.",
                  style: TextStyle(color: Color(0xff333333), fontSize: 11),
                ),
              ),
            )
        )
    );
  }
}