import 'dart:async';

import 'package:image_search/data/api.dart';

import '../model/photo.dart';

class HomeViewModel {
  final PixabayApi api;

  // streamController에 데이터를 채움
  // ..add([])를 통해 빈 리스트를 추가 가능
  // ..은 void를 return하는 메소드를 사용하며 객체 레퍼런스를 반환할 수 있음
  final _photoStreamController = StreamController<List<Photo>>()..add([]);
  // 외부에서는 여기에 있는 스트림을 통해 변경을 확인하게 됨
  Stream<List<Photo>> get photoStream => _photoStreamController.stream;


  // 생성자에서 Pixabay를 받아 사용하는 방법으로 정의
  HomeViewModel(this.api);

  Future<void> fetch(String query) async {
    final result = await api.fetch(query);
    _photoStreamController.add(result);
  }
}