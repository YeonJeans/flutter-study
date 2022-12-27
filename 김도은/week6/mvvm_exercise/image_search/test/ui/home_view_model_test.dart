import 'package:flutter_test/flutter_test.dart';
import 'package:image_search/data/api.dart';
import 'package:image_search/model/photo.dart';
import 'package:image_search/ui/home_view_model.dart';

void main () {
  test('Stream이 잘 동작해야 한다.', () async {
    //의존되는 객체 PixabayApi에 의해 결과가 달라질 수 있음
    // PixabayApi가 실행되지 않을 경우, HomeViewModel이 실행되지 않음
    final viewModel = HomeViewModel(PixabayApi());

    viewModel.fetch('apple');

    expect(viewModel.photoStream,
        emitsInOrder([
          //Photo 타입의 리스트가 들어왔는지 확인
          isA<List<Photo>>()
        ]),
    );

  });
}
