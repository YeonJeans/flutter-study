# [Flutter] 2. Flutter Layout

> @mori8

## 1. Container, Center, Align

### Container

 [Container](https://api.flutter.dev/flutter/widgets/Container-class.html)는 자식 위젯들을 커스터마이징할 수 있는 위젯 클래스로, 여백, 간격, 테두리 또는 배경색을 추가하고 싶을 때 사용한다.

```dart
Container(
  constraints: BoxConstraints.expand(
    height: Theme.of(context).textTheme.headline4!.fontSize! * 1.1 + 200.0,
  ),
  padding: const EdgeInsets.all(8.0),
  color: Colors.blue[600],
  alignment: Alignment.center,
  transform: Matrix4.rotationZ(0.1),
  child: Text('Hello World',
    style: Theme.of(context)
        .textTheme
        .headline4!
        .copyWith(color: Colors.white)),
)
```

컨테이너의 크기가 정의되는 규칙은 아래와 같다:

- 자식 위젯들에 대해 padding을 적용한 후 constraints를 적용한다.

- 위젯에 자식이 없고 `height`,  `width`, [constraints](https://api.flutter.dev/flutter/widgets/Container/constraints.html)가 없고 부모가 제한 없는 제약 조건을 제공하는 경우 [Container](https://api.flutter.dev/flutter/widgets/Container-class.html)는 최소 크기를 갖는다.

- 위젯에 자식이 없고 [Alignment](https://api.flutter.dev/flutter/widgets/Container/alignment.html)이 없지만 `height`, `width`또는  constraints가 있는 경우 컨테이너는 이러한 제약 조건과 부모 제약 조건의 조합을 고려하여 가능한 한 작은 크기를 갖는다.

- 위젯에 자식과 `height`, `width`, constraints, alignment 모두 없지만 부모가 제한된 제약 조건을 제공하는 경우 [Container](https://api.flutter.dev/flutter/widgets/Container-class.html) 는 부모가 내린 제약 조건에 맞게 확장된다.

- 위젯에 alignment가 있고 부모가 내린 constraint가 없는 경우 컨테이너는 자식을 중심으로 크기를 조정한다.

- 위젯에 alignment가 있고 부모의 constraints가 있는 경우 컨테이너는 부모에 맞게 확장하려고 시도한 다음 alignment에 따라 자식 위젯을 배치한다.



### Center, Align

- 가운데 정렬을 위해 `Center`를 사용한다.

```dart
Center(
	child:Container(
  		color: Colors.red,
  		width: 100,
  		height: 100
	)
)
```

- `Align`으로 정렬 방향을 다르게 지정할 수도 있다.

```dart
Align(
  alignment: Alignment.centerRight,
  child: Text('Text', style: TextStyle(
    color: Colors.white
  )),
)
```



### Constraint

- 위젯의 크기는 오직 부모로부터 받은 **contstraints에 의해서만 결정**된다.
- 위젯의 위치를 결정하는 건 부모이기 때문에 위젯은 자신의 위치를 결정하지 못한다.
- 부모의 크기와 위치도 역시 자신의 부모에 의존하기 때문에 전체 위젯 트리를 고려하지 않고 위젯의 크기와 위치를 정확하게 정의하는 것은 불가능하다.
- 부모가 충분한 정보를 제공 받지 않은 상태에서 자식의 사이즈를 변경하는 것은 불가능하다. 그러므로 **구체적으로 정렬을 정의하는 것이 중요**하다.





## 2. Responsive Layout

### Flexible

```dart
Flexible(
  flex: 1, // default
  fit: FlexFit.loose, // default, FlexFit.loose or Flexfit.tight
  child: Container(...),// required field
),
```

CSS의 `flex`와 거의 같은 개념이다. 하지만 CSS에서는 부모 컨테이너가 `display: flex` 속성을 가져야 자식 엘레먼트의 `flex` 관련 설정이 가능했으나, 플러터에서는 자식 위젯을 flex하게 만들기 위해 부모 컨테이너를 건들 필요는 없다. 그저 화면 크기에 따라 유동적으로 크기가 변하길 원하는 위젯을 `Flexible` 위젯의 child로 넣으면 된다. [참고](https://seosh817.tistory.com/83)

- `Flexfit.loose`: mainAxis의 남은 공간을 모두 채운다.
- `Flexfit.tight`: mainAxis의 남은 공간을 채우되 필요한 공간만 사용한다.



### Expended

`Flexfit.loose`와 같은 동작을 한다.

```dart
child: Column(
  children: [
    Expanded(
      child: Container(
        color: Colors.red,
      ),
      flex: 2,
    ),
    Text('hello'),
    Expanded(
      child:Container(
        color:Colors.green,
      ),
      flex: 1,
    ),
  ],
),
```



### LayoutBuilder

화면 크기에 따라 화면 구성에 변화를 줄 수 있다. 아래 코드에서 `MyStatelessWidget` > `build()` > 리턴 값의 `Scaffold` 중  `builder` 부분을 보자.

```dart
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: _title,
      home: MyStatelessWidget(),
    );
  }
}

class MyStatelessWidget extends StatelessWidget {
  const MyStatelessWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('LayoutBuilder Example')),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          if (constraints.maxWidth > 600) {
            return _buildWideContainers();
          } else {
            return _buildNormalContainer();
          }
        },
      ),
    );
  }

  Widget _buildNormalContainer() {
    return Center(
      child: Container(
        height: 100.0,
        width: 100.0,
        color: Colors.red,
      ),
    );
  }

  Widget _buildWideContainers() {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Container(
            height: 100.0,
            width: 100.0,
            color: Colors.red,
          ),
          Container(
            height: 100.0,
            width: 100.0,
            color: Colors.yellow,
          ),
        ],
      ),
    );
  }
}
```

