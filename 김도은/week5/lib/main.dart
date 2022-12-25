import 'dart:async';

import 'package:flutter/material.dart';
import 'package:recording_exercise/practiceMain.dart';

void main() {
  runApp(new MaterialApp(
    home: new SplashScreen(),
    routes: <String, WidgetBuilder>{
      '/practice': (BuildContext context) => new PracticeMainPage()
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
    Navigator.of(context).pushReplacementNamed('/practice');
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
                child: Image.asset('images/splash.jpg'),
              )
            )
        )
    );
  }
}