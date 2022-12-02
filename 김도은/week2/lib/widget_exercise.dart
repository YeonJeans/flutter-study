import 'package:flutter/material.dart';

class widgetExercise extends StatefulWidget {
  const widgetExercise({Key? key}) : super(key: key);

  @override
  State<widgetExercise> createState() => _widgetExerciseState();
}

enum RadioButton {
  radioButton1, radioButton2
}

const List<String> list = <String>[
  'dropdown1', 'dropdown2', 'dropdown3', 'dropdown4'
];


class _widgetExerciseState extends State<widgetExercise> {
  bool switchValue = true;
  bool isChecked = false;
  RadioButton? _character = RadioButton.radioButton1;
  double _currentSliderValue = 20;
  String dropdownValue = list.first;

  final TextEditingController _controller = new TextEditingController();

  Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return Colors.purple;
    }
    return Colors.blue;
  }

  final MaterialStateProperty<Color?> trackColor = MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states) {
      if (states.contains(MaterialState.selected)) {
        return Colors.blue;
      }
      return null;
    },
  );

  final MaterialStateProperty<Color?> overlayColor = MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states) {
      if (states.contains(MaterialState.selected)) {
        return Colors.amber.withOpacity(0.54);
      }
      if (states.contains(MaterialState.disabled)) {
        return Colors.grey.shade400;
      }
      return null;
    },
  );


  // 체크 박스, 라디오 버튼, Switch
  Widget selectButtonSection(){
    return Container(
        padding: const EdgeInsets.all(32),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                    "스위치 위젯 사용 연습",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Switch(
                  // This bool value toggles the switch.
                  value: switchValue,
                  overlayColor: overlayColor,
                  trackColor: trackColor,
                  thumbColor: MaterialStateProperty.all<Color>(Colors.black),
                  onChanged: (bool value) {
                    // This is called when the user toggles the switch.
                    setState(() {
                      switchValue = value;
                    });
                  },
                ),
              ],
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "체크박스 위젯 사용 연습",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Checkbox(
                  checkColor: Colors.white,
                  fillColor: MaterialStateProperty.resolveWith(getColor),
                  value: isChecked,
                  onChanged: (bool? value) {
                    setState(() {
                      isChecked = value!;
                    });},
                )
              ],
            ),

            Column(
              children: <Widget>[

                Text(
                  "\n라디오 버튼 위젯 사용 연습\n",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                ListTile(
                  title: const Text('라디오 버튼 1'),
                  leading: Radio<RadioButton>(
                    value: RadioButton.radioButton1,
                    groupValue: _character,
                    onChanged: (RadioButton? value) {
                      setState(() {
                        _character = value;
                      });
                    },
                  ),
                ),
                ListTile(
                  title: const Text('라디오 버튼 2'),
                  leading: Radio<RadioButton>(
                    value: RadioButton.radioButton2,
                    groupValue: _character,
                    onChanged: (RadioButton? value) {
                      setState(() {
                        _character = value;
                      });
                    },
                  ),
                ),
              ],
            ),



          ],
        )
    );
  }

  Widget sliderButtonSection() {
    return Column(
      children: [
        Text(
          "\n슬라이더 위젯 사용 연습\n",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        Container(
          padding: EdgeInsets.only(left: 35.0, right: 35.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                "슬라이더 값 :",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Text(
                "${_currentSliderValue}",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        Slider(
          value: _currentSliderValue,
          max: 100,
          divisions: 5,
          label: _currentSliderValue.round().toString(),
          onChanged: (double value) {
            setState(() {
              _currentSliderValue = value;
            });
          },
        )
      ],
    );
  }

  Widget dropdownButtonSection(){
    return Container(
      padding: EdgeInsets.only(left: 30.0, right: 30.0),
      child: Column(
        children: [
          Text(
            "\n드롭다운 버튼 위젯 사용 연습\n",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "드롭다운 값 : ${dropdownValue}",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
              DropdownButton<String>(
                value: dropdownValue,
                icon: const Icon(Icons.arrow_downward),
                elevation: 16,
                style: const TextStyle(color: Colors.blueAccent),
                underline: Container(
                  height: 2,
                  color: Colors.blue,
                ),
                onChanged: (String? value) {
                  // This is called when the user selects an item.
                  setState(() {
                    dropdownValue = value!;
                  });
                },
                items: list.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ],
          )
        ],
      )
    );

  }

  Widget textFieldSection(){
    return Column(
      children: [
        Text(
          "\n텍스트 필드 위젯 사용 연습\n",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        Container(
          padding: EdgeInsets.only(left: 30.0, right: 30.0),
          child: TextField(
            controller: _controller,
            onSubmitted: (String value) async {
              await showDialog<void>(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('입력 완료'),
                    content: Text(
                        '"$value"라고 타이핑했습니다. \n 텍스트의 길이는 ${value.characters.length}입니다.'),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('확인'),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        )
      ],
    );
  }


  @override
  Widget build(BuildContext context) {


    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Flutter Widget exercise'),
          automaticallyImplyLeading: true,
          leading: IconButton(
              icon: Icon(Icons.arrow_back_ios), onPressed: () {
                Navigator.pop(context);
          }),
        ),
        body: ListView(
          children: [
            selectButtonSection(),
            sliderButtonSection(),
            dropdownButtonSection(),
            textFieldSection(),
          ],
        ),
      ),
    );
  }
}
