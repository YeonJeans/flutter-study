# [Flutter] 1. Dart 시작하기

> 2022.11.25(금) - 2022.11.26(토) @mori8

## Dart 코드 작성 스타일 가이드

### [DO] class, enum, typedef 및 타입 매개변수 이름은 `UpperCamelCase`로 작성해야 한다.

이름은 `UpperCamelCase`로 작성합니다. 메타데이터 주석에 사용되는 클래스 또한 `UpperCamelCase`로 작성하나, 주석 클래스의 생성자가 매개변수를 사용하지 않는 경우 `lowerCamelCase` 상수를 생성할 수 있습니다.

```dart
class SliderMenu { ... }

class HttpRequest { ... }

typedef Predicate<T> = bool Function(T value);

// 메타데이터 주석에 사용되는 클래스도 UpperCamelCase를 사용합니다
class Foo {
  const Foo([Object? arg]);
}

@Foo(anArg)
class A { ... }

// 주석 클래스의 생성자가 매개변수를 사용하지 않는 경우에는 lowerCamelCase를 사용합니다
const foo = Foo();

@foo
class B { ... }
```



### [DO] extension명은 `UpperCamelCase`로 작성해야 한다.

```dart
extension MyFancyList<T> on List<T> { ... }
```



### [DO] 라이브러리, 패키지, 디렉터리 및 소스 파일명은 `lowercase_with_underscores`로 작성해야 한다.

일부 파일 시스템은 대소문자를 구분하지 않으므로 파일 이름을 모두 소문자로 지정해야 하고, 구분 문자를 사용해 형식에 맞춰 읽을 수 있도록 한다. `as`로 가져올 때에도 `lowercase_with_underscores` 방식을 사용한다.

```dart
library peg_parser.source_scanner;

import 'file_system.dart';
import 'slider_menu.dart';
import 'dart:math' as math;
import 'package:angular_components/angular_components.dart' as angular_components;
```



### [DO] 다른 식별자 이름은 `lowerCamelCase`로 작성한다.

클래스 멤버나 변수, 매개변수 등은 `lowerCamelCase`를 사용한다.

```dart
var count = 3;

HttpRequest httpRequest;

void align(bool clearItems) {
  // ...
}
```



### [PREFER] 상수명은 lowerCamelCase로 작성하자.

```dart
const pi = 3.14;
const defaultTimeout = 1000;
final urlScheme = RegExp('^([a-z]+):');

class Dice {
  static final numberGenerator = Random();
}
```





## 변수

`var` 키워드로 변수를 초기화할 시 변수에 할당된 값을 통해 타입을 추론하지만, 타입을 명시할 수도 있다. (`dynamic` 타입으로 선언하면 런타임 중 타입 변경이 가능하다) 초기화하지 않은 변수는 `null`을 갖는다. `null`에 대한 안전성을 보장하려면 값을 사용하기 전에 초기화해야 한다.

```dart
var name = 'Bob'; // String type
Object name = 'Bob';
int? linecount; // linecount = null
```



### `final` vs. `const`

`final`과 `const` 모두 상수를 만드는 데 사용한다는 공통점이 있으나, 런타임 중 값이 결정되는 상수는 `const`를 사용할 수 없고 `final`을 사용해야 한다.

- `final`: 런타임 상수
- `const`: 컴파일 타임 상수. `const` 상수 값 계산에 사용되는 값들은 `const` 상수이거나 숫자 혹은 문자열 리터럴이여야 한다.

```dart
final name = 'Jade';
const anotherName = 'Soo';
final today = DateTime.now();

const bar = 1000000;
const double atm = 1.1325 * bar;
```



## 숫자

Dart에는 `int`, `double` 타입이 있으며, `num` 타입으로 선언 시 정수와 실수 타입의 수를 모두 가질 수 있다.

```dart
int myAge = 22;
double myHeight = 168.1;

num myFavoriteNumber = 13;
myFavoriteNumber = 13.13;
```





### 문자열-숫자 변환

```dart
// String -> int
var one = int.parse('1');
assert(one == 1);

// String -> double
var onePointOne = double.parse('1.1');
assert(onePointOne == 1.1);

// int -> String
String oneAsString = 1.toString();
assert(oneAsString == '1');

// double -> String
String piAsString = 3.14159.toStringAsFixed(2);
assert(piAsString == '3.14');
```



## 문자열

작은따옴표 혹은 큰따음표를 사용하여 문자열을 만들 수 있다. 문자열 내에서 `${experssion}`를 사용하면 표현식의 값을 문자열 안에 넣을 수 있다. 표현식이 식별자일 경우 `{}`를 생략할 수 있다.

```dart
var s = 'string interpolation';

assert('Dart has $s, which is very handy.' ==
    'Dart has string interpolation, '
        'which is very handy.');
assert('That deserves all caps. '
        '${s.toUpperCase()} is very handy!' ==
    'That deserves all caps. '
        'STRING INTERPOLATION is very handy!');
```



## 리스트

Dart의 리스트 리터럴은 값을 쉼표로 구별해 대괄호(`[]`)로 묶은 목록으로 표시한다. 리스트는 0부터 인덱싱을 시작한다. 컴파일 타임 상수 리스트를 만드려면 리스트 리터럴 앞에 `const`를 붙인다. 추가로, Dart에서는 스프레드 연산자를 사용할 수 있다.

```dart
var list = [1, 2, 3];
var animals = ['Cat', 'Alpaca', 'Lion', ];

var myFavoriteAnimal = animals[0]; // 'Cat'

var constantList = const [1, 2, 3];
// constantList[1] = 13; // 에러 발생

var anotherList = [0, ...constantList];
```



## 맵

맵은 키와 값을 연결하는 개체로, 키와 값은 모든 타입의 객체가 될 수 있다. 키는 고유하지만 값은 동일한 값이 여러 번 사용될 수 있다.

```dart
var gifts = {
  // Key:    Value
  'first': 'partridge',
  'second': 'turtledoves',
  'fifth': 'golden rings'
};

var nobleGases = {
  2: 'helium',
  10: 'neon',
  18: 'argon',
};

var gifts = Map<String, String>();
gifts['first'] = 'partridge';
gifts['second'] = 'turtledoves';
gifts['fifth'] = 'golden rings';

var nobleGases = Map<int, String>();
nobleGases[2] = 'helium';
nobleGases[10] = 'neon';
nobleGases[18] = 'argon';
```



## 함수

Dart는 객체 지향 언어이므로 함수 또한 객체이며, 함수를 변수에 할당하거나 다른 함수에 인자로 전달할 수 있다. 클래스 내부에서 `call()` 메서드를 구현하여 Dart 클래스의 인스턴스를 함수처럼 호출할 수도 있다. ([callable classes](https://dart.dev/guides/language/language-tour#callable-classes) 참고) Dart는 하나의 표현식만 포함하는 함수에 대해 화살표 구문을 지원한다.



```dart
bool isNoble(int atomicNumber) { // 리턴 타입은 생략 가능하다
  return _nobleGases[atomicNumber] != null;
}

bool isNoble(int atomicNumber) => _nobleGases[atomicNumber] != null;
```



### 필수 파라미터와 네임드 파라미터

함수는 필수 파라미터와 **네임드 파라미터(선택 파라미터)**를 가질 수 있다. `{}`로 감싼 파라미터는 네임드 파라미터로써 선택적으로 사용할 수 있으며, default 값을 설정하지 않거나 인수를 넘겨주지 않으면 `null`이 된다.

```dart
/// Sets the [bold] and [hidden] flags ...
void enableFlags({bool? bold, bool? hidden}) {...}

/// Sets the [bold] and [hidden] flags ...
void enableFlags({bool bold = false, bool hidden = false}) {...}
```



### main() 함수

모든 Dart 애플리케이션의 최상위에는 앱의 진입점 역할을 하는 `main()` 함수가 있어야 한다. `main()`은 아무것도 반환하지 않으며, `List<String>` 타입의 매개변수를 선택적으로 받는다.

```dart
void main() {
  print('Hello, World!');
}
```

```dart
// Run the app like this: dart args.dart 1 test
void main(List<String> arguments) {
  print(arguments);

  assert(arguments.length == 2);
  assert(int.parse(arguments[0]) == 1);
  assert(arguments[1] == 'test');
}
```



## 클래스

Dart는 클래스와 혼합 기반(mixin-based) 상속을 가진 객체 지향 언어다. 모든 객체는 클래스의 인스턴스이며, `Null`을 제외한 모든 클래스는 `Object` 클래스를 상속받는다. 혼합 기반 상속은 모든 클래스가 하나의 부모 클래스를 가지더라도 클래스의 body는 여러 클래스 계층에서 재사용될 수 있음을 의미한다.

> mixin-based inheritance에 대한 더 자세한 정보는 [여기](https://velog.io/@jsj3282/%EB%AF%B9%EC%8A%A4%EC%9D%B8Mixin)로



### 인스턴스 변수

초기화되지 않은 모든 인스턴스 변수의 값은 `null`이다. 모든 인스턴스 변수는 암시적 getter 메서드를 생성하며, `final`, `late final`이 아닌 인스턴스 변수도 암시적 setter 메서드를 생성한다.

```dart
class Point {
  double? x; // Declare instance variable x, initially null.
  double? y; // Declare y, initially null.
  double z = 0; // Declare z, initially 0.
}
```



### 생성자

클래스와 동일한 이름을 가진 함수를 생성하여 생성자를 선언한다. 생성자를 선언하지 않으면 기본 생성자(인수 없음)가 제공되며, 상위 클래스에서 인수가 없는 생성자를 호출한다. **생성자는 상속되지 않으며, 생성자를 선언하지 않는 하위 클래스는 기본 생성자만 있다.**

```dart
class Point {
  double x = 0;
  double y = 0;

  Point(double x, double y) {
    // See initializing formal parameters for a better way
    // to initialize instance variables.
    this.x = x;
    this.y = y;
  }
}
```



### 네임드 생성자(Named Constructor)

네임드 생성자를 사용해 클래스에 대한 여러 생성자를 구현할 수 있다. 생성자는 상속되지 않기 때문에 상위 클래스에서 정의된 네임드 생성자를 사용하여 서브클래스를 만들려면 해당 생성자를 서브클래스에서 구현해야 한다.

```dart
const double xOrigin = 0;
const double yOrigin = 0;

class Point {
  final double x;
  final double y;

  Point(this.x, this.y);

  // Named constructor
  Point.origin()
      : x = xOrigin,
        y = yOrigin;
}

```



### 추상 메서드(abstract method)

인스턴스와 getter, setter 메서드는 추상일 수 있으며, 인터페이스를 정의하긴 하나 구현은 다른 클래스에 맡긴다.

```dart
abstract class Doer {
  // Define instance variables and methods...

  void doSomething(); // Define an abstract method.
}

class EffectiveDoer extends Doer {
  void doSomething() {
    // Provide an implementation, so the method is not abstract here...
  }
}
```



## 추상 클래스(abstract class)

인스턴스화할 수 없는 클래스인 추상 클래스를 정의할 수 있다.

```dart
// This class is declared abstract and thus
// can't be instantiated.
abstract class AbstractContainer {
  // Define constructors, fields, methods...

  void updateChildren(); // Abstract method.
}
```

