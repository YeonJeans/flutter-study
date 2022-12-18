# HTTP 통신
## 1. HTTP 통신에 이용되는 패키지
``` dart
import 'package:http/http.dart' as http;
import 'dart:convert';
```
1) <code> import 'package:http/http.dart' as http; </code> <br/>
http 패키지는 http의 get, post, put 등과 같은 메소드들을 사용할 수 있도록 도와주는 패키지로 'as http'를 붙여 http 패키지의 메소드들을 호출할 때, 프리픽스를 붙여 호출하도록 하여 메소드를 더욱 명확하게 사용할 수 있도록 한다.
2) <code> import 'dart:convert'; </code> <br/>
dart:convert 패키지는 utf8을 지원해 주어 한글이 깨질 경우, 해당 패키지를 통해 한글이 깨지지 않도록 지원 받을 수 있다.
``` dart
var body = jsonDecode(utf8.decode(response.bodyBytes));
```

## 2. HTTP 통신 사용 예시
Flutter는 무언가 변경될 때마다 build() 메서드를 호출하기 때문에 네트워크 요청 코드를 build() 메서드 안이 아닌 initState()에서 호출하는 것이 좋다.

<br/>

\[ 인터넷에서 데이터 가져오는 방법 \]
1. http 패키지 추가하기. 
2. http 패키지를 사용하여 네트워크 요청 생성하기.
3. 응답 정보를 커스텀 Dart 객체로 변환하기.
4. 가져온 데이터를 Flutter에 보여주기.

<br/>

1\) get 메소드 사용 예시
``` dart
void userInfo() async {
    var url = Uri.http('${serverHttp}:8080', '/members/info');

    var response = await http.get(url, headers: {
      'Accept': 'application/json',
      "content-type": "application/json",
      "X-AUTH-TOKEN": "${authToken}"
    });
    
    if (response.statusCode == 200) {
      var body = jsonDecode(utf8.decode(response.bodyBytes));

      var data = body["response"];
      email = data["email"].toString();
      name = data["name"].toString();
    } 
    else {
      print('error : ${response.reasonPhrase}');
    }
}
```


2\) post 메소드 사용 예시
``` dart 
Future<void> changeName(String editName) async {
    var url = Uri.http('${serverHttp}:8080', '/members/name');

    final data = jsonEncode({'name': editName});

    var response = await http.patch(url, body: data, headers: {
      'Accept': 'application/json',
      "content-type": "application/json",
      "X-AUTH-TOKEN": "${authToken}"
    });

    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);
    } 
    else {
      print('error : ${response.reasonPhrase}');
    }
}
```
\* Future Class : 미래의 특정 시점에 사용 가능한 잠재적인 값이나 에러를 나타내기 위해 사용된다. 


