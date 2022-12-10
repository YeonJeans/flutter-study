import 'package:flutter/material.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';
import 'package:week3_flutter_exercise/home_detail.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter 3주차 스터디"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Center(
            child: Container(
              margin: EdgeInsets.only(top: 30.0, bottom: 30.0),
              alignment: Alignment.center,
              height: 200.0,
              width: 200.0,
              child: LiquidCircularProgressIndicator(
                value: 0.4,
                valueColor: AlwaysStoppedAnimation(Color(0xff86C4CC)),
                backgroundColor: Colors.white,
                borderColor: Color(0xff86C4CC),
                borderWidth: 0.0,
                direction: Axis.vertical,
                center: CircleAvatar(
                  backgroundImage: NetworkImage("https://user-images.githubusercontent.com/61380136/206864898-b5d99356-0bc3-44a8-85e1-470bc7ca8293.png"),
                  radius: 90.0,
                ),
              ),
            )
          ),

          ElevatedButton(
              onPressed: () => {
              Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomeDetailPage()),
              )
          },
              child: Text(
                "애니메이션 예제 실습"
              )
          ),

        ],
      ),

    );
  }
}
