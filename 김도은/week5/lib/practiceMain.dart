import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:audioplayers/audioplayers.dart';


class PracticeMainPage extends StatefulWidget {
  const PracticeMainPage({Key? key}) : super(key: key);

  @override
  State<PracticeMainPage> createState() => _PracticeMainPageState();
}


class _PracticeMainPageState extends State<PracticeMainPage> {

  final recoder = FlutterSoundRecorder();
  bool isRecorderReady = false;

  final audioPlayer = AudioPlayer();
  bool isPlaying = false;
  Duration duration = Duration.zero;
  Duration position = Duration.zero;

  String formatTime(Duration duration){
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));

    return [
      if (duration.inHours > 0) hours,
      minutes,
      seconds,
    ].join(':');

  }

  Future record() async {
    if (!isRecorderReady){
      return;
    }

    await recoder.startRecorder(toFile: 'audio');
  }

  Future stop() async {
    final path = await recoder.stopRecorder();
    final audioFile = File(path! as List<Object>);

    print('Recorded audio: ${audioFile}');
    await recoder.stopRecorder();
  }

  @override
  void initState() {
    super.initState();

    initRecorder();
    audioPlayer.onPlayerStateChanged.listen((state) {
      setState(() {
        //isPlaying = state == PlayerState.PLAYING;
      });
    });

    audioPlayer.onDurationChanged.listen((newDuration) {
      setState(() {
        duration = newDuration;
      });
    });

    audioPlayer.onAudioPositionChanged.listen((newPosition){
      setState(() {
        position = newPosition;
      });
    });
  }

  @override
  void dispose(){
    recoder.closeRecorder();
    audioPlayer.dispose();

    super.dispose();
  }

  Future initRecorder() async {
    final status = await Permission.microphone.request();

    if(status != PermissionStatus.granted) {
      throw 'Microphone permission not granted';
    }

    await recoder.openRecorder();

    isRecorderReady = true;
    recoder.setSubscriptionDuration(
      const Duration(microseconds: 500),
    );

  }

  Widget _beforeRecording(){
    return GestureDetector(
      onTap: () {
        print("clicked!");
      },
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: EdgeInsets.only(top: 59, bottom: 59),
        margin: EdgeInsets.only(top: 13),
        decoration: BoxDecoration(
            color: Color(0xff3E68A8),
            borderRadius: BorderRadius.circular(10)
        ),
        child: Center(
          child: Text("여기를 눌러 녹음하세요.",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Color(0xffFFFFFF),
                decoration: TextDecoration.none,
              )
          ),
        )
      ),
    );
  }

  Widget _Recording(){
    return GestureDetector(
      onTap: () {
        print("click!");
      },
      behavior: HitTestBehavior.opaque,
      child: Container(
          padding: EdgeInsets.only(top: 59, bottom: 59),
          margin: EdgeInsets.only(top: 13),
          decoration: BoxDecoration(
              color: Color(0xff3E68A8),
              borderRadius: BorderRadius.circular(10)
          ),
          child: Center(
            child: Text("여기를 눌러 녹음하세요.",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Color(0xff86C4CC),
                  decoration: TextDecoration.none,
                )
            ),
          )
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          alignment: Alignment.topLeft,
          image: AssetImage('images/bg_image.png'),
        ),
        color: Colors.white
      ),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              margin: EdgeInsets.only(left: 14.0, right:14.0, top: 32.0),
              padding: EdgeInsets.only(top:30.0, bottom: 30.0),
              decoration: BoxDecoration(
                  color: Color(0xffE5DDD2),
                  borderRadius: BorderRadius.circular(10)
              ),
              child: Center(
                child: Text(
                  "화장실은 어디에 있나요?",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Color(0xff333333),
                    decoration: TextDecoration.none,
                  ),

                ),
              ),
            ),

            Container(
                margin: EdgeInsets.only(left: 14.0, right:14.0, top: 33.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      Text("현재 수연님의 억양이에요.",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Color(0xff333333),
                          decoration: TextDecoration.none,
                        )
                      )
                    ],
                  ),

                  Container(
                    margin: EdgeInsets.only(left: 12.0, right:12.0, top: 16.0),
                    child: Row(
                      children: [
                        Text("00:00",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: Color(0xff666666),
                            decoration: TextDecoration.none,
                          ),
                        )
                      ],
                    ),
                  ),


                ],
              )
            ),

            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  StreamBuilder<RecordingDisposition>(
                    stream: recoder.onProgress,
                      builder: (context, snapshot) {
                        final duration = snapshot.hasData
                            ? snapshot.data!.duration
                            : Duration.zero;
                        
                        String twoDigits(int n) => n.toString().padLeft(2, '0');
                        final twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
                        final twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));

                        return Text('${twoDigitMinutes} : ${twoDigitSeconds}',
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.normal,
                            color: Color(0xff333333),
                            decoration: TextDecoration.none,
                          ),
                        );
                      },
                  ),
                  const SizedBox(height: 32),
                  ElevatedButton(
                    child: Icon(
                      recoder.isRecording ? Icons.stop : Icons.mic,
                      size: 80,
                    ),
                    onPressed: () async {
                      if (recoder.isRecording){
                        await stop();
                      }
                      else{
                        await record();
                      }

                      setState(() {

                      });
                    },
                  ),

                  Slider(
                      min: 0,
                      max: duration.inSeconds.toDouble(),
                      value: position.inSeconds.toDouble(),
                      onChanged: (value) async {
                        final position = Duration(seconds: value.toInt());
                        await audioPlayer.seek(position);

                        await audioPlayer.resume();
                      },
                  ),
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(formatTime(position)),
                        Text(formatTime(duration - position)),
                      ],
                    ),
                  ),
                  CircleAvatar(
                    radius: 35,
                    child: IconButton(
                      icon: Icon(
                        isPlaying ? Icons.pause : Icons.play_arrow,
                      ),
                      iconSize: 50,
                      onPressed: () async {
                        if(isPlaying){
                          await audioPlayer.pause();
                        }
                        else{
                          String url = '';
                          await audioPlayer.play(url);
                        }
                      },
                    ),
                  )
                ],
              )
            )


          ],
        ),
      ),
    );
  }
}