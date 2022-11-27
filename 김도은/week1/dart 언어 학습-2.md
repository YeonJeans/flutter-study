## 1. 함수
함수: 작업을 수행하는 코드 블록
### 1) 함수의 형식
``` dart
[반환형] [함수 이름] ([매개변수 타입] [매개 변수 이름], ...){
  // 함수 내용
  return [반환 값]
}
```
\* **화살표 구문** <br/>
함수의 구현이 한 줄로만 이루어졌을 때는 ```=>``` 기호를 사용하여 함수를 간단하게 정의할 수 있다.

### 2) 함수의 인자
Dart에서 함수는 일급 객체로 함수의 인자로 전달할 수 있다.
<br/>

\* **일급 객체** <br/>
다른 객체들에 일반적으로 적용 가능한 연산을 모두 지원하는 객체를 가리킨다. 변수에 할당할 수 있으며 다른 함수를 인자로 전달받을 수 있고 다른 함수의 결과로서 리턴될 수 있다.

``` dart
void printNumber(int number) {
    print(number);
}

// void processNumbers(List<int> numbers, Function(int) process)도 가능하다.
void processNumbers(List<int> numbers, Function process){
  for(int number in numbers){
    process(number);
  }
}

void main(){
  final numbers = [1, 2, 3];
  processNumbers(numbers, printNumber);
}
```

</br>
</br>


## 2. 임포트
특정 클래스나 전체 패키지를 사용하기 위해 사용한다. 패키지를 사용하면 이미 만들어진 함수나 클래스를 다시 구현할 필요가 없어진다.
- dart:io <br/>
File, socket, HTTP 등 서버 어플리케이션을 위한 I/O 지원을 제공한다. 
- dart:math <br/>
수학적 연산이 필요한 상수나 함수, 그리고 랜덤 숫자 생성기를 제공한다.
- dart:convert <br/>
서로 다른 데이터 표현(ex. JSON, UTF-8)간 변환을 위한 Encoders, Decoders를 제공한다.

</br>
</br>

## 3. 클래스
Dart는 클래스 및 믹스인 기반 상속을 지원하는 객체 지향 언어이다. 클래스는 속성과 행위를 갖는 객체를 추상화시킨 것으로 객체 지향 프로그래밍에서 중요한 요소이다.
### 1) 클래스 생성
Dart애서는 객체 생성 시 new 키워드를 생략하여 사용할 수 있다. 
``` dart
class Coffee {
  int price
  int shot;
  
  void describe(){
    print("Price is $price.");
  }
  
  getPrice(){
    return price;
  }
}

main(){
  var americano = Coffee();
  americano.price = 3000;
  print("americano's price is ${americano.getPrice()}");
}
```

### 2) 상속
부모 클래스가 가지고 있는 모든 것을 자식 클래스가 물려받아 같이 공유하며 나아가 확장하는 개념이다. 부모 클래스는 super class, 자식 클래스는 subclass라 표현하기도 한다.
- super </br>
부모 클래스를 참조하는 데 사용되며, super()를 사용하면 부모 클래스의 생성자가 호출된다. <code> super.메소드명 </code> 을 통해 부모 클래스에 있는 메소드를 호출할 수도 있다.
- 단일 상속 </br>
Dart에서는 다중 상속을 지원하지 않아 ```extends``` 키워드를 통해 여러 개의 부모 클래스를 가질 수 없다.
- 오버라이딩 </br>
부모 클래스의 메소드를 자식 클래스에서 재정의하여 사용할 수 있다.

``` dart
class Latte extends Coffee {
  int milk;
  
  Latte(int shot, this.milk) : super(shot) {
    price = shot * 1000 + milk *500;
  }
}

void main() {
  var coffee = Coffee(2);
  coffee.describe();
  coffee = Latte(2,3);
  coffee.describe();
}
```

### 3) 추상 클래스
추상 클래스는 추상 메서드를 포함하는 클래스를 의미하며 여기서 말하는 추상 메서드는 선언만되고 정의가 없는 메서드를 의미한다. 추상 클래스는 그대로 인스턴스화할 수 없어 다른 클래스에서 구현하여 기능을 완성하는 상속 재료로 사용된다.
``` dart
abstract class Coffee {
  int price;
  int shot;
  
  Coffee(this.shot) {
    price = shot * 1000;
  }
  
  void description();
}

class Americano extends Coffee {
  Americano(int shot) : super(shot);
  
  @override
  void description(){
    print("Americano는 밤샘의 필수 준비물입니다.");
  }
}

void main() {
  var americano = Americano(2);
  americano.descrioption();
}
```
</br>
</br>

출처: 파닥파닥 Flutter
