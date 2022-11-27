# Dart 기초 다지기

## 1. 자료형
\* 특이 사항: 타입이 결정된 변수는 이후에 타입을 변경할 수 없다.

### 1) 숫자
- int: 정수
- double: 부동 소수점 숫자
``` dart
int integerNumber = 1;
double floatingPointNumber = 1.8;
```

### 2) 문자열
- String: 문자열
``` dart
String greeting = "Hello World!"; 
```

### 3) Boolean
- bool: 참 또는 거짓 (true / false)
``` dart
bool isChecked = false;
```

### 4) List
- List : 중복을 허용하며, 순서가 있는 컬렉션 자료 구조
``` dart
List<int> numbers = [1, 2, 3, 2];
```

### 5) Set
- Set : 중복을 허용하지 않으며, 순서가 없는 컬렉션 자료 구조
``` dart
// 실제 numberSet의 요소로는 1, 2, 3이 존재하게 된다. 
// 집합에서는 순서가 없다. 
Set<int> numberSet = [1, 2, 3, 2];
```

### 6) Map
- Map: 키-값 쌍으로 구성된 자료 구조
``` dart
Map<String, int> students = {
  'doeun' : 12,
  'whaeun' : 25
};
```

## 2. 변수
### 1) var과 dynamic
Dart는 타입 추론 기능을 가지고 있어 자료형을 명시하지 않아도 자료형을 자동으로 지정해 준다. 
var의 경우, 추론된 타입이 한번 입력되고 나면 다른 타입을 저장할 수 없습니다. 반면, dynamic은 어떤 형식이라도 항상 입력이 가능하다.
``` dart
var greeting = "Hello World!";
dynamic greeting2 = "Hello World!!";
greeting2 = 2;
```

### 2) 자료형 명시
자료형을 별도로 명시하여 변수를 선언할 수 있다. 변수의 자료형을 선언해 놓았을 경우, 자료형에 맞는 값을 할당해 주어야 한다.
``` dart
String nickname = "Whaeun";
```

### 3) final
변수를 변경하지 않을 것이라는 의도를 담을 수 있다. 따라서 final 변수는 한 번만 설정된다. 하지만 final을 상수로 생각하기에는 무리가 있는데 바로 2번째 예시는 컴파일 에러를 발생시키지 않기 때문이다.
``` dart
// 1번째 예시
final number = 1;
```

``` dart
// 2번째 예시
final number = [1, 2, 3];
numbers.add(4); // [1, 2, 3, 4]
```

### 4) const
const 변수는 컴파일 타임 상수로, 한 번 설정되면 그 값을 변경할 수 없다. (완벽한 불변성)


``` dart
const number = [1, 2, 3];
numbers.add(4); // compile error 발생
```

</br>
출처: 파닥파닥 Flutter
